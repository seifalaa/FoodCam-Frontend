import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/pages/no_results_page.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class CollectionRecipeSearchDelegate extends SearchDelegate {
  final BackEndController _backEndController = BackEndController();
  final Collection collection;
  List<Map<String, dynamic>> searchResults = [];

  CollectionRecipeSearchDelegate({required this.collection});

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
      return RecipesList(
        searchResults: searchResults,
        controller: _backEndController,
        langCode: _langCode,
        collection: collection,
      );
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      return StreamBuilder(
          stream: Stream.fromFuture(
            _backEndController.getRecipesIntoCollection(
              query,
              collection.collectionName,
            ),
          ),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return RecipesList(
                  searchResults: snapshot.data!,
                  langCode: _langCode,
                  controller: _backEndController,
                  collection: collection,
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
      return StreamBuilder(
          stream: Stream.fromFuture(
            _backEndController.getRecipesIntoCollection(
              query,
              collection.collectionName,
            ),
          ),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return RecipesList(
                  searchResults: snapshot.data!,
                  langCode: _langCode,
                  controller: _backEndController,
                  collection: collection,
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
}

class RecipesList extends StatefulWidget {
  const RecipesList({
    Key? key,
    required this.searchResults,
    required this.collection,
    required this.controller,
    required this.langCode,
  }) : super(key: key);

  final BackEndController controller;
  final String langCode;
  final List<Map<String, dynamic>> searchResults;
  final Collection collection;

  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.black,
      opacity: 0.1,
      isLoading: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: kPrimaryColor,
      ),
      child: ListView.builder(
        itemCount: widget.searchResults.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              AddRecipeListTile(
                searchResult: widget.searchResults[index],
                controller: widget.controller,
                langCode: widget.langCode,
                onClick: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  //TODO:add recipe here
                  //print(widget.searchResults[index]);
                  await widget.controller.addRecipeInCollection(
                      widget.searchResults[index]['recipe'].recipeId,
                      widget.collection.id);

                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'collections/', ModalRoute.withName('profile/'));
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

class AddRecipeListTile extends StatefulWidget {
  const AddRecipeListTile({
    Key? key,
    required this.searchResult,
    required this.controller,
    required this.langCode,
    required this.onClick,
  }) : super(key: key);

  final BackEndController controller;
  final String langCode;
  final Function onClick;
  final Map<String, dynamic> searchResult;

  @override
  _AddRecipeListTileState createState() =>
      _AddRecipeListTileState(isAdded: searchResult['isAdded']);
}

class _AddRecipeListTileState extends State<AddRecipeListTile> {
  _AddRecipeListTileState({required this.isAdded});

  bool isAdded;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://media-exp3.licdn.com/dms/image/C561BAQHnh3Tsc_uBKQ/company-background_10000/0/1561589281326?e=2159024400&v=beta&t=3cfGYoRfVwt5-vQJL_x4W7MrP_uwZB-PRzqqpfBr5Gg',
          fit: BoxFit.cover,
        ),
        //child: Container(),
      ),
      title: Text(
        widget.searchResult['recipe'].recipeName,
        style: const TextStyle(
          fontSize: 15,
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
