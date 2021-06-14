import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/email_verification.dart';
import 'package:foodcam_frontend/widgets/bg.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';
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
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        Text(
                          "Hi, " + widget.firstName,
                          style: TextStyle(
                            fontSize: 30,
                            color: KTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('let us continue your account setup!'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          validator: (input) {
                            return input == ''
                                ? 'Username cannot be empty'
                                : null;
                          },
                          hint: "Username",
                          controller: _usernameController,
                          isObscure: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomTextFormField(
                            validator: (input) {
                              return input == ''
                                  ? 'Email cannot be empty'
                                  : null;
                            },
                            hint: "Email",
                            controller: _emailController,
                            isObscure: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomTextFormField(
                            validator: (input) {
                              return input == ''
                                  ? 'Password cannot be empty'
                                  : null;
                            },
                            hint: "Password",
                            controller: _passwordController,
                            isObscure: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomTextFormField(
                            validator: (input) {
                              if (input == '') {
                                return 'Repeat password cannot be empty';
                              }
                              if (_passwordController.text != input) {
                                return 'Passwords is not identical';
                              }
                              return null;
                            },
                            hint: "Repeat password",
                            controller: _rePasswordController,
                            isObscure: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: KTextColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: ElevatedButton(
                                  onPressed: () async {
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
                                    //     widget.firstName,
                                    //     widget.lastName,
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
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: KPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Create",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
