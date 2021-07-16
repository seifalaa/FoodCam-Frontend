import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  const CustomButtonNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home/', (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          color:
                              ModalRoute.of(context)!.settings.name == 'home/'
                                  ? kPrimaryColor
                                  : const Color(0x70262626),
                        ),
                        Text(
                          AppLocalizations.of(context)!.home,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                ModalRoute.of(context)!.settings.name == 'home/'
                                    ? kPrimaryColor
                                    : const Color(0x70262626),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    if (ModalRoute.of(context)!.settings.name != 'profile/') {
                      Navigator.pushNamed(
                        context,
                        'profile/',
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, 'profile/');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: ModalRoute.of(context)!.settings.name ==
                                  'profile/'
                              ? kPrimaryColor
                              : const Color(0x70262626),
                        ),
                        Text(
                          AppLocalizations.of(context)!.profile,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ModalRoute.of(context)!.settings.name ==
                                    'profile/'
                                ? kPrimaryColor
                                : const Color(0x70262626),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
