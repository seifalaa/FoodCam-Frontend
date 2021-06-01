import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/pages/home.dart';
import 'package:foodcam_frontend/pages/signup.dart';
import 'package:foodcam_frontend/widgets/login_bg.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController _controller = AuthController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: KTextColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextFormField(
                            validator: (input) {
                              return input == ''
                                  ? 'Username cannot be empty'
                                  : null;
                            },
                            hint: 'Username',
                            controller: _usernameController,
                            isObscure: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CustomTextFormField(
                              controller: _passwordController,
                              hint: 'Password',
                              validator: (input) {
                                return input == ''
                                    ? 'Password cannot be empty'
                                    : null;
                              },
                              isObscure: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text('forget your password?'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: KPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  var response = await _controller
                                      .loginWithEmailAndPassword(
                                          _usernameController.text,
                                          _passwordController.text);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (!response) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Invalid Credentials'),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
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
                          'Or with',
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
                        ),
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
                            setState(() {
                              _isLoading = false;
                            });
                            if (response) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          },
                          child: Image.asset(
                            'lib/assets/facebook.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
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
                          },
                          child: Image.asset(
                            'lib/assets/search.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text('Signup'),
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
}
