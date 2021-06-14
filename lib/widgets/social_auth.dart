import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({
    Key? key,
    required this.onGoogleAuth,
    required this.onFacebookAuth,
  });

  final onGoogleAuth;
  final onFacebookAuth;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
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
              AppLocalizations.of(context)!.orWith,
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
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  onFacebookAuth();
                },
                child: Image.asset(
                  'lib/assets/facebook.png',
                  width: _screenWidth * 0.1,
                  height: _screenHeight * 0.09,
                ),
              ),
              TextButton(
                onPressed: () {
                  onGoogleAuth();
                },
                child: Image.asset(
                  'lib/assets/search.png',
                  width: _screenWidth * 0.095,
                  height: _screenHeight * 0.085,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
