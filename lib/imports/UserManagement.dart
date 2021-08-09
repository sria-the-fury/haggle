import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haggle/utilities/FlutterToast.dart';

class UserManagement {
  storeNewUser (user) async{

    try{
      await FirebaseFirestore.instance.collection('/users').doc(user.uid).set({
        'email': user.email,
        'userId': user.uid,
        'photoURL': user.photoURL,
        'joinedAt': DateTime.now()
      });
    }catch(e){
      FlutterToast().errorToast('@store :', 'BOTTOM', 14.0, e);
    }
    finally{
      FlutterToast().successToast('user added', 'BOTTOM', 14.0, null);
    }
  }
}
