import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/allergies_page.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/pages/dispreferred_ingredients.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/login.dart';
import 'package:foodcam_frontend/pages/preferred_ingredients.dart';
import 'package:foodcam_frontend/pages/profile.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/pages/test.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getLangCode() async {
  final SharedPreferences _sharedPreferences =
      await SharedPreferences.getInstance();
  final String langCode = _sharedPreferences.getString('langCode') != null
      ? _sharedPreferences.getString('langCode')!
      : 'ar';
  return langCode;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(create: (_) => LanguageProvider(), child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseApp>(
      stream: Stream.fromFuture(Firebase.initializeApp()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
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
            locale: Locale(Provider.of<LanguageProvider>(context).langCode),
            debugShowCheckedModeBanner: false,
            title: 'Food Cam',
            routes: {
              'login/': (context) => const Login(),
              'signup/': (context) => const Signup1(),
              'home/': (context) => const Home(),
              'profile/': (context) => const Profile(),
              'basket/': (context) => const BasketPage(),
              'collections/': (context) => const CollectionPage(),
              'allergies/': (context) => const AllergiesPage(),
              'prefIng/': (context) => const PreferredIngredients(),
              'disPrefIng/': (context) => const DisPreferredIngredients(),
            },
            initialRoute: 'home/',
            //home: const TestPage(),
          );
        } else {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
