import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haggle/utilities/CupertinoItems.dart';
import 'package:haggle/utilities/FlutterToast.dart';

class BidsManagement{
  makeBid(bidPrice, user, itemId) async {
    try{
      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .collection('bid-users')
          .add({
        'bidPrice': int.parse(bidPrice),
        'userId': user.uid,
        'itemId': itemId,
        'bidAt': DateTime.now()
      });

      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .set({
        'bidUsers': FieldValue.arrayUnion([user.uid])

      }, SetOptions(merge: true));
    }catch(e){
      FlutterToast().errorToast('@store :', 'BOTTOM', 14.0, e);
    }
    finally{
      FlutterToast().successToast('Bid has been made', 'BOTTOM', 14.0, null);
    }

  }

  addItem(itemName, itemDesc, bidPrice, bidEndTime, userId) async{
    try{
      await FirebaseFirestore.instance.
      collection('bid-items')
          .doc()
          .set({
        'itemName': itemName,
        'itemDesc': itemDesc,
        'lastBidTime': bidEndTime,
        'minBidPrice': int.parse(bidPrice),
        'userId': userId,
        'bidAt': DateTime.now()
      });
    } catch(e) {
      print(e.toString());
    }
    finally{

    }

  }


}