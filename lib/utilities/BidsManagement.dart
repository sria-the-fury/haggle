import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haggle/utilities/FlutterToast.dart';

class BidsManagement{
  makeBid(bidPrice, user, itemId) async {
    try{
      await FirebaseFirestore.instance.
      collection('items').
      doc(itemId).
      collection('bid-users')
          .add({
        'bidPrice': bidPrice,
        'userId': user.uid,
        'itemId': itemId,
        'bidAt': DateTime.now()
      });
    }catch(e){
      FlutterToast().errorToast('@store :', 'BOTTOM', 14.0, e);
    }
    finally{
      FlutterToast().successToast('Bid has been made', 'BOTTOM', 14.0, null);
    }

  }


}