import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/pages/email_verification.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/preferred_ingredients.dart';
import 'package:foodcam_frontend/pages/profile.dart';
import 'package:foodcam_frontend/pages/recipe_page.dart';
import 'package:foodcam_frontend/pages/collections_recipes_page.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/pages/signup2.dart';

void main() {
  runApp(MyApp());
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
        'collections/': (context) => CollectionPage(),  
      },
      //home: PreferrredIngredients(),
      initialRoute: 'home/',
    );
  }
}
