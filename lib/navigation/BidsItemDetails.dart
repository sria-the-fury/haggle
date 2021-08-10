import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(height: 5,),
          Carousel().imageCarousel(images),
          Container(
            margin: EdgeInsets.symmetric( horizontal: 10.0, vertical: 10.0),
            child: Container(
              alignment: Alignment.topLeft,
              child : Text(details['itemName'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,)

          ),
          )
      ]
      ),
    );
  }
}
