import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userImage = user?.photoURL;


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
      body: Center(
        child: Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text('You are logged in'),
              SizedBox(
                height: 15.0,
              ),
              OutlinedButton(
                child: Text('Logout'),
                  onPressed: ()  async {


              },
              )
            ],
          ),
        ),
      ),
    );
  }
}

