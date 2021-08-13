import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haggle/imports/utilities/FlutterToast.dart';

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

  getPostedUser(userId, isFullName, avatarSize, fontSize, colorWhite, isFontBold, isRow) {

    return new StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            return isRow ? Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData!['photoURL'],),
                    radius: avatarSize,
                  ),
                  SizedBox(width: 5,),
                  getName(userData['userName'], isFullName, fontSize, colorWhite, isFontBold)
                ]
            ) : Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData!['photoURL'],),
                    radius: avatarSize,
                  ),
                  SizedBox(width: 5,),
                  getName(userData['userName'], isFullName, fontSize, colorWhite, isFontBold)
                ]
            );

          }
          else {
            return Text('Loading');
          }
        }
    );
  }

  getName(name, naming, fontSize, colorWhite, isFontBold,) {
    List<String> nameList = name.split(" ");

      if(naming == 'SHORT_NAME'){
        return Text(nameList[0],
            style: TextStyle(fontSize: fontSize, fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal, color: colorWhite ? Colors.white : Colors.black.withOpacity(0.7)));
      } else if(naming == "MODERATE_NAME"){
        return Text(nameList[0] + ' '+nameList[1], style: TextStyle(fontSize: fontSize, fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal, color: colorWhite ? Colors.white : Colors.black.withOpacity(0.7)));
      } else return Text(name, style: TextStyle(fontSize: fontSize, fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal, color: colorWhite ? Colors.white : Colors.black.withOpacity(0.7)));
    }

}
