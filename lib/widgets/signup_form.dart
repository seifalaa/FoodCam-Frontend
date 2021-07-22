import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';

import '../constants.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.emailController,
    required this.firstName,
    required this.lastName,
    required this.onSignup,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final TextEditingController emailController;
  final String firstName;
  final String lastName;
  final Function onSignup;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                AppLocalizations.of(context)!.hi + firstName,
                style: TextStyle(
                  fontSize: _screenWidth * 0.09,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                AppLocalizations.of(context)!.continueAccountSetup,
                style: TextStyle(
                  fontSize: _screenWidth * 0.04,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextFormField(
              validator: (input) {
                return input == ''
                    ? AppLocalizations.of(context)!.usernameError
                    : null;
              },
              hint: AppLocalizations.of(context)!.username,
              controller: usernameController,
              isObscure: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextFormField(
                validator: (input) {
                  if (input == '') {
                    return AppLocalizations.of(context)!.emailError;
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                      .hasMatch(input!)) {
                    return AppLocalizations.of(context)!.invalidEmail;
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context)!.email,
                controller: emailController,
                isObscure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextFormField(
                validator: (input) {
                  if (input == '') {
                    return AppLocalizations.of(context)!.passwordError;
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(input!)) {
                    return AppLocalizations.of(context)!.invalidPassword;
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context)!.password,
                controller: passwordController,
                isObscure: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextFormField(
                validator: (input) {
                  if (input == '') {
                    return AppLocalizations.of(context)!.repeatPasswordError;
                  }
                  if (passwordController.text != input) {
                    return AppLocalizations.of(context)!
                        .repeatPasswordErrorIdentical;
                  }
                  return null;
                },
                hint: AppLocalizations.of(context)!.repeatPassword,
                controller: repeatPasswordController,
                isObscure: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  await onSignup();
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.create,
                    style: const TextStyle(
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
    );
  }
}
