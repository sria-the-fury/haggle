import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CupertinoItems{
  static void showSheet(
      BuildContext context, {
        required Widget child,
        required VoidCallback onClicked}) => showCupertinoModalPopup(
    context: context, builder: (context) =>

      CupertinoActionSheet(
        actions: [
          child,
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('DONE'),
          onPressed: onClicked,
        ),
      ),

  );

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
