
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haggle/imports/utilities/AuctionTime.dart';
import 'package:haggle/imports/firebase/BidsManagement.dart';
import 'package:haggle/imports/utilities/CupertinoItems.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/firebase/FirebaseStorageApi.dart';
import 'package:uuid/uuid.dart';

class AddItemModal extends StatefulWidget {
  @override
  _AddItemModalState createState() => new _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {

  bool isLessTime = false;

  String _itemName='';
  String _itemDesc='';
  String _minBidPrice='';

  DateTime dateTime = DateTime.now();


  UploadTask? task;
  List<File>? files;
  List<Object> imagesAsUrl =[];
  User? currentUser = FirebaseAuth.instance.currentUser;


  Future _selectFile () async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if(result != null ){
      List<File> filesPath = result.paths.map((path) => File(path!)).toList();
      setState(() => files =  filesPath);
    } else return;

  }

  Future _uploadFile() async{
    if(files != null){

      final itemId = Uuid().v4();


      files!.map((file) async {
        final imageId = Uuid().v4();
        final fileDestination = 'files/$itemId/$imageId';
        task = FirebaseStorageApi.uploadFile(fileDestination, file);
        setState(() {

        });
        if(task != null) {
          final snapshot = await task!.whenComplete(() => {});
          final urlDownload = await snapshot.ref.getDownloadURL();
          imagesAsUrl.add({
            'imageId': imageId,
            'imageUrl': urlDownload
          });

          if(files!.length == imagesAsUrl.length){
            BidsManagement().addItem(_itemName, _itemDesc, _minBidPrice, dateTime, currentUser!.uid, imagesAsUrl, itemId);
            Navigator.pop(context);

          }

        } else return;

      }).toList();

    } else return;

  }

  //for further use

  // Widget buildUploadStatus(UploadTask task){
  //   return StreamBuilder<TaskSnapshot>(
  //       stream: task.snapshotEvents,
  //       builder: (context, snapshot){
  //         if(snapshot.hasData){
  //           final snap = snapshot.data!;
  //           final progress =  snap.bytesTransferred/ snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(0);
  //           return Text('$percentage%');
  //
  //         } else return Container();
  //
  //       });
  //
  // }



  Widget buildDatePicker() => SizedBox(
      height: 270,
      child: CupertinoDatePicker(
        minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.dateAndTime,
        onDateTimeChanged: (dateTime) => {
          setState(() => this.dateTime = dateTime)
        },
      )

  );



  @override
  Widget build(BuildContext context) {

    _checkIfFileMore(){
      if(files != null) return files!.length <= 2;
      else return true;

    }

    disableSubmit(){
      return _itemName == '' || _itemDesc == '' || _minBidPrice =='' || _checkIfFileMore();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('ADD ITEM'),
        actions: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(right: 15.0),
                  child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        enableFeedback: true,
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.blue[500],
                        onPressed: () async { await _selectFile();},
                      )
                  )
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child:Column(
              children: [

                Center(
                    child: files != null && files!.length > 2?
                    CarouselSlider(
                      options: CarouselOptions(height: 220.0, enableInfiniteScroll: true),
                      items: files!.map<Widget>((image) {
                        print(image.path);
                        return new Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: FileImage(File(image.path)),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ) : Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3)
                            )
                          ]
                      ),
                      child: Center(
                          child : Text('ADD AT LEAST 3 IMAGES', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                      ),
                    )

                ),
                SizedBox(height: 25.0),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text('ADD PRODUCT INFORMATION', textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 10.0),

                TextFormField(
                  onChanged: (itemName) => {
                    setState(() => {
                      _itemName = itemName
                    })},
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    // errorText: 'Error message',
                    border: OutlineInputBorder(),

                    prefixIcon: Icon(Icons.category),
                  ),
                ),

                SizedBox(height: 25,),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,//Normal textInputField will be displayed
                  maxLines: 4,
                  onChanged: (descText) => {
                    setState(() => {
                      _itemDesc = descText
                    })},
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    // errorText: 'Error message',
                    border: OutlineInputBorder(),

                    prefixIcon: Icon(Icons.description),
                  ),
                ),
                SizedBox(height: 25,),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Minimum Bid Price',
                    // errorText: 'Error message',
                    border: OutlineInputBorder(),

                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  onChanged: (minBidPrice) => {
                    setState(() => {
                      _minBidPrice = minBidPrice
                    })},
                ),
                SizedBox(height: 60,),

                ElevatedButton.icon(
                  icon: Icon(Icons.event, color: Colors.white, size: 35.0),
                  onPressed: () =>
                      CupertinoItems.
                      showSheet(context, child: buildDatePicker(),
                          onClicked: () {
                            Navigator.pop(context);
                            if(dateTime.minute < DateTime.now().minute + 9 && dateTime.hour ==  DateTime.now().hour){
                              setState(() {
                                isLessTime = true;
                              });
                            } else  setState(() {
                              isLessTime = false;
                            });
                          }),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(88, 45)
                  ),

                  label: Text('SELECT AUCTION END DATE', style: TextStyle(fontSize: 20),),
                ),


                if(isLessTime) Text(
                  'TIME SHOULD BE 10 MIN OR MORE FROM NOW', style: TextStyle(fontSize: 12, color: Colors.red[500]),
                ),
                SizedBox(height: 25),

                if (dateTime.minute > ((DateTime.now().minute)+10) || dateTime.hour > DateTime.now().hour) Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal:5.0, vertical: 5.0),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue[500],
                    ),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                                children:[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                    child: Text('AUCTION WILL BE END', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Colors.white)),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[

                                            Container(
                                              child: ElevatedButton.icon(
                                                icon: Icon(Icons.add, color: disableSubmit() ? Colors.grey : Colors.white , size: 20.0),
                                                onPressed: disableSubmit() ? null : () async
                                                {
                                                  try{

                                                    await _uploadFile();
                                                    CupertinoItems.showSuccessSnackBar(context, 'ITEM ADDED SUCCESSFULLY');
                                                  } catch(e) {
                                                    CupertinoItems.showErrorSnackBar(context, 'ITEM NOT ADDED ${e.toString()}');
                                                  }

                                                },
                                                style: ElevatedButton.styleFrom(
                                                  onPrimary: Colors. white,
                                                  primary: Colors.green[500],
                                                  minimumSize: Size(88, 36),
                                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                ),

                                                label: Text('ADD ITEM', style: TextStyle(fontSize: 15),),
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(AuctionTime().getAuctionPostedTime(dateTime), style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color:  Colors.white)),
                                            ),

                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                      ],
                    )
                ) ,

              ],
            )
        ),
      ),
    );
  }
}