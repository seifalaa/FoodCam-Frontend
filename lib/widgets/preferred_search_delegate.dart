import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../pages/no_results_page.dart';

class PreferredSearchDelegate extends SearchDelegate {
  PreferredSearchDelegate();

  List<Map<String, dynamic>> searchResults = [];

  final BackEndController _backendController = BackEndController();

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
    final String langCode = Localizations.localeOf(context).languageCode;
    if (searchResults.isNotEmpty && query.isNotEmpty) {
      return IngredientsList(
        searchResults: searchResults,
        controller: _backendController,
        langCode: langCode,
      );
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      //return Container();Q
      return StreamBuilder(
          stream: Stream.fromFuture(
            _backendController.ingredientpreferredSearch(query),
          ),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return IngredientsList(
                  searchResults: snapshot.data!,
                  langCode: langCode,
                  controller: _backendController,
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
        text: AppLocalizations.of(context)!.startSearchIng,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).getLangCode;
    if (query != '') {
      //return Container();
      return StreamBuilder(
          stream: Stream.fromFuture(
            _backendController.ingredientpreferredSearch(query),
          ),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return IngredientsList(
                  searchResults: snapshot.data!,
                  langCode: langCode,
                  controller: _backendController,
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
          text: AppLocalizations.of(context)!.startSearchIng);
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

  final BackEndController controller;
  final String langCode;

  final List<Map<String, dynamic>> searchResults;

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  _IngredientsListState();

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
              AddIngredientListTile(
                searchResult: widget.searchResults[index],
                controller: widget.controller,
                langCode: widget.langCode,
                onClick: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final String response =
                      await widget.controller.addPreferredIngredient(
                    widget.searchResults[index]['ingredient'].id,
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'prefIng/', ModalRoute.withName('profile/'));
                  if (response == 'Already Exists') {
                    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: AppLocalizations.of(context)!
                            .alreadyExistInDispreferred,
                      ),
                    );
                  }

                  setState(() {
                    _isLoading = false;
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
  }) : super(key: key);

  final BackEndController controller;
  final String langCode;
  final Function onClick;
  final Map<String, dynamic> searchResult;

  @override
  _AddIngredientListTileState createState() =>
      _AddIngredientListTileState(isAdded: searchResult['isAdded']);
}

class _AddIngredientListTileState extends State<AddIngredientListTile> {
  _AddIngredientListTileState({required this.isAdded});

  bool isAdded;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        widget.searchResult['ingredient'].ingredientImageUrl,
      ),
      title: Text(
        widget.searchResult['ingredient'].ingredientName,
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
