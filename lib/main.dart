import 'package:flutter/material.dart';

import 'package:follow_my_voyage/screens/login_screen.dart';
import 'package:follow_my_voyage/screens/registration_screen.dart';
import 'package:follow_my_voyage/screens/welcome_screen.dart';
import 'package:follow_my_voyage/screens/map_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MapScreen.id: (context) => MapScreen(),
         },
    );
    }
  }

