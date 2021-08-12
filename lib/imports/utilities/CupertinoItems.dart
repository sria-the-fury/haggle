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

  static void showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
      backgroundColor: Colors.green[500],
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
      backgroundColor: Colors.green[500],
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
