import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/widgets/bg.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
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
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 50,
                              color: KTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextFormField(
                              validator: (input) {
                                return input == ''
                                    ? 'First name cannot be empty'
                                    : null;
                              },
                              hint: 'First name',
                              controller: _firstNameController,
                              isObscure: false),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CustomTextFormField(
                              validator: (input) {
                                return input == ''
                                    ? 'Last name cannot be empty'
                                    : null;
                              },
                              hint: 'Last name',
                              controller: _lastNameController,
                              isObscure: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: CustomTextFormField(
                              validator: (input) {
                                return input == ''
                                    ? 'Username cannot be empty'
                                    : null;
                              },
                              hint: "Username",
                              controller: _usernameController,
                              isObscure: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
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
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: KTextColor,
                            thickness: 2,
                            indent: 50,
                            endIndent: 5,
                          ),
                        ),
                        Text(
                          "Or with",
                          style: TextStyle(
                            color: KTextColor,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: KTextColor,
                            thickness: 2,
                            indent: 5,
                            endIndent: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              bool response =
                                  await _controller.loginWithFacebook();
                              if (response) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false);
                              }
                            },
                            child: Image.asset(
                              'lib/assets/facebook.png',
                              width: 40,
                              height: 40,
                            )),
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              bool response =
                                  await _controller.loginWithGoogle();
                              if (response) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false);
                              }
                            },
                            child: Image.asset(
                              'lib/assets/search.png',
                              width: 40,
                              height: 40,
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Login'),
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
}
