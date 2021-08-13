import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haggle/imports/firebase/BidsManagement.dart';

class BottomModal extends StatefulWidget {
  final int lowestBidPrice;
  final String itemId;
  final String userId;
  final int userBidPrice;
  final String modalType;

  const BottomModal(this.lowestBidPrice, this.itemId, this.userId, this.userBidPrice, this.modalType);

  @override
  _BottomModalState createState() => _BottomModalState();
}


class _BottomModalState extends State<BottomModal> {
  late String price = '0';
  @override
  Widget build(BuildContext context) {

    var lowestBidPrice = widget.lowestBidPrice.toString();
    var itemId = widget.itemId;
    var userId = widget.userId;
    var userBidPrice = widget.userBidPrice.toString();
    var modalType = widget.modalType;

    print('userId =>  $userId');
    print('modalType =>  $modalType');
    print('userBidPrice =>  ${userBidPrice.toString()}');


    User? user = FirebaseAuth.instance.currentUser;
    return new Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: modalType == 'EDIT' ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.remove_circle,
                  color: Colors.blue[500], size: 30,),
                onPressed: () => Navigator.pop(context),

              ),
            ),
            Container(
              child: Text('Min bid price : \$$lowestBidPrice'),
            ),

            Container(
                child: Row(
                  children: [

                  ],
                )
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.number,

              onChanged: (text) {
                if(text.length >= 1 ) setState(() {
                  price = text;
                });
                print('First text field: $price');

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  disabledColor: Colors.grey,
                  icon: Icon(Icons.monetization_on, size: 35,),
                  onPressed: int.parse(lowestBidPrice) <= int.parse(price) ? () {
                    BidsManagement().makeBid(price, user, itemId);
                    Navigator.pop(context);
                  } : null,
                ),
                hintText: 'Make your bid',
              ),
            ),
          ]
      ) : modalType == 'UPDATE' ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.remove_circle,
                  color: Colors.blue[500], size: 30,),
                onPressed: () => Navigator.pop(context),

              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Min bid price : \$$lowestBidPrice'),
                  Text('You have bid : \$$userBidPrice'),
                ],
              )

            ),

            Container(
                child: Row(
                  children: [

                  ],
                )
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.number,

              onChanged: (text) {
                if(text.length >= 1 ) setState(() {
                  price = text;
                });
                print('First text field: $price');

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  disabledColor: Colors.grey,
                  icon: Icon(Icons.monetization_on, size: 35,),
                  onPressed: int.parse(lowestBidPrice) <= int.parse(price) ? () {
                    BidsManagement().updateBid(price, userId, itemId);
                    Navigator.pop(context);
                  } : null,
                ),
                hintText: '\$$userBidPrice',
              ),
            ),
          ]
      ) : Container() ,
    );
  }
}



