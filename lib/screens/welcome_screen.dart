import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:follow_my_voyage/widgets/signin_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    var tileWidth = (screenSize.width / 4) - 10.0;

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
            tooltip: 'Sign Up',
            icon: Icon(CupertinoIcons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
          ),
          IconButton(
            tooltip: 'Sign In',
            icon: Icon(CupertinoIcons.person_circle),
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ],
      ),
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
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                  Text(
                    'FollowMy.Voyage',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OnboardButton(
                      title: 'Sign Up',
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    OnboardButton(
                      title: 'Sign In',
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                  ]),
              SizedBox(
                height: 120.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: Text(
                      'One',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: Text(
                      'Two',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: Text(
                      'Three',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    child: Text(
                      'Four',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ]),
      ]),
    );
  }
}
