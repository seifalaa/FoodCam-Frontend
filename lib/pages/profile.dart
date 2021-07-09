import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/pages/allergies_page.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/pages/dispreferred_ingredients.dart';
import 'package:foodcam_frontend/pages/preferred_ingredients.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/language_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BasketPage()),
          );
        },
        backgroundColor: KPrimaryColor,
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomButtonNavigationBar(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(
            color: KTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Material(
            color: Colors.white,
            elevation: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x70000000),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'lib/assets/man.png',
                          ),
                        ),
                      ),
                      Padding(
                        padding: _lang == 'ar'
                            ? const EdgeInsets.only(right: 20.0)
                            : const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saeed Mohamed',
                              style: TextStyle(
                                color: KTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@s3dolla',
                              style: TextStyle(
                                color: KPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: KPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Divider(),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.grid_3x3_rounded,
                          color: KPrimaryColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.collections,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CollectionPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.sentiment_satisfied_rounded,
                          color: KPrimaryColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.prefIng,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreferrredIngredients(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          color: KPrimaryColor,
                        ),
                        title: Text(AppLocalizations.of(context)!.disIng),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisPreferrredIngredients(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.no_food_outlined,
                          color: KPrimaryColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.allergies,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllergiesPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.language_rounded,
                          color: KPrimaryColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.lang,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => makeDismissible(
                              child: LanguageBottomSheet(
                                provider: Provider.of<LanguageProvider>(context,
                                    listen: false),
                              ),
                              context: context,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 1,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.logout_rounded,
                          color: KPrimaryColor,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.logout,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: KPrimaryColor,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
