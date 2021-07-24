import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/pages/start_search_page.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../pages/no_results_page.dart';

class BasketSearchDelegate extends SearchDelegate {
  BasketSearchDelegate();


  List<Map<String,dynamic>> searchResults = [];

  //final HomePageController _homePageController = HomePageController();
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
            _backendController.ingredientBasketSearch(query),
          ),
          builder: (context, AsyncSnapshot<List<Map<String,dynamic>>> snapshot) {
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
            _backendController.ingredientBasketSearch(query),
          ),
          builder: (context, AsyncSnapshot<List<Map<String,dynamic>>> snapshot) {

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

  final List<Map<String,dynamic>> searchResults;

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
      isLoading: _isLoading ,
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

                  await widget.controller.addIngredientInBasket(
                    widget.searchResults[index]['ingredient'].id,

                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'basket/', ModalRoute.withName('home/'));

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
  final Map<String,dynamic> searchResult;


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

        // widget.searchResult.ingredientImageUrl
        // https://lh3.googleusercontent.com/UTW1wxp9bfxz1bhJDKEMSwUE6WLSoc_YMEAW_4WJrtOnDiuNgXihNMP0wOu3dFkgem7mYr_Y7dXDdaq-9SIg-Rfvcfzx7B3X7d0h3AVt-XPm1XCB-I1-T44FkfjaSagvxYOMtOXQw9TnPnvPHcW0JhlEP63dE8JsGfBZ6L0np48I-plEqynftj7n94j2fea41xfMkFZzfI3uCmNnMUXM7fLBfUNrDS7rhbbw7SaSPWE0Z6H-c9nFUgysoC934zdnvCaGwavkVQEev0FMUfxEGfXOF07hA9N2LoMB_5pJR0lPgPBxKEB07VGBstOPsfOH5vVm6bj1-8pPO_PN5whOs4NRQI0iGjLtzCjqzQMABVSBg2iss6ryPKaD9bJ9A5Yi1pl5CoRY45nL9F8EAaBXB2XdWbbtfCN1JJDrS5gYcHhVo5acPTWw5ZgWWui65EOKBjGBA0HBUEAxFt6mLM7UU2hXb__rF1Rfx5Ged9Bq3olqQwZ-TfnZen46APSye9-w7yhxcbcezjHTxtz6-zeUbu27PA-4ASSHQNHmGs3f3jEQqMJusq4lyIR8b1b-dvyL6oOmYso-wtSOQA0P9JT3P7yP0zx4nJb0DuxAiqxw5lvn8me9YyXGsDl9ODeVxgKkqKo_x22YtL_SDfZqpD-SfeLutCSqLx8gxdaAJKRbVLASSBUVsOauIG4aCG4MKOIO9aNH4yaazwtMntL5_Xc2EkmZ=w630-h300-no?authuser=0
          'https://lh3.googleusercontent.com/YyQQ9BJBBfbavol1bRbjTTG4mVHjaj6-XgXAjuRQunhtVKIRc5yXJKITfSsHNWkeLwFm6vTmm7SFjeHUB9nnq1d-myD-m_iJBxffX3Cgvo5WoLyyVWQZeq5Nw8hZ2_zgqUJrzKGh-B0I_etDQxR-Wy_KfnuyYg68fX_vleXKHtdgItrq3uBQcDN1tSaJJRC4_AED0aeNcL_8LTIMKqy0DObqIpJxhKhe8UP0npLm0BVthty9At78oCkhUh8cBN4ZG7N0jA9n4_HOvmhOvHSlZ4Zqorp7g1Y8SQbg7iPjsP1U_97r1wgabdK_wPfWT5LQI_vC_yNt76iJf-wTnjzDQanjND1_8y8ys4rqNJYhMZDnMdB6xRjn24lIST8IsLoJvyD6qwzae5aNuTE19K1pBqFxkZfVW-n0cv199vD4CdR1hRVVr8Be8Otc9wHvEueu2Tu2et8qPewQzMh3c5mh1NCS1-4cpraM2soHUZ80TzbrrWwsj6FuGlYkvnoL9TtPI1CoFd3IsAKOEAWVUGttBgBjp5emyFg1BVKS7T9QemDA0i3pnMaODjemAQzliw5oNluYH5tcEnzTGwTlorWrsMOidpzxgAOdYsa24SJe2Y6cm7VFD470QiXAU0mraTizHffnP8rOLbO9Uo3Gjhe3W_OIgxZOEJt96sQx2jE8paRYLQ3L6DMzONRJ4UKh3i9ljcWNlAkDhtRrLRnV8A1nkVE1=w630-h300-no?authuser=0'
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
