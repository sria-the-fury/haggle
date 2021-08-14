import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haggle/imports/utilities/TimeLineChart.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {



    getData(isCompleted) {
      return StreamBuilder <QuerySnapshot> (
        stream: FirebaseFirestore.instance
            .collection('items').where('isCompleted', isEqualTo: isCompleted).snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          return snapshot.hasData ? Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 5, color: isCompleted ? Colors.grey : Colors.green),
                  borderRadius: BorderRadius.circular(40.0)
              ),
              margin: EdgeInsets.only(top: 20),
              child: Text( snapshot.data!.docs.length.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white))
          ) :
          Center( child: CircularProgressIndicator(color: Colors.white,));
        },
      );
    }


    getTotalValue() {

      return StreamBuilder <QuerySnapshot> (
        stream: FirebaseFirestore.instance
            .collection('items').where('isCompleted', isEqualTo: true).snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){

            //
            // var totalValue = data.reduce((x, y){
            //   var bidPriceX = x['minBidPrice'];
            //   var bidPricey = y['minBidPrice'];
            //   return bidPriceX + bidPricey;
            // });
            // print('totalValue --> $totalValue');

            return Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.green),
                    borderRadius: BorderRadius.circular(40.0)
                ),
                margin: EdgeInsets.only(top: 20),
                child: Text('\$'+120.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white))
            );

          }

          else return Center( child: CircularProgressIndicator(color: Colors.white,));
        },
      );

    }



    return new Scaffold(
        appBar: AppBar(
          title: Text('DASHBOARD'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.0,),
                    Container(
                        height: 200,
                        width: 350,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue[500],
                        ),
                        child: Column(
                          children: [
                            Text('BIDS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        child:Row (
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text('RUNNING',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white)),
                                              Text('COMPLETED',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white)),

                                            ]
                                        )
                                    ),
                                    Container(
                                        child:Row (
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              getData(false),
                                              getData(true)
                                            ]
                                        )
                                    ),

                                  ],
                                )

                            )
                          ],
                        )
                    ),
                    SizedBox(height: 40.0,),
                    Container(
                        height: 200,
                        width: 350,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue[500],
                        ),
                        child: Column(
                          children: [
                            Text('TOTAL VALUE OF COMPLETED BIDS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white,), textAlign: TextAlign.center,),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        child:Column (
                                            children: [
                                              getTotalValue()
                                            ]
                                        )
                                    ),

                                  ],
                                )

                            )
                          ],
                        )
                    ),
                    SizedBox(height: 40.0,),

                    FloatingActionButton.extended(
                      icon: Icon(Icons.stacked_line_chart),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new TimeLineChart();
                            },
                            fullscreenDialog: true
                        ));
                      },
                      label: Text('SEE TIMELINE'),

                    )
                  ]
              ),

            )
        )
    );
  }
}
