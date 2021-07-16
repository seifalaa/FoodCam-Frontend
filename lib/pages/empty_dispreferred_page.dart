import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';

class EmptyDisPreferredPage extends StatelessWidget {
  const EmptyDisPreferredPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.startDisPreferred,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: PreferredSearchDelegate('disPreferred'),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.addIng,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
