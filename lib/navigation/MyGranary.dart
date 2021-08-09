import 'package:flutter/material.dart';

var _selectOptionBid = false;
var _selectOptionItem = true;

class MyGranary extends StatefulWidget {

  @override
  _MyGranaryState createState() => _MyGranaryState();
}

class _MyGranaryState extends State<MyGranary> {

  Widget build(BuildContext context) {

    var raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: _selectOptionBid ? Colors.white : Colors.blue[500] ,
      primary: _selectOptionBid ? Colors.blue[500] : Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

    var raisedButtonStyle2 = ElevatedButton.styleFrom(
      onPrimary: _selectOptionItem ? Colors.white : Colors.blue[500] ,
      primary: _selectOptionItem ? Colors.blue[500] : Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

    return new Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: raisedButtonStyle2,
                        onPressed: () {
                          setState(() {
                            _selectOptionBid = false;
                            _selectOptionItem = true;
                          });

                        }
                        ,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Icon(
                                Icons.sell,
                                color: _selectOptionItem ? Colors.white : Colors.blue[500],
                                size: 20.0,
                              ),
                              Text('My Items', style: TextStyle(fontSize: 18),)
                            ],

                          ),
                        )
                    ),
                    ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          setState(() {
                            _selectOptionItem = false;
                            _selectOptionBid = true;
                          });


                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Icon(
                                Icons.attach_money,
                                color: _selectOptionBid ? Colors.white : Colors.blue[500],
                                size: 20.0,
                              ),
                              Text('My Bids', style: TextStyle(fontSize: 18),)
                            ],

                          ),
                        )
                    )
                  ],

                ),
              ),

              // Container(
              //   child: _selectOptionItem ? MyItems() :  null,
              // ),

            ],
          ),
        )
    );
  }
}