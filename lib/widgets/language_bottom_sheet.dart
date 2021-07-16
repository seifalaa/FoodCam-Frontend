import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key, required this.provider})
      : super(key: key);
  final LanguageProvider provider;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.35,
      minChildSize: 0.3,
      builder: (context, scrollController) => Container(
        color: kBgColor,
        child: Material(
          color: kBgColor,
          child: ListView(
            controller: scrollController,
            children: [
              Material(
                elevation: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      AppLocalizations.of(context)!.changeLang,
                      style: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  if (provider.langCode != 'ar') {
                    provider.changeLang('ar');
                  }
                },
                title: Text(
                  AppLocalizations.of(context)!.ar,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  'lib/assets/saudi-arabia.png',
                  height: 50,
                ),
                trailing: provider.langCode == 'ar'
                    ? const Icon(
                        Icons.check_outlined,
                        color: kPrimaryColor,
                      )
                    : null,
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  if (provider.langCode != 'en') {
                    provider.changeLang('en');
                  }
                },
                title: Text(
                  AppLocalizations.of(context)!.en,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  'lib/assets/united-states.png',
                  height: 50,
                ),
                trailing: provider.langCode == 'en'
                    ? const Icon(
                        Icons.check_outlined,
                        color: kPrimaryColor,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
