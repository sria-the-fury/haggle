import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimeLineChart extends StatefulWidget {


  @override
  _TimeLineChartState createState() => _TimeLineChartState();
}

class _TimeLineChartState extends State<TimeLineChart> {
  List<SalesData> _chartData = getChartData();
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: 'Daily Bid analysis'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<SalesData, double>(
            name: 'Bids\' price',
              dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true
          )
        ],
        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),

      ),
    ));
  }
}


List<SalesData> getChartData(){
final List<SalesData> chartData = [
  SalesData(2017, 35),
  SalesData(2018, 25),
  SalesData(2019, 20),
  SalesData(2019, 60),
  SalesData(2020, 45),
  SalesData(2021, 55),
];

return chartData;
}
class SalesData{
  SalesData(this.year, this.sales);
  final double year;
  final double sales;

}
