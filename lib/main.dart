import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/allergies_page.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/pages/email_verification.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/profile.dart';
import 'package:foodcam_frontend/pages/recipe_page.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/pages/signup2.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AllergyProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: KSecondaryColor,
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
        'login/': (context) => Login(),
        'signup/': (context) => Signup1(),
        'home/': (context) => Home(),
        'profile/': (context) => Profile(),
      },
      home: AllergiesPage(),
      //initialRoute: 'home/',
    );
  }
}
