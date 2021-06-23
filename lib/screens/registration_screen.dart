import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:follow_my_voyage/constants.dart';
import 'package:follow_my_voyage/widgets/onboard_button.dart';
import 'login_screen.dart';
import 'map_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          shadowColor: Colors.grey,
          title: Container(
            width: 40,
            child: Image.asset('images/logo.png'),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'Sign In',
              icon: const Icon(CupertinoIcons.person_circle),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
        backgroundColor: Colors.black38,
        body: Stack(children: <Widget>[
          Container(
            child: Image.asset(
              'images/cover.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 400),
              child: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Email'),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Password'),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      OnboardButton(
                        title: 'Sign Up',
                        color: Colors.blueAccent,
                        icon: const Icon(CupertinoIcons.person_add),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, MapScreen.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
    );
  }
}
