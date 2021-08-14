import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimeLineChart extends StatefulWidget {


  @override
  _TimeLineChartState createState() => _TimeLineChartState();
}

class _TimeLineChartState extends State<TimeLineChart> {

  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);


  Widget _buildBody(BuildContext context){
    return StreamBuilder <QuerySnapshot> (
      stream: FirebaseFirestore.instance
          .collection('items').snapshots(includeMetadataChanges: true),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if(snapshot.hasData){
          var data = snapshot.data!.docs;

          var bidsPerDay = data.map((eachData){

            var bidPrice = eachData['minBidPrice'];
            var date = eachData['bidAt'];
            var getDay = DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000).day;

            return BidsPricePerDay(getDay, bidPrice);

          }).toList();
          List<BidsPricePerDay> bidsData = bidsPerDay;

          return SfCartesianChart(
            title: ChartTitle(text: 'Daily Bid analysis'),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<BidsPricePerDay, int>(
                  name: 'Bids\' price/ day',
                  dataSource: bidsData,
                  xValueMapper: (BidsPricePerDay bidsPerDay, _) => bidsPerDay.day,
                  yValueMapper: (BidsPricePerDay bidsPerDay, _) => bidsPerDay.bidPrice,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true
              )
            ],
            primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
            primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),

          );


        }
        else{
          return Center( child: CircularProgressIndicator(color: Colors.white,));
        }
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: _buildBody(context),
    ));
  }
}


class BidsPricePerDay{
  final int day;
  final int bidPrice;
  BidsPricePerDay(this.day, this.bidPrice);

}
