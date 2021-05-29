import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/login_bg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                            'Login',
                            style: TextStyle(
                              color: KTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(100),
                            elevation: 10.0,
                            shadowColor: Color(0xB0000000),
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Username',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(100),
                              elevation: 10.0,
                              shadowColor: Color(0xB0000000),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
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
                              onPressed: () {},
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
                          onPressed: () {},
                          child: Image.asset(
                            'lib/assets/facebook.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
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
                        onPressed: () {},
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
