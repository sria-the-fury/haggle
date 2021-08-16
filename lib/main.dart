
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:haggle/imports/LoginPage.dart';
import 'package:haggle/imports/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return new MaterialApp(
      home: user?.uid != null ? HomePage() : LoginPage(),
      routes: user?.uid != null ? (<String, WidgetBuilder>{
        '/landingPage': (BuildContext context) => new MyApp(),
        '/homePage': (BuildContext context) => new HomePage(),
      }) :  (<String, WidgetBuilder>{
        '/landingPage': (BuildContext context) => new MyApp(),
        '/homePage': (BuildContext context) => new HomePage(),
      })
    );
  }
}

