import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:haggle/imports/utilities/BidsDataTable.dart';
import 'package:haggle/imports/utilities/AuctionTime.dart';
import 'package:haggle/imports/modals/BottomModal.dart';
import 'package:haggle/imports/utilities/Carousel.dart';


class BidsItemDetails extends StatefulWidget {
  final itemDetails;
  BidsItemDetails({@required this.itemDetails});
  @override
  _BidsItemDetailsState createState() => _BidsItemDetailsState();
}

class _BidsItemDetailsState extends State<BidsItemDetails> {

  var hasBid;

  @override
  Widget build(BuildContext context) {
    var details = widget.itemDetails;


    User? user = FirebaseAuth.instance.currentUser;

    _hasUserBid(bidUsers) {


    }


    return Scaffold(
      appBar: AppBar(
        title: Text('DETAILS'),
      ),
      body: Container(
          child:  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('items').doc(details['itemId']).snapshots(includeMetadataChanges: true),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){

              if (snapshot.hasData){

                var item = snapshot.data!.data();
                var bidUsers = item!['bidUsers'];

                var hasBidUser = bidUsers.contains(user!.uid) ? true : false;


                return new ListView(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          SizedBox(height: 5,),
                          Carousel().imageCarousel(item['itemImages'], 220.0),
                          Container(
                            child: AuctionTime().getCountDown(details['lastBidTime']),
                          ),

                          Container(
                              margin: EdgeInsets.symmetric( horizontal: 10.0, vertical: 5.0),
                              child: Column(
                                children: [

                                  Container(
                                      alignment: Alignment.topLeft,
                                      child : Text(item['itemName'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,)

                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.topLeft,
                                    child: Text(item['itemDesc'], style: TextStyle(fontSize: 16),),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Chip(
                                            label: Text('\$${item['minBidPrice']}(Min)', style: TextStyle(fontSize: 16, color: Colors.white),),
                                            backgroundColor: Colors.blue[500],
                                            shadowColor: Colors.black12,
                                          ),
                                          Chip(
                                            avatar: Icon(Icons.date_range, size: 16, color: Colors.white,),
                                            label: Text(AuctionTime().getTime(item['lastBidTime']), style: TextStyle(fontSize: 16, color: Colors.white),),
                                            backgroundColor: Colors.blue[500],
                                            shadowColor: Colors.black12,
                                          ),
                                        ],
                                      )
                                  ),

                                  SizedBox(height: 30,),
                                  hasBidUser ? Container() : FloatingActionButton.extended(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          enableDrag: true,
                                          useRootNavigator: true,

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          backgroundColor: Colors.white,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                child: BottomModal(item['minBidPrice'], item['itemId'], '', 0, 'EDIT'),

                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon( Icons.attach_money),
                                    backgroundColor: Colors.blue[500], label: Text('MAKE A BID'),
                                  ),
                                  SizedBox(height: 30,),

                                  Container(
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('items')
                                          .doc(item['itemId']).collection('bid-users').orderBy('bidPrice', descending: true).snapshots(),
                                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                        if(snapshot.hasData ){
                                          return BidsDataTable().table(snapshot.data!.docs, context, item['minBidPrice'], item['itemId'], user.uid);
                                        } else return Center(
                                          child: CircularProgressIndicator(color: Colors.blue[500],),
                                        );
                                      },
                                    ),  //AuctionDataTable().table(context)
                                  )

                                ],
                              )
                          ),




                        ]
                    ),
                  ],
                );
              }

              else return Center(child: CircularProgressIndicator(color: Colors.blue[500]));
            },
          )
      ),

    );
  }
}
