import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haggle/utilities/FlutterToast.dart';

class UserManagement {
  storeNewUser (user) async{

    try{
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'userId': user.uid,
        'userName': user.displayName,
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

  getUserPostedUser(userId) {

    return new StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData!['photoURL'],),
                        radius: 10,
                      ),
                      SizedBox(width: 5,),
                      Text(userData['userName'], style: TextStyle(fontSize: 14),)
                    ]
              );

          }
          else {
            return Text('Loading');
          }
        }
    );
  }
}
