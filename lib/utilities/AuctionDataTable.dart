import 'package:flutter/material.dart';

class AuctionDataTable {

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
  ];

  table(context){
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

          child : SingleChildScrollView(
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
                  rows: users.map((user) =>
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage('https://images.pexels.com/users/avatars/939/jakaria-mashud-shahria-738.jpeg?w=200&h=200&fit=crop&crop=faces'),
                                      radius: 10,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(user['userName'].toString(), style: TextStyle(fontSize: 14),)
                                  ]
                              )

                          ),
                          DataCell(Text(user['bidPrice'].toString())),
                          DataCell(Text(user['bidTime'].toString())),
                        ],
                      ),).toList(),
                ),
              )
          )
      );
  }
}