import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/generated/l10n.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/pages/no_results_page.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final HomePageController _controller = HomePageController();
  List<Recipe> searchResults = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // searchResults = [];
          // buildResults(context);
        },
        icon: Icon(
          Icons.clear,
          color: KTextColor,
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
      icon: Icon(
        Icons.arrow_back_rounded,
        color: KTextColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    if (searchResults.isNotEmpty && query.isNotEmpty) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
          future: _controller.recipeSearch(query, langCode),
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.length != 0) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                return NoResultsPage();
              }
            } else
              return Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
              );
          });
    } else {
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    if (query != '') {
      return FutureBuilder(
          future: _controller.recipeSearch(query, langCode),
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.length != 0) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                return NoResultsPage();
              }
            } else
              return Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
              );
          });
    } else
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
  }
}
