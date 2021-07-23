import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/pages/no_results_page.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final BackEndController _backendController = BackEndController();
  List<Recipe> searchResults = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear_rounded,
          color: kTextColor,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: kTextColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String __langCode = Localizations.localeOf(context).languageCode;
    if (searchResults.isNotEmpty && query.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 600,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) => RecipeBox(
          recipe: searchResults[index],
        ),
      );
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      return FutureBuilder(
          future: _backendController.searchRecipeByName(query),
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 600,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => RecipeBox(
                    recipe: snapshot.data![index],
                  ),
                );
              } else {
                return const NoResultsPage();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }
          });
    } else {
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    if (query != '') {
      return FutureBuilder(
        future: _backendController.searchRecipeByName(query),
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (snapshot.hasData) {
            searchResults = snapshot.data!;
            if (snapshot.data!.isNotEmpty) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => RecipeBox(
                  recipe: snapshot.data![index],
                ),
              );
            } else {
              return const NoResultsPage();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
        },
      );
    } else {
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
    }
  }
}
