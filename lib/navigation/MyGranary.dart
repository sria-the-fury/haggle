import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/utilities/GesturedCard.dart';

var _selectOptionBid = false;
var _selectOptionItem = true;

class MyGranary extends StatefulWidget {

  @override
  _MyGranaryState createState() => _MyGranaryState();
}

class _MyGranaryState extends State<MyGranary> {

  Widget build(BuildContext context) {

    User? currentUser = FirebaseAuth.instance.currentUser;

    var raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: _selectOptionBid ? Colors.white : Colors.blue[500] ,
      primary: _selectOptionBid ? Colors.blue[500] : Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

    var raisedButtonStyle2 = ElevatedButton.styleFrom(
      onPrimary: _selectOptionItem ? Colors.white : Colors.blue[500] ,
      primary: _selectOptionItem ? Colors.blue[500] : Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: raisedButtonStyle2,
                    onPressed: () {
                      setState(() {
                        _selectOptionBid = false;
                        _selectOptionItem = true;
                      });

                    }
                    ,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Icon(
                            Icons.sell,
                            color: _selectOptionItem ? Colors.white : Colors.blue[500],
                            size: 20.0,
                          ),
                          Text('My Items', style: TextStyle(fontSize: 18),)
                        ],

                      ),
                    )
                ),
                ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      setState(() {
                        _selectOptionItem = false;
                        _selectOptionBid = true;
                      });


                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Icon(
                            Icons.attach_money,
                            color: _selectOptionBid ? Colors.white : Colors.blue[500],
                            size: 20.0,
                          ),
                          Text('My Bids', style: TextStyle(fontSize: 18),)
                        ],

                      ),
                    )
                )

              ],
            ),
          ),
        ),
        body: _selectOptionItem ? StreamBuilder <QuerySnapshot> (
            stream: FirebaseFirestore.instance
                .collection('items').where('userId', isEqualTo: currentUser!.uid).snapshots(includeMetadataChanges: true),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.hasData);

              return snapshot.hasData ?
              GesturedCard(snapshot.data!.docs) :
              Center( child: CircularProgressIndicator(color: Colors.blue[500],));
            }
        ) :
        Container(
          child: StreamBuilder <QuerySnapshot> (
            stream: FirebaseFirestore.instance
                .collection('items').where('bidUsers', arrayContains: [currentUser!.uid]).snapshots(includeMetadataChanges: true),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

              return snapshot.hasData ?
              GesturedCard(snapshot.data!.docs) :
              Center( child: CircularProgressIndicator(color: Colors.blue[500],));
            },
          ),

        ));
  }
}