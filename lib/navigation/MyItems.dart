import 'package:flutter/material.dart';

class MyItems extends StatefulWidget {

  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('My Items'),
      ),
    );
  }
}