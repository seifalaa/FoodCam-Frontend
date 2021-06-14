import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/email_verification.dart';
import 'package:foodcam_frontend/widgets/bg.dart';
import 'package:foodcam_frontend/widgets/signup_form.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.firstName, required this.lastName})
      : super(key: key);
  final String firstName;
  final String lastName;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
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
            ListView(
              shrinkWrap: true,
              children: [
                SignupForm(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  repeatPasswordController: _rePasswordController,
                  emailController: _emailController,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  onSignup: onSignup,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onSignup() {
    showDialog(
      context: context,
      builder: (context) => EmailVerification(),
    );
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   bool response =
    //       await _controller.register(
    //     _usernameController.text,
    //     _emailController.text,
    //     _passwordController.text,
    //     _rePasswordController.text,
    //     firstName,
    //     lastName,
    //   );
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   if (response) {
    //   } else {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(
    //       SnackBar(
    //         content: Text(
    //             'Oops,please try again later.'),
    //       ),
    //     );
    //   }
    //}
  }
}
