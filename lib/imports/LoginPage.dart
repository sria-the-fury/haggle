import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  late String _email;
  late String _password;


  @override
  Widget build(BuildContext context){
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return new Scaffold(
      body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Email'),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),

                  SizedBox(height: 15.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Password'),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text('Login'),
                      style: style,
                      onPressed: (){
                        FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
                            .then((user){
                          Navigator.of(context).pushReplacementNamed('/homePage');

                        })
                            .catchError((e) {
                          print('Sign In : '+e);

                        });
                        print('Hello Login');
                      }
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text('SignIn With Google'),
                      style: style,
                      onPressed: () async {
                        try{
                          final GoogleSignInAccount?  googleUser = await GoogleSignIn().signIn();
                          final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken,
                          );
                         var isSignIn =  await FirebaseAuth.instance.signInWithCredential(credential);
                         print(isSignIn);
                          User? user = FirebaseAuth.instance.currentUser;
                          print(user?.uid);
                          if(user != null){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/homePage');
                          }

                        } catch (e){
                          print(e);
                        }


                      }
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text('Haven\'t an account?' ),
                      style: style,
                      onPressed: (){
                        Navigator.of(context).pushNamed('/signup');
                      }
                  ),

                ],
              )
          )
      ),

    );
  }
}