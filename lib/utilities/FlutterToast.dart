import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class FlutterToast {
  successToast(message, position, textSize, data){
    Fluttertoast.showToast(
        msg: data != null ?  message+ " " + data : message,
        toastLength: Toast.LENGTH_LONG,
        gravity: defineGravity(position),
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[500],
        textColor: Colors.white,
        fontSize: textSize
    );
  }
  warningToast(message, position, textSize, data){
    Fluttertoast.showToast(
        msg: data != null ?  message+ " " + data : message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: defineGravity(position),
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange[500],
        textColor: Colors.white,
        fontSize: textSize
    );
  }
  errorToast(message, position, textSize, data){
    Fluttertoast.showToast(
        msg: data != null ?  message+ " " + data : message,
        toastLength: Toast.LENGTH_LONG,
        gravity: defineGravity(position) ,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[500],
        textColor: Colors.white,
        fontSize: textSize
    );
  }

  defineGravity(position){
    switch(position){
      case 'TOP':
        return ToastGravity.TOP;
      case 'TOP_LEFT':
        return ToastGravity.TOP_LEFT;
      case 'TOP_RIGHT':
        return ToastGravity.TOP_RIGHT;
      case 'BOTTOM_RIGHT':
        return ToastGravity.BOTTOM_RIGHT;
      case 'BOTTOM':
        return ToastGravity.BOTTOM;
      case 'BOTTOM_LEFT':
        return ToastGravity.BOTTOM_LEFT;
      case 'BOTTOM_RIGHT':
        return ToastGravity.BOTTOM_RIGHT;
      case 'CENTER_LEFT':
        return ToastGravity.CENTER_LEFT;
      case 'CENTER_RIGHT':
        return ToastGravity.CENTER_RIGHT;
      default:
        return ToastGravity.CENTER;

    }
  }
}