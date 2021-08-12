
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haggle/utilities/AuctionTime.dart';
import 'package:haggle/utilities/BidsManagement.dart';
import 'package:haggle/utilities/CupertinoItems.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class AddItemModal extends StatefulWidget {
  @override
  _AddItemModalState createState() => new _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {

  List<XFile>? _imageFileList;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }
  bool isLessTime = false;

  String _itemName='';
  String _itemDesc='';
  String _minBidPrice='';

  DateTime dateTime = DateTime.now();

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImagesButtonPressed(ImageSource source, {
    BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage(
            maxHeight: 800,
            maxWidth: 800,
            imageQuality: 100
        );
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }


  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return CarouselSlider(

        options: CarouselOptions(height: 220.0, enableInfiniteScroll: true),
        items: _imageFileList!.map<Widget>((image) {
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
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
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
            child : Text('ADD IMAGES AT LEAST 3')
        ),
      );
    }
  }

  Widget _handlePreview() {

    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }


  DateTime _date = DateTime.now();


  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }


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

    User? currentUser = FirebaseAuth.instance.currentUser;

    print('Min Bid =>$_minBidPrice');
    print('_itemDesc =>$_itemDesc');
    print('_itemName =>$_itemName');

    disableSubmit(){
      return _itemName == '' || _itemDesc == '' || _minBidPrice =='';
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('ADD ITEM'),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(Icons.add_photo_alternate, size: 30.0,),
                tooltip: 'ADD IMAGES',
                enableFeedback: true,
                onPressed: () {
                  _onImagesButtonPressed(
                    ImageSource.gallery, context: context, isMultiImage: true,);
                },
              )
          )
          ,
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child:Column(
              children: [

                Center(
                    child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container(
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
                                  child : Text('ADD IMAGES AT LEAST 3')
                              ),
                            );
                          case ConnectionState.done:
                            return _handlePreview();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container(
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
                                    child : Text('ADD IMAGES AT LEAST 3')
                                ),
                              );
                            }
                        }
                      },
                    )

                        : _handlePreview()),
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
                SizedBox(height: 20,),

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
                                                    BidsManagement().addItem(_itemName, _itemDesc, _minBidPrice, dateTime, currentUser!.uid);
                                                    CupertinoItems.showSnackBar(context, 'ITEM ADDED SUCCESSFULLY');
                                                  } catch(e) {
                                                    CupertinoItems.showSnackBar(context, 'ITEM NOT ADDED');
                                                  }
                                                  finally{
                                                    Navigator.pop(context);
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
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}