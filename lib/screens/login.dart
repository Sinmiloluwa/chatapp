import 'package:chatapp/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo-no-background.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration,
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final loggedInUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(loggedInUser != null) {
                        if (context.mounted) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
