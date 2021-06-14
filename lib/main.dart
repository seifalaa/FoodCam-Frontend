import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/profile.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

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
      builder: (context, navigator) {
        return Theme(
          data: ThemeData(
            accentColor: KSecondaryColor,
            primaryColor: KPrimaryColor,
            splashColor: KSecondaryColor,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: KPrimaryColor,
            ),
            scaffoldBackgroundColor: KBgColor,
            fontFamily: Localizations.localeOf(context).languageCode == 'ar' ? GoogleFonts.cairo().fontFamily : null,
          ),
          child: Container(
            child: navigator,
          ),
        );
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ar', ''), // Arabic, no country code
      ],
      locale: Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        'login/': (context) => Login(),
        'signup/': (context) => Signup1(),
        'home/': (context) => Home(),
        'profile/': (context) => Profile(),
      },
      // home: Login(),
      initialRoute: 'login/',
    );
  }
}
