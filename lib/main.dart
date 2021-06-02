import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: KPrimaryColor,
        splashColor: KSecondaryColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: KPrimaryColor,
        ),
        scaffoldBackgroundColor: KBgColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        'login': (context) => Login(),
        'signup': (context) => Signup(),
        'home': (context) => Home(),
      },
      initialRoute: 'home',
    );
  }
}
