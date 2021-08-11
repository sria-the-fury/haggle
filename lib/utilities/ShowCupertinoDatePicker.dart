import 'package:flutter/cupertino.dart';
class ShowCupertinoDatePicker{
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
          child: Text('DOne'),
          onPressed: onClicked,
        ),
      ),

  );
}
