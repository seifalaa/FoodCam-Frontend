import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/no_results_page.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class CollectionRecipeSearchDelegate extends SearchDelegate {
  final HomePageController _homePageController = HomePageController();

  List<Recipe> searchResults = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
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
    final String _langCode = Localizations.localeOf(context).languageCode;
    if (searchResults.isNotEmpty && query.isNotEmpty) {
      return IngredientsList(
        searchResults: searchResults,
        controller: _homePageController,
        langCode: _langCode,
      );
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      return Container();
      // return StreamBuilder(
      //     stream: Stream.fromFuture(
      //       _homePageController.recipeSearch(query, _langCode),
      //     ),
      //     builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
      //       if (snapshot.hasData) {
      //         searchResults = snapshot.data!;
      //         if (snapshot.data!.isNotEmpty) {
      //           return IngredientsList(
      //             searchResults: snapshot.data!,
      //             langCode: _langCode,
      //             controller: _homePageController,
      //           );
      //         } else {
      //           return const NoResultsPage();
      //         }
      //       } else {
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: kPrimaryColor,
      //           ),
      //         );
      //       }
      //     });
    } else {
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).getLangCode;
    if (query != '') {
      return Container();
      // return StreamBuilder(
      //     stream: Stream.fromFuture(
      //       _homePageController.recipeSearch(query, langCode),
      //     ),
      //     builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
      //       if (snapshot.hasData) {
      //         searchResults = snapshot.data!;
      //         if (snapshot.data!.isNotEmpty) {
      //           return IngredientsList(
      //             searchResults: snapshot.data!,
      //             langCode: langCode,
      //             controller: _homePageController,
      //           );
      //         } else {
      //           return const NoResultsPage();
      //         }
      //       } else {
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: kPrimaryColor,
      //           ),
      //         );
      //       }
      //     });
    } else {
      return StartSearchPage(
        text: AppLocalizations.of(context)!.startSearch,
      );
    }
  }
}

class IngredientsList extends StatefulWidget {
  const IngredientsList(
      {Key? key,
      required this.searchResults,
      required this.controller,
      required this.langCode})
      : super(key: key);

  final HomePageController controller;
  final String langCode;
  final List<Recipe> searchResults;

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  bool _isImageLoading = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.black,
      opacity: 0.1,
      isLoading: _isLoading | _isImageLoading,
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: ListView.builder(
        itemCount: widget.searchResults.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              AddIngredientListTile(
                searchResult: widget.searchResults[index],
                controller: widget.controller,
                langCode: widget.langCode,
                onClick: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  //TODO:add recipe here

                  setState(() {
                    _isLoading = false;
                  });
                },
                imageLoading: () {
                  setState(() {
                    _isImageLoading = true;
                  });
                },
                imageNotLoading: () {
                  setState(() {
                    _isImageLoading = false;
                  });
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddIngredientListTile extends StatefulWidget {
  const AddIngredientListTile({
    Key? key,
    required this.searchResult,
    required this.controller,
    required this.langCode,
    required this.onClick,
    required this.imageLoading,
    required this.imageNotLoading,
  }) : super(key: key);

  final HomePageController controller;
  final String langCode;
  final Function onClick;
  final Recipe searchResult;
  final Function imageLoading;
  final Function imageNotLoading;

  @override
  _AddIngredientListTileState createState() =>
      _AddIngredientListTileState(isAdded: false);
}

class _AddIngredientListTileState extends State<AddIngredientListTile> {
  _AddIngredientListTileState({required this.isAdded});

  bool isAdded;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadImage());
  }

  Future loadImage() async {
    widget.imageLoading();
    await cacheImage(
      context,
      widget.searchResult.recipeImageUrl,
    );
    widget.imageNotLoading();
  }

  Future cacheImage(BuildContext context, String imageUrl) async {
    precacheImage(CachedNetworkImageProvider(imageUrl), context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: ClipRRect(
        borderRadius:BorderRadius.circular(10),
        child: Image(

            image: CachedNetworkImageProvider(
              widget.searchResult.recipeImageUrl,
            ),
            fit: BoxFit.cover),
      ),
      title: Text(
        widget.searchResult.recipeName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: isAdded
          ? const Padding(
              padding: EdgeInsets.all(11.0),
              child: Icon(
                Icons.check_rounded,
                color: kPrimaryColor,
              ),
            )
          : IconButton(
              onPressed: () async {
                await widget.onClick();
                setState(() {
                  isAdded = true;
                });
              },
              icon: const Icon(
                Icons.add_rounded,
                color: kPrimaryColor,
              ),
            ),
    );
  }
}
