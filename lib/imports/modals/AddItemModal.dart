import 'dart:math';
import 'package:flutter/material.dart';

class AddItemModal extends StatefulWidget {
  @override
  _AddItemModalState createState() => new _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Add Item for Auction'),
        actions: [
        ],
      ),
      body: new Text("Food"),
    );
  }
}