import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:followmy_voyage/utils/authentication.dart';
import 'package:followmy_voyage/utils/theme_data.dart';
import 'package:followmy_voyage/screens/home_page.dart';
import 'package:followmy_voyage/screens/map_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final User? user = _auth.currentUser;

    return MaterialApp(
      title: 'FollowMy.Voyage',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: (user != null) ? MapPage() : HomePage(),
    );
  }
}
