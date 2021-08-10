

import 'package:flutter/material.dart';
import 'package:haggle/imports/UserManagement.dart';
import 'package:haggle/navigation/BidsItemDetails.dart';
import 'package:haggle/utilities/Carousel.dart';
import 'AuctionTime.dart';

class GesturedCard{
  card(item, context){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            BidsItemDetails(itemDetails: item)));
      },
      child : Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            UserManagement().getUserPostedUser(item['userId']),
            Carousel().imageCarousel(item['itemImages']),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: AuctionTime().getCountDown(item['lastBidTime']),
            ),

            ListTile(
                title: Text(item['itemName'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Min Bid: \$${item["minBidPrice"]}',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),

                    Text(
                      AuctionTime().getTime(item['lastBidTime']),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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