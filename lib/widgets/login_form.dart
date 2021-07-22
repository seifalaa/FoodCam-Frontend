import 'package:flutter/material.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onLogin,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function onLogin;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextFormField(
                controller: passwordController,
                hint: AppLocalizations.of(context)!.password,
                validator: (input) {
                  if (input == '') {
                    return AppLocalizations.of(context)!.passwordError;
                  } else if (input!.length < 8) {
                    return AppLocalizations.of(context)!.passwordShort;
                  } else {
                    return null;
                  }
                },
                isObscure: true,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Align(
            //     alignment: Localizations.localeOf(context).languageCode == 'en'
            //         ? Alignment.centerRight
            //         : Alignment.centerLeft,
            //     child: TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         AppLocalizations.of(context)!.forgetPassword,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await onLogin();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      fontSize: _screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
