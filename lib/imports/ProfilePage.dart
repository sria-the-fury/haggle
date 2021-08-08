import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haggle/utilities/FlutterToast.dart';
import 'LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ProfilePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PROFILE'),
            IconButton(
                onPressed: () async {
                  try{
                    await FirebaseAuth.instance.signOut();
                  }
                  catch(e){
                    print(e);
                  }
                  finally{
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginPage()), (Route<dynamic> route) => false);
                   FlutterToast().warningToast('Log out', 'BOTTOM', 14.0, null);
                  }

                },
                icon: Icon(Icons.logout)
            ),
          ],
          
        ),
        
        
      ),
      body:
        Container(
          child: new Column(
            children: [
              new Text('You are logged in'),
              SizedBox(
                height: 15.0,
              ),
              OutlinedButton(
                child: Text('Logout'),
                onPressed: () {
                  FlutterToast().warningToast('this is test', 'BOTTOM', 14.0, null);

                },
              )
            ],
          ),
        ),
      );
  }
}
