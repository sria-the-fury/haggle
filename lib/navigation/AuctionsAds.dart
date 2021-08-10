
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/modals/AddItemModal.dart';
import 'package:haggle/utilities/GesturedCard.dart';


class AuctionsAds extends StatefulWidget {

  @override
  _AuctionsAdsState createState() => _AuctionsAdsState();
}

class _AuctionsAdsState extends State<AuctionsAds> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userImage = user?.photoURL;



    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Haggle BD', textAlign: TextAlign.left),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/profilePage');
              },
              child: userImage != null ? Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3)
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:NetworkImage(userImage),
                      fit: BoxFit.fill,
                    )
                ),
              ) : Center(child: CircularProgressIndicator(color: Colors.white)),
            )  ,

          ],
        ),
      ),
      body: StreamBuilder <QuerySnapshot> (
          stream: FirebaseFirestore.instance
              .collection('items').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

            return snapshot.data != null ? ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map<Widget>((item){

                return GesturedCard().card(item, context);
              }).toList(),
            ) : Center( child: CircularProgressIndicator(color: Colors.blue[500],));
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new AddItemModal();
              },
              fullscreenDialog: true
          ));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
