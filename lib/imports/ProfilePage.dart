
import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Profile', textAlign: TextAlign.left)

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
