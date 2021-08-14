
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/modals/AddItemModal.dart';
import 'package:haggle/imports/utilities/GesturedCard.dart';
import 'package:haggle/navigation/ProfilePage.dart';
import 'package:lottie/lottie.dart';


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
            Container(
              child: Row(
                children: [
                  Center(
                      child:Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3)
                                )
                              ]
                          ),
                          child:Lottie.asset('assets/auction_lottie_haggle-bd.json')
                      )
                  ) ,
                  Text('Haggle BD', textAlign: TextAlign.left),
                ],
              )
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                  return new ProfilePage();
                }));
                //Navigator.of(context).pushNamed('/profilePage');
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
              .collection('items').where('userId', isNotEqualTo: user!.uid, ).snapshots(includeMetadataChanges: true),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data!.docs);

            return snapshot.data != null && snapshot.data!.docs.length > 0 ? GesturedCard(snapshot.data!.docs) : Center( child: CircularProgressIndicator(color: Colors.blue[500],));
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
