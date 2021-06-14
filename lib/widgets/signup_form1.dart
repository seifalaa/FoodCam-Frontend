import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/pages/signup2.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';

import '../constants.dart';

class SignupForm1 extends StatelessWidget {
  const SignupForm1({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.formKey,
  }) : super(key: key);
  final firstNameController;
  final lastNameController;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.welcome,
              style: TextStyle(
                fontSize: 50,
                color: KTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(AppLocalizations.of(context)!.knowYourName),
            ),
            SizedBox(
              height: 50,
            ),
            CustomTextFormField(
                validator: (input) {
                  return input == ''
                      ? AppLocalizations.of(context)!.fnameError
                      : null;
                },
                hint: AppLocalizations.of(context)!.fname,
                controller: firstNameController,
                isObscure: false),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CustomTextFormField(
                validator: (input) {
                  return input == ''
                      ? AppLocalizations.of(context)!.lnameError
                      : null;
                },
                hint: AppLocalizations.of(context)!.lname,
                controller: lastNameController,
                isObscure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: KPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_forward_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
