
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
class FirebaseStorageApi{

  static UploadTask? uploadFile(String destination, File file){
    
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    }
    on FirebaseException catch (e){
      return null;
    }

  }


  // for further use

  // static UploadTask? uploadBytes(String destination, Uint8List data){
  //   try{
  //    final ref = FirebaseStorage.instance.ref(destination);
  //     return ref.putData(data);
  //   } on FirebaseException catch(e) {
  //     return null;
  //   }
  // }
}