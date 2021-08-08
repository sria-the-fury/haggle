import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haggle/imports/UserManagement.dart';

class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>{

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
                      child: Text('Signup'),
                      style: style,
                       onPressed: (){
                        print('Hello Signup');
                        print('email:'+_email);
                        print('password:'+_password);
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
                            .then((signedInUser) => {
                              print(signedInUser),
                              UserManagement().storeNewUser(signedInUser, context)
                        }).catchError((e){ print(e);}
                        );
                      }
                  )

                ],
              )
          )
      ),

    );
  }
}