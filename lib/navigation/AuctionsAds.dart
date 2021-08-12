
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/modals/AddItemModal.dart';
import 'package:haggle/imports/utilities/GesturedCard.dart';


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
              child:  CircleAvatar(
                backgroundImage: NetworkImage(userImage.toString()),
                radius: 25,
              ),
            )

          ],
        ),
      ),
      body: StreamBuilder <QuerySnapshot> (
          stream: FirebaseFirestore.instance
              .collection('items').orderBy('createdAt',descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

            return snapshot.data != null ? ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map<Widget>((item){

                return GesturedCard(item);
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
