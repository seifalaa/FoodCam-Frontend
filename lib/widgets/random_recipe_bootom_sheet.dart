import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/user.dart';
import 'package:foodcam_frontend/pages/random_recipe_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/unloggedin_generate_random_recipe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomRecipeBottomSheet extends StatelessWidget {
  const RandomRecipeBottomSheet({
    Key? key,
    /*required this.categories,*/
  }) : super(key: key);

  //final List<String>categories;

  @override
  Widget build(BuildContext context) {
    final BackEndController _backendController = BackEndController();
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    return DraggableScrollableSheet(
      maxChildSize: 0.7,
      minChildSize: 0.3,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
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
                    AppLocalizations.of(context)!.randomRecipe,
                    style: const TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            FutureBuilder(
              future: getUserInfo(),
              builder: (context, userInfoSnapshot) => userInfoSnapshot
                          .connectionState !=
                      ConnectionState.waiting
                  ? userInfoSnapshot.hasData
                      ? StreamBuilder(
                          stream: Stream.fromFuture(
                            _backendController.getCategoriesNames(_langCode),
                          ),
                          builder: (context,
                                  AsyncSnapshot<List<String>> snapshot) =>
                              snapshot.hasData
                                  ? Column(
                                      children: snapshot.data!
                                          .map(
                                            (e) => Column(
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RandomRecipePage(
                                                          categoryName: e,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  title: Text(
                                                    e,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                        )
                      : const UnloggedInGenerateRandomRecipe()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
            ),
            //Container(),
          ],
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
