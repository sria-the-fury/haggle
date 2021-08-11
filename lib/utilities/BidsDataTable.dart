import 'package:flutter/material.dart';
import 'package:haggle/imports/UserManagement.dart';
import 'package:haggle/utilities/AuctionTime.dart';

class BidsDataTable {

  var users = [
    {
      'userName' : 'Jakaria Mashud',
      'bidPrice' : 130,
      'bidTime' : '15 Min ago'
    },
    {
      'userName' : 'John Doe',
      'bidPrice' : 121,
      'bidTime' : '1 hour ago'
    },
    {
      'userName' : 'John Doe',
      'bidPrice' : 121,
      'bidTime' : '1 hour ago'
    },
  ];

  table(bidUsers, context){
    return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 5.0, bottom: 15.0) ,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3)
              )
            ],
          ),
          padding: EdgeInsets.all(5.0),

          child : bidUsers.length != 0 ?  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child : DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Bid Price(\$)',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Time',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: bidUsers.map<DataRow>((user)=>
                      new DataRow(
                        color: MaterialStateColor.resolveWith((states) => Colors.transparent),
                        cells:  <DataCell>[
                          DataCell(
                             UserManagement().getUserPostedUser(user['userId'], 'SHORT_NAME')

                          ),
                          DataCell(Text(user['bidPrice'].toString())),
                          DataCell(Text(AuctionTime().getPostedDay(user['bidAt']))),
                        ],
                      ),).toList(),
                ),
              )
          ) : Center(child: Text('No one Bids yet', style: TextStyle(fontSize: 20) ,))
      );
  }
}