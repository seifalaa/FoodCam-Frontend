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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black,
        opacity: 0.3,
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: Stack(
          children: [
            CustomPaint(
              painter: BG(context: context),
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

  Future<void> onGoogleAuth() async {
    setState(() {
      _isLoading = true;
    });
    final bool response = await _controller.loginWithGoogle();
    setState(() {
      _isLoading = false;
    });
    if (response) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  Future<void> onFacebookAuth() async {
    setState(() {
      _isLoading = true;
    });
    final bool response = await _controller.loginWithFacebook();
    setState(() {
      _isLoading = false;
    });
    if (response) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }
}
