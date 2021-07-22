import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/pages/random_recipe_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

class RandomRecipeBottomSheet extends StatelessWidget {
  const RandomRecipeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController _homePageController = HomePageController();
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
            StreamBuilder(
              stream: Stream.fromFuture(
                _homePageController.getCategoryNames(_langCode),
              ),
              builder: (context, AsyncSnapshot<List<String>> snapshot) =>
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
                                          fontWeight: FontWeight.bold,
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
            ),
          ],
        ),
      ),
    );
  }
}
