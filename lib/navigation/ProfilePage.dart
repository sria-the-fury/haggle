
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:haggle/imports/utilities/FlutterToast.dart';
import '../imports/LoginPage.dart';



class ProfilePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    var userImage = user?.photoURL;

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
            Align(
              child: Container(
                decoration: BoxDecoration(color: Colors.blue[500],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                    )
                ),
                height: 120,

                padding: EdgeInsets.all(5.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
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
                            image:NetworkImage(userImage!),
                            fit: BoxFit.fill,
                          )
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            new Text(user!.displayName!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),maxLines: 1,),
                            new Text(user.email!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),maxLines: 1,),
                          ]
                      ),
                    ),
                  ],
                ),

              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 25.0,
            ),

            Container(
              child: Text('Hello'),
              decoration: BoxDecoration(color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0))
              ),
              height: 120,
              width: MediaQuery.of(context).size.width,

              padding: EdgeInsets.all(5.0),
              margin: new EdgeInsets.symmetric(horizontal: 10.0),

            ),
          ],
        ),
      ),
    );
  }
}
