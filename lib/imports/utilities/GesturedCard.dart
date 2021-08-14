

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haggle/imports/firebase/UserManagement.dart';
import 'package:haggle/navigation/BidsItemDetails.dart';
import 'package:haggle/imports/utilities/Carousel.dart';
import 'AuctionTime.dart';
class GesturedCard extends StatefulWidget {
  final item;
  GesturedCard(this.item);

  @override
  _GesturedCardState createState() => _GesturedCardState();
}

class _GesturedCardState extends State<GesturedCard> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    User? currentUser = FirebaseAuth.instance.currentUser;


    return new ListView.builder(
        itemCount: item.length,
        key: UniqueKey(),
        itemBuilder: (context, index) {
          var itemData = item[index].data();
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  BidsItemDetails(itemDetails: item[index])));
            },
            child : Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserManagement().getPostedUser(itemData['userId'], 'MODERATE_NAME', 10.0, 14.0, false, false, true),
                          Text(AuctionTime().getPostedDay(itemData['bidAt']))
                        ],
                      )

                  ),
                  Carousel().imageCarousel(itemData['itemImages'], 180.0),
                  Container(
                    child: AuctionTime().getCountDown(itemData['lastBidTime'], itemData['itemId'], itemData['isCompleted']),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 0, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child:Text(itemData['itemName'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          alignment: Alignment.topLeft,
                        ),

                        Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Min Bid: \$${itemData["minBidPrice"]}',
                                  style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  'last time : '+ AuctionTime().getTime(itemData['lastBidTime']),
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            )

                        ),

                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Text(itemData.containsKey('bidUsers') && itemData['bidUsers'].length > 0 ? itemData['bidUsers'].length.toString() : '0'),
                              Icon(
                                Icons.people,
                                size: 15,
                                color: Colors.black.withOpacity(0.5),
                              )
                            ],
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Icon(
                            Icons.monetization_on,
                            color: itemData.containsKey('bidUsers') && itemData['bidUsers'].length > 0 && itemData['bidUsers'].contains(currentUser!.uid)
                                ? Colors.orange : Colors.grey.withOpacity(0.5),
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });

  }
}