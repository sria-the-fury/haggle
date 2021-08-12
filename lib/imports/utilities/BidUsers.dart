import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BidUsers extends StatefulWidget {
  final String itemId;
  BidUsers(this.itemId);

  @override
  _BidUsersState createState() => _BidUsersState();
}

class _BidUsersState extends State<BidUsers> {
  @override
  Widget build(BuildContext context) {
    var itemId = widget.itemId;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').doc(itemId).collection('bid-users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData ){
            return Text((snapshot.data!.docs.length).toString());
          } else return Text('Loading Data');
        }

    );
  }
}
