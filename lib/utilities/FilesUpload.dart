import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:haggle/utilities/FirebaseApi.dart';
import 'package:path/path.dart';


class FilesUpload extends StatefulWidget {

  @override
  _FilesUploadState createState() => _FilesUploadState();
}

class _FilesUploadState extends State<FilesUpload> {
  UploadTask? task;
  File? file;


  Future _selectFile () async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null ){
      File singleFile = File((result.files.single.path).toString());
      setState(() => file =  singleFile);
    } else return;

  }

  Future _uploadFile() async{
    if(file != null){

      final fileName = basename(file!.path);
      final fileDestination = 'files/$fileName';
      task = FirebaseApi.uploadFile(fileDestination, file!);
      setState(() {

      });
      if(task != null) {
        final snapshot = await task!.whenComplete(() => {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        print('Download URL =>  $urlDownload');

      } else return;

    } else return;

  }

  Widget buildUploadStatus(UploadTask task){
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
        builder: (context, snapshot){
        if(snapshot.hasData){
          final snap = snapshot.data!;
          final progress =  snap.bytesTransferred/ snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(0);
          return Text('$percentage%');

        } else return Container();

        });

  }


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'no image';


    return Scaffold(
      appBar: AppBar(
        title: Text('UPLOAD FILE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(120.0, 15),
                  backgroundColor: Colors.blue[500],
                  primary: Colors.white,
                ),
                onPressed: () {
                  _selectFile();
                }, child: Text('PICK')
            ),
            SizedBox(height: 5,),

            Text(fileName),
            SizedBox(height:35,),

            TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(120.0, 15.0),
                  backgroundColor: Colors.blue[500],
                  primary: Colors.white,
                ),
                onPressed: () { _uploadFile();}, child: Text('UPLOAD')
            ),
            SizedBox(height: 30,),
            task != null ? buildUploadStatus(task!) : Container(),
          ],
        ),
      ),
    );
  }
}
