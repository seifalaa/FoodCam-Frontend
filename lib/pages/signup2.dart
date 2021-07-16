import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final bool _isLoading = false;

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
      builder: (context) => const EmailVerification(),
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
