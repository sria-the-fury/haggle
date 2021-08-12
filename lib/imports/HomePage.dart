import 'package:flutter/material.dart';
import 'package:haggle/navigation/AuctionsAds.dart';
import 'package:haggle/navigation/Dashboard.dart';
import 'package:haggle/navigation/MyGranary.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedPage = 0;

  final _pageOptions = [
    AuctionsAds(),
    MyGranary(),
    Dashboard(),
  ];



  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Center(
          child: _pageOptions[selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Auctions',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'My Granary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Dashboard',
          ),
        ],
        currentIndex: selectedPage,
        selectedItemColor: Colors.blue[500],
        onTap: _onItemTapped,
      ),

    );
  }
}

