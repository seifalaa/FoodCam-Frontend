import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/widgets/bg.dart';
import 'package:foodcam_frontend/widgets/signup_form1.dart';
import 'package:foodcam_frontend/widgets/social_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants.dart';
import 'home.dart';

class Signup1 extends StatefulWidget {
  const Signup1({Key? key}) : super(key: key);

  @override
  _Signup1State createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController _controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black,
        opacity: 0.3,
        progressIndicator: CircularProgressIndicator(
          color: KPrimaryColor,
        ),
        child: Stack(
          children: [
            Container(
              child: CustomPaint(
                painter: BG(context: context),
              ),
            ),
            Center(
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
            )
          ],
        ),
      ),
    );
  }

  void onGoogleAuth() async {
    setState(() {
      _isLoading = true;
    });
    bool response = await _controller.loginWithGoogle();
    setState(() {
      _isLoading = false;
    });
    if (response) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  void onFacebookAuth() async {
    setState(() {
      _isLoading = true;
    });
    bool response = await _controller.loginWithFacebook();
    setState(() {
      _isLoading = false;
    });
    if (response) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
}
