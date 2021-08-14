import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haggle/imports/firebase/UserManagement.dart';
import 'package:haggle/imports/utilities/FlutterToast.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  _signInWithGoogle() async {
    final GoogleSignInAccount?  googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var isSignIn =  await FirebaseAuth.instance.signInWithCredential(credential);
    print(isSignIn.additionalUserInfo?.isNewUser);
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      if(isSignIn.additionalUserInfo?.isNewUser == true ) UserManagement().storeNewUser(user);
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/homePage');
      FlutterToast().successToast('Logged in as','DEFAULT', 14.0, user.email);
    }
  }

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      body: Container(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                    alignment: Alignment.center,
                    child: Center(
                        child:Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3)
                                  )
                                ]
                            ),
                            child:Lottie.asset('assets/auction_lottie_haggle-bd.json')
                        )
                    ) ,
                  ),
                  SizedBox(height: 15.0),
                  Center( child: Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'Haggle BD',
                        style: TextStyle(
                          fontSize: 40,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = Colors.blue[500]!,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'Haggle BD',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 5.0),
                  Center(child: Text('BUY AND SELL PRODUCT', style: TextStyle(fontSize: 18, ),textAlign: TextAlign.right,)),

                ],
              )
          )

      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () async {
        try{
          await _signInWithGoogle();

        } catch (e){
          print(e);
        }
      },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SIGN IN WITH', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/google_icon.png'),
                    )
                ),
              )

            ],
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,

    );
  }
}