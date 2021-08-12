

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            BidsItemDetails(itemDetails: item)));
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
                    UserManagement().getUserPostedUser(item['userId'], 'MODERATE_NAME'),
                    Text(AuctionTime().getPostedDay(item['createdAt']))
                  ],
                )

            ),
            Carousel().imageCarousel(item['itemImages']),
            Container(
              child: AuctionTime().getCountDown(item['lastBidTime']),
            ),

            Container(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:Text(item['itemName'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    alignment: Alignment.topLeft,
                  ),

                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$${item["minBidPrice"]}',
                            style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
                          ),

                          Text(
                            'last time : '+ AuctionTime().getTime(item['lastBidTime']),
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
                    child: Text(widget.item.data().containsKey('bidUsers') && item['bidUsers'].length > 0 ? item['bidUsers'].length.toString() : '0'),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: Text('You have bid it', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}