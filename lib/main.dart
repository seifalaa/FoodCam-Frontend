import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/profile.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/pages/test.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AllergyProvider>(
            create: (_) => AllergyProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final String lang = Provider.of<LanguageProvider>(context).langCode;
    return FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? MaterialApp(
                  builder: (context, navigator) {
                    return Theme(
                      data: ThemeData(
                        accentColor: kSecondaryColor,
                        primaryColor: kPrimaryColor,
                        splashColor: kSecondaryColor,
                        textSelectionTheme: const TextSelectionThemeData(
                          cursorColor: kPrimaryColor,
                        ),
                        scaffoldBackgroundColor: kBgColor,
                        fontFamily:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? GoogleFonts.cairo().fontFamily
                                : null,
                      ),
                      child: Container(
                        child: navigator,
                      ),
                    );
                  },
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''), // English, no country code
                    Locale('ar', ''), // Arabic, no country code
                  ],
                  locale: Locale(lang),
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  routes: {
                    'login/': (context) => const Login(),
                    'signup/': (context) => const Signup1(),
                    'home/': (context) => const Home(),
                    'profile/': (context) => const Profile(),
                    'basket/': (context) => const BasketPage(),
                    'test/': (context) => const TestPage(),
                  },
                  initialRoute: 'home/',
                )
              : const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
        });
  }
}
