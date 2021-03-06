import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haggle/imports/utilities/FlutterToast.dart';

class BidsManagement {
  makeBid(bidPrice, user, itemId) async {
    try {
      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .collection('bid-users').doc(user.uid)
          .set({
        'bidPrice': int.parse(bidPrice),
        'userId': user.uid,
        'itemId': itemId,
        'bidAt': DateTime.now()
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .set({
        'bidUsers': FieldValue.arrayUnion([user.uid])
      }, SetOptions(merge: true));
    } catch (e) {
      FlutterToast().errorToast('@store :', 'BOTTOM', 14.0, e);
    }
    finally {
      FlutterToast().successToast('Bid has been made', 'BOTTOM', 14.0, null);
    }
  }

  updateBid(editedBidPrice, userId, itemId) async {
    try {
      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .collection('bid-users').doc(userId)
          .update({
        'bidPrice': int.parse(editedBidPrice),
        'bidAt': DateTime.now()
      });
    } catch (e) {
      FlutterToast().errorToast('@store :', 'BOTTOM', 14.0, e);
    }
    finally {
      FlutterToast().successToast('Bid has been updated', 'BOTTOM', 14.0, null);
    }
  }

  addItem(itemName, itemDesc, bidPrice, bidEndTime, userId, images,
      itemId) async {
    try {
      await FirebaseFirestore.instance.
      collection('items')
          .doc(itemId)
          .set({
        'itemName': itemName,
        'itemId': itemId,
        'itemImages': images,
        'itemDesc': itemDesc,
        'isCompleted': false,
        'lastBidTime': bidEndTime,
        'bidUsers': [],
        'minBidPrice': int.parse(bidPrice),
        'userId': userId,
        'bidAt': DateTime.now()
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
    finally {

    }
  }

  auctionCompleted(itemId) async {
    try {
      await FirebaseFirestore.instance.collection('items').doc(itemId).update({
        'isCompleted': true
      });
    } catch (e) {
      print(e.toString());

    }
  }

}