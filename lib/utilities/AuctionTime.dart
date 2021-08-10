import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';


class AuctionTime{
   getCountDown(time){

    var timeInMilliSeconds = (time.seconds * 1000);

    return CountdownTimer(
      endTime: timeInMilliSeconds,
      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {

        if (time == null) {
          return Text("Game over");
        }
        else {
          return Text(
            '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);}
      },
    );
  }

   getTime(time) {
     DateTime date = DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000, );

     return 'last bid time : '+new DateFormat.yMMMd().add_jms().format(date);
   }
}