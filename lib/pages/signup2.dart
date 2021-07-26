import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/signup_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.firstName, required this.lastName})
      : super(key: key);
  final String firstName;
  final String lastName;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.black,
      opacity: 0.3,
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: Scaffold(
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SignupForm(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  repeatPasswordController: _rePasswordController,
                  emailController: _emailController,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  onSignup: onSignup,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final Response response = await _authController.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _rePasswordController.text,
        widget.firstName,
        widget.lastName,
      );
      final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
      final SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      if (response.statusCode == 201) {
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
        if (_responseJson['username'] != null &&
            _responseJson['email'] != null) {
          final String _langCode = Localizations.localeOf(context).languageCode;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                AppLocalizations.of(context)!.userExists,
                style: TextStyle(
                  fontFamily:
                      _langCode == 'ar' ? GoogleFonts.cairo().fontFamily : null,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (_responseJson['username'] != null) {
          final String _langCode = Localizations.localeOf(context).languageCode;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                AppLocalizations.of(context)!.usernameExist,
                style: TextStyle(
                  fontFamily:
                      _langCode == 'ar' ? GoogleFonts.cairo().fontFamily : null,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (_responseJson['email'] != null) {
          final String _langCode =
              Provider.of<LanguageProvider>(context, listen: false).getLangCode;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                AppLocalizations.of(context)!.emailExists,
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
}
