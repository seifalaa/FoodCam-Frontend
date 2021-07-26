import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/widgets/signup_form1.dart';
import 'package:foodcam_frontend/widgets/social_auth.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Signup1 extends StatefulWidget {
  const Signup1({Key? key}) : super(key: key);

  @override
  _Signup1State createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.signup,
          style: const TextStyle(
            color: kTextColor,
          ),
        ),
        elevation: 1,
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
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: LoadingOverlay(
          isLoading: _isLoading,
          color: Colors.black,
          opacity: 0.3,
          progressIndicator: const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                SignupForm1(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  formKey: _formKey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SocialAuth(
                    onGoogleAuth: onGoogleAuth,
                    onFacebookAuth: onFacebookAuth,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.haveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.login),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
