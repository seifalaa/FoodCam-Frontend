import 'package:cached_network_image/cached_network_image.dart';
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
  PreferredSearchDelegate(this.page);

  final String page;
  List<Ingredient> searchResults = [];

  final HomePageController _controller = HomePageController();

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
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    if (searchResults.isNotEmpty && query.isNotEmpty) {
      return IngredientsList(
        searchResults: searchResults,
        controller: _controller,
        pageName: page,
        langCode: langCode,
      );
    } else if (searchResults.isEmpty && query.isNotEmpty) {
      return StreamBuilder(
          stream: Stream.fromFuture(
            _controller.ingredientSearch(query, langCode),
          ),
          builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return IngredientsList(
                  searchResults: snapshot.data!,
                  langCode: langCode,
                  pageName: page,
                  controller: _controller,
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
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    if (query != '') {
      return StreamBuilder(
          stream: Stream.fromFuture(
            _controller.ingredientSearch(query, langCode),
          ),
          builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
            if (snapshot.hasData) {
              searchResults = snapshot.data!;
              if (snapshot.data!.isNotEmpty) {
                return IngredientsList(
                  searchResults: snapshot.data!,
                  langCode: langCode,
                  pageName: page,
                  controller: _controller,
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
      required this.pageName,
      required this.langCode})
      : super(key: key);

  final HomePageController controller;
  final String langCode;
  final String pageName;
  final List<Ingredient> searchResults;

  @override
  _IngredientsListState createState() => _IngredientsListState(pageName);
}

class _IngredientsListState extends State<IngredientsList> {
  _IngredientsListState(this.pageName);

  final String pageName;
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

                  if (pageName == 'basket') {
                    await widget.controller.addIngredientInBasket(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                  }
                  if (pageName == 'preferred') {
                    await widget.controller.addIngredientInPreferred(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                  }
                  if (pageName == 'disPreferred') {
                    await widget.controller.addIngredientInDisPreferred(
                      widget.searchResults[index],
                      widget.langCode,
                    );
                  }
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
  final Ingredient searchResult;
  final Function imageLoading;
  final Function imageNotLoading;

  @override
  _AddIngredientListTileState createState() =>
      _AddIngredientListTileState(isAdded: searchResult.addedToBasket);
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
    await cacheImage(context, widget.searchResult.ingredientImageUrl);
    widget.imageNotLoading();
  }

  Future cacheImage(BuildContext context, String imageUrl) async {
    precacheImage(CachedNetworkImageProvider(imageUrl), context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
          image: CachedNetworkImageProvider(
              widget.searchResult.ingredientImageUrl),
          fit: BoxFit.cover),
      title: Text(
        widget.searchResult.ingredientName,
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
