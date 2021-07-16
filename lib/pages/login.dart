import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/signup1.dart';
import 'package:foodcam_frontend/widgets/bg.dart';
import 'package:foodcam_frontend/widgets/login_form.dart';
import 'package:foodcam_frontend/widgets/social_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _controller = AuthController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
                  LoginForm(
                    usernameController: _usernameController,
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
      final response = await _controller.loginWithEmailAndPassword(
          _usernameController.text, _passwordController.text);
      setState(() {
        _isLoading = false;
      });
      if (!response) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credentials'),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    }
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
