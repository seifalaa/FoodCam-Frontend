import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/widgets/login_form.dart';
import 'package:foodcam_frontend/widgets/social_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.black.withOpacity(0.3),
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.login,
            style: const TextStyle(
              color: kTextColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: kTextColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            //CustomPaint(
            //  painter: BG(context: context),
            //),
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    formKey: _formKey,
                    onLogin: onLogin,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SocialAuth(
                      onFacebookAuth: onFacebookAuth,
                      onGoogleAuth: onGoogleAuth,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.dontHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup1(),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.signup),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      final Response response = await _authController.loginWithEmailAndPassword(
          _emailController.text, _passwordController.text);

      final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        await _flutterSecureStorage.write(
            key: 'access_token', value: _responseJson['access_token']);
        await _flutterSecureStorage.write(
            key: 'refresh_token', value: _responseJson['refresh_token']);
        await _sharedPreferences.setString(
          'userName',
          _responseJson['user']['username'],
        );
        await _sharedPreferences.setString(
          'firstName',
          _responseJson['user']['first_name'],
        );
        await _sharedPreferences.setString(
          'lastName',
          _responseJson['user']['last_name'],
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home/',
          (route) => false,
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        if (_responseJson['non_field_errors'] != '') {
          final String _langCode = Localizations.localeOf(context).languageCode;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                AppLocalizations.of(context)!.invalidCreds,
                style: TextStyle(
                  fontFamily:
                      _langCode == 'ar' ? GoogleFonts.cairo().fontFamily : null,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> onGoogleAuth() async {
    setState(() {
      _isLoading = true;
    });
    final Response response = await _authController.loginWithGoogle();
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      await _flutterSecureStorage.write(
          key: 'access_token', value: _responseJson['access_token']);
      await _flutterSecureStorage.write(
          key: 'refresh_token', value: _responseJson['refresh_token']);
      await _sharedPreferences.setString(
        'userName',
        _responseJson['user']['username'],
      );
      await _sharedPreferences.setString(
        'firstName',
        _responseJson['user']['first_name'],
      );
      await _sharedPreferences.setString(
        'lastName',
        _responseJson['user']['last_name'],
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        'home/',
        (route) => false,
      );
    }
  }

  Future<void> onFacebookAuth() async {
    setState(() {
      _isLoading = true;
    });
    final Response response = await _authController.loginWithFacebook();
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      await _flutterSecureStorage.write(
          key: 'access_token', value: _responseJson['access_token']);
      await _flutterSecureStorage.write(
          key: 'refresh_token', value: _responseJson['refresh_token']);
      await _sharedPreferences.setString(
        'userName',
        _responseJson['user']['username'],
      );
      await _sharedPreferences.setString(
        'firstName',
        _responseJson['user']['first_name'],
      );
      await _sharedPreferences.setString(
        'lastName',
        _responseJson['user']['last_name'],
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        'home/',
        (route) => false,
      );
    }
  }
}
