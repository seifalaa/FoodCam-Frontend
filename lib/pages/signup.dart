import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/login_bg.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

//TODO: Refactor the fields to be separate widgets
class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            "Create Account",
                            style: TextStyle(
                              fontSize: 30,
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
                                    ? 'password cannot be empty'
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
                                var password = _passwordController.text;
                                if (input == '') {
                                  return 'Username cannot be empty';
                                }
                                if (password != input) {
                                  return 'passwords is not identical';
                                }
                                return null;
                              },
                              hint: "Repatpassword",
                              controller: _repasswordController,
                              isObscure: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){}


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
                                  "Create account",
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
                            onPressed: () {},
                            child: Image.asset(
                              'lib/assets/facebook.png',
                              width: 40,
                              height: 40,
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Image.asset(
                              'lib/assets/search.png',
                              width: 40,
                              height: 40,
                            )),
                      ],
                    ),
                  ),
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Login'),
                      )
                    ],
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
