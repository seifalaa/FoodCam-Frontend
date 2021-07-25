import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/auth_controller.dart';
import 'package:foodcam_frontend/models/user.dart';
import 'package:foodcam_frontend/pages/allergies_page.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/pages/dispreferred_ingredients.dart';
import 'package:foodcam_frontend/pages/preferred_ingredients.dart';
import 'package:foodcam_frontend/pages/unloggedin_user_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/language_bottom_sheet.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final String _lang = Localizations.localeOf(context).languageCode;
    final AuthController _authController = AuthController();
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.black.withOpacity(0.3),
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BasketPage(),
              ),
            );
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.shopping_basket_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomButtonNavigationBar(),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.profile,
            style: const TextStyle(
              color: kTextColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: kTextColor,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder<User?>(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (snapshot.data == null) {
                return const UnLoggedInUserPage();
              } else {
                return Column(
                  children: [
                    Material(
                      color: Colors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x70000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      snapshot.data!.firstName[0]
                                              .toUpperCase() +
                                          snapshot.data!.lastName[0]
                                              .toUpperCase(),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: _lang == 'ar'
                                      ? const EdgeInsets.only(right: 20.0)
                                      : const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data!.firstName.toUpperCase()} ${snapshot.data!.lastName.toUpperCase()}',
                                        style: const TextStyle(
                                          color: kTextColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '@${snapshot.data!.userName}',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Divider(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
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
                                  leading: const Icon(
                                    Icons.grid_3x3_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.collections,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CollectionPage(),
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
                                  leading: const Icon(
                                    Icons.sentiment_satisfied_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.prefIng,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PreferredIngredients(),
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
                                  leading: const Icon(
                                    Icons.sentiment_dissatisfied_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                      AppLocalizations.of(context)!.disIng),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DisPreferredIngredients(),
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
                                  leading: const Icon(
                                    Icons.no_food_outlined,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.allergies,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllergiesPage(),
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
                                  leading: const Icon(
                                    Icons.language_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.lang,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => makeDismissible(
                                        child: LanguageBottomSheet(
                                          provider:
                                              Provider.of<LanguageProvider>(
                                            context,
                                            listen: false,
                                          ),
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
                                  leading: const Icon(
                                    Icons.logout_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.logout,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _authController.logout();
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'home/',
                                      (route) => false,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<User?> getUserInfo() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    final String? firstName = _sharedPreferences.getString('firstName');
    final String? lastName = _sharedPreferences.getString('lastName');
    return userName != null && firstName != null && lastName != null
        ? User(firstName: firstName, lastName: lastName, userName: userName)
        : null;
  }
}
