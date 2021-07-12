import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../pages/no_results_page.dart';

class PreferredSearchDelegate extends SearchDelegate {
  final HomePageController _controller = HomePageController();
   final String page;
  List<Ingredient> searchResults = [];

  PreferredSearchDelegate(this.page);

  

 

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
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
      return IngredientsList(
        searchResults: searchResults,
        controller: _controller,
        pagename: page,
        langCode: langCode,
      );
      
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      return FutureBuilder(
          future: _controller.ingredientSearch(query, langCode),
          builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.length != 0) {
                return IngredientsList(
                  searchResults: snapshot.data,
                  langCode: langCode,
                  pagename: page,
                  controller: _controller,
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
        text: AppLocalizations.of(context)!.startSearchIng,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    if (query != '') {
      return FutureBuilder(
          future: _controller.ingredientSearch(query, langCode),
          builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.length != 0) {
                return IngredientsList(
                  searchResults: snapshot.data,
                  langCode: langCode,
                  pagename: page,
                  controller: _controller,
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
          text: AppLocalizations.of(context)!.startSearchIng);
  }
}

class IngredientsList extends StatefulWidget {
  const IngredientsList(
      {Key? key,
      required this.searchResults,
      required this.controller,
      required this.pagename,
      required this.langCode})
      : super(key: key);
  final searchResults;
  final controller;
  final langCode;
  final pagename;

  @override
  _IngredientsListState createState() => _IngredientsListState(pagename);
}

class _IngredientsListState extends State<IngredientsList> {
  bool _isLoading = false;

  final String pageName;

  _IngredientsListState(  this.pageName);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      progressIndicator: CircularProgressIndicator(
        color: KPrimaryColor,
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
                    
                    if(pageName == 'basket'){
                    await widget.controller.addIngredientInBasket(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                    }
                    if( pageName == 'preferred'){
                    await widget.controller.addIngredientInPreferred(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                    }
                    if(pageName =='disPreferred'){
                    await widget.controller.addIngredientInDisPreferred(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
                Divider(),
              ],
            )),
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
  final searchResult;
  final controller;
  final langCode;
  final onClick;

  @override
  _AddIngredientListTileState createState() =>
      _AddIngredientListTileState(isAdded: searchResult.addedToBasket);
}

class _AddIngredientListTileState extends State<AddIngredientListTile> {
  bool isAdded;

  _AddIngredientListTileState({required this.isAdded});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.searchResult.ingredientImageUrl,
          fit: BoxFit.cover),
      title: Text(
        widget.searchResult.ingredientName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: isAdded
          ? Padding(
              padding: const EdgeInsets.all(11.0),
              child: Icon(
                Icons.check_rounded,
                color: KPrimaryColor,
              ),
            )
          : IconButton(
              onPressed: () async {
                await widget.onClick();
                setState(() {
                  isAdded = true;
                });
              },
              icon: Icon(
                Icons.add_rounded,
                color: KPrimaryColor,
              ),
            ),
    );
  }
}
