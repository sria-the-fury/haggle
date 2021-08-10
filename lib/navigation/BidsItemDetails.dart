import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:haggle/utilities/AuctionDataTable.dart';
import 'package:haggle/utilities/AuctionTime.dart';
import 'package:haggle/utilities/BottomModal.dart';
import 'package:haggle/utilities/Carousel.dart';


class BidsItemDetails extends StatefulWidget {
  final itemDetails;
  BidsItemDetails({@required this.itemDetails});
  @override
  _BidsItemDetailsState createState() => _BidsItemDetailsState();
}

class _BidsItemDetailsState extends State<BidsItemDetails> {

  @override
  Widget build(BuildContext context) {
    var images = widget.itemDetails['itemImages'];
    var details = widget.itemDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: new ListView(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                SizedBox(height: 5,),
                Carousel().imageCarousel(images),
                Container(
                  child: AuctionTime().getCountDown(details['lastBidTime']),
                ),

                Container(
                    margin: EdgeInsets.symmetric( horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      children: [

                        Container(
                            alignment: Alignment.topLeft,
                            child : Text(details['itemName'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,)

                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.topLeft,
                          child: Text(details['itemDesc'], style: TextStyle(fontSize: 16),),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text('\$${details['minBidPrice']}(Min)', style: TextStyle(fontSize: 16, color: Colors.white),),
                                  backgroundColor: Colors.blue[500],
                                  shadowColor: Colors.black12,
                                ),
                                Chip(
                                  avatar: Icon(Icons.date_range, size: 16, color: Colors.white,),
                                  label: Text(AuctionTime().getTime(details['lastBidTime']), style: TextStyle(fontSize: 16, color: Colors.white),),
                                  backgroundColor: Colors.blue[500],
                                  shadowColor: Colors.black12,
                                ),
                              ],
                            )
                        ),
                        Container(
                          child: AuctionDataTable().table(context),
                        )

                      ],
                    )
                )
              ]
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          var itemId = details['itemId'];

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
                    child: BottomModal(details['minBidPrice'], itemId),

                  ),
                );
              });
        },
        child: Icon(Icons.attach_money),
        backgroundColor: Colors.blue[500],
      ),
    );
  }
}
