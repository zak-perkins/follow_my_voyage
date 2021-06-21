import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:follow_my_voyage/widgets/onboard_button.dart';
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
    var tileWidth = (screenSize.width / 4) - 15.0;

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
            icon: const Icon(CupertinoIcons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
          ),
          IconButton(
            tooltip: 'Sign In',
            icon: const Icon(CupertinoIcons.person_circle), // CupertinoIcons.person_circle,
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
                      icon: Icon(CupertinoIcons.person_add),
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
                      icon: Icon(CupertinoIcons.person_circle),
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
                  Container(
                    width: tileWidth,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/animals.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                      'One',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white38,
                      ),
                     ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: tileWidth,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/photography.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                      'Two',
                      style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white30,
                      ),
                     ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: tileWidth,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/trekking.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                      'Three',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white30,
                      ),
                    ),
                   ),
                  ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: tileWidth,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/animals.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                    'Four',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white30,
                    ),
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
