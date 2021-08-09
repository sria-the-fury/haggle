import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:haggle/imports/modals/AddItemModal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class AuctionsAds extends StatefulWidget {

  @override
  _AuctionsAdsState createState() => _AuctionsAdsState();
}

class _AuctionsAdsState extends State<AuctionsAds> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userImage = user?.photoURL;
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 3600;

    List<String> imageArray = [
      'https://images.unsplash.com/photo-1531502774286-5e4e8e94879f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmlrZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmlrZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'
      ,'https://images.unsplash.com/photo-1459682687441-7761439a709d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHVja3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'
    ];
    print('Length : '+imageArray.length.toString());


    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Haggle BD', textAlign: TextAlign.left),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/profilePage');
              },
              child: userImage != null ? Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3)
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:NetworkImage(userImage),
                      fit: BoxFit.fill,
                    )
                ),
              ) : CircularProgressIndicator(color: Colors.white),
            )  ,

          ],
        ),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                            '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0, enableInfiniteScroll: true,),
                    items: imageArray.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(i),
                                  fit: BoxFit.cover,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Text("Game over");
                        }
                        else return Text(
                          '${time.days ?? 0} DAY(s) : ${time.hours ?? 0} HOUR(s) : ${time.min ?? 0} MIN(s) : ${time.sec} SEC',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),);
                      },
                    ),
                  ),

                  ListTile(
                      title: const Text('Bike Harley Davidson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Min Bid: \$150',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),

                          Text(
                            'Bid until 27th Aug 12:00 am',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Row(
                                children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageArray[0],),
                                    radius: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text('Swadhin', style: TextStyle(fontSize: 14),)
                                ]

                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Text('Total Bid :  10', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),

                  )


                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 1'),
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new AddItemModal();
              },
              fullscreenDialog: true
          ));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
