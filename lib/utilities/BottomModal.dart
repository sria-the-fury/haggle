import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haggle/utilities/BidsManagement.dart';

class BottomModal extends StatefulWidget {
  final int lowestBidPrice;
  final String itemId;
  const BottomModal(this.lowestBidPrice, this.itemId);

  @override
  _BottomModalState createState() => _BottomModalState();
}


class _BottomModalState extends State<BottomModal> {
  late String price = '0';
  @override
  Widget build(BuildContext context) {

    var lowestBidPrice = widget.lowestBidPrice;
    var itemId = widget.itemId;

    print('lowestBidPrice $lowestBidPrice');
    print('itemId $itemId');
    print('price =>  ${int.parse(price)}');

    User? user = FirebaseAuth.instance.currentUser;
    return new Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.remove_circle,
                  color: Colors.blue[500], size: 30,),
                onPressed: () => Navigator.pop(context),

              ),
            ),
            Container(
              child: Text('The Value is : $price'),
            ),

            Container(
                child: Row(
                  children: [

                  ],
                )
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.number,

              onChanged: (text) {
                if(text.length >= 1 ) setState(() {
                  price = text;
                });
                print('First text field: $price');

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  disabledColor: Colors.grey,
                  icon: Icon(Icons.monetization_on, size: 35,),
                  onPressed: lowestBidPrice <= int.parse(price) ? () {
                    BidsManagement().makeBid(price, user, itemId);
                    Navigator.pop(context);
                    price = '0';
                  } : null,
                ),
                hintText: 'Make your bid',
              ),
            ),
          ]
      ),
    );
  }
}



// class BottomModal{
//  late String price = '0';
//     modal(data, context, lowestBidPrice) {
//       print('data $data');
//
//       User? user = FirebaseAuth.instance.currentUser;
//
//       return new Container(
//         height: 150,
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
//           color: Colors.white,
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: Icon(Icons.remove_circle,
//                     color: Colors.blue[500], size: 30,),
//                   onPressed: () => Navigator.pop(context),
//
//                 ),
//               ),
//
//               Container(
//                 child: Row(
//                   children: [
//
//                   ],
//                 )
//               ),
//               TextField(
//                 autofocus: true,
//                 keyboardType: TextInputType.number,
//
//                 onChanged: (text) {
//                   price = text ;
//                   print('First text field: $price');
//
//                   },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     disabledColor: Colors.grey,
//                     icon: Icon(Icons.monetization_on, size: 35,),
//                     onPressed:  lowestBidPrice >= int.parse(price).toInt() ? () {
//                         BidsManagement().addBid(price, user, data);
//                         Navigator.pop(context);
//                         price = '';
//                     } : null,
//                   ),
//                   hintText: 'Make your bid',
//                 ),
//               ),
//             ]
//         ),
//       );
//     }
//
// }
