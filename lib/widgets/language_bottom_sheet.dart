import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/generated/l10n.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key,required this.provider}) : super(key: key);
  final LangUageProvider provider;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.35,
      minChildSize: 0.3,
      builder: (context, scrollController) => Container(
        color: KBgColor,
        child: Material(
          color: KBgColor,
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
                      style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  if (provider.langCode != 'ar') {
                    Provider.of<LangUageProvider>(context, listen: false)
                        .changeLang('ar');
                  }
                },
                title: Text(
                  AppLocalizations.of(context)!.ar,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  'lib/assets/saudi-arabia.png',
                  height: 50,
                ),
                trailing:
                   provider.langCode == 'ar'
                        ? Icon(
                            Icons.check_outlined,
                            color: KPrimaryColor,
                          )
                        : null,
              ),
              Divider(),
              ListTile(
                onTap: () {
                  if (provider.langCode != 'en') {
                    provider
                        .changeLang('en');
                  }
                },
                title: Text(
                  AppLocalizations.of(context)!.en,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  'lib/assets/united-states.png',
                  height: 50,
                ),
                trailing:
                   provider.langCode == 'en'
                        ? Icon(
                            Icons.check_outlined,
                            color: KPrimaryColor,
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
