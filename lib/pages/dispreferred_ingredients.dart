import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/pages/empty_dispreferred_page.dart';
import 'package:foodcam_frontend/pages/empty_preferred_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/dispreferred_search_deleget.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class DisPreferredIngredients extends StatefulWidget {
  const DisPreferredIngredients({
    Key? key,
  }) : super(key: key);

  @override
  _DisPreferredIngredientsState createState() => _DisPreferredIngredientsState();
}

class _DisPreferredIngredientsState extends State<DisPreferredIngredients> {
  final BackEndController _backendController = BackEndController();
  //final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  bool _isLoading = false;

  void addItem() {
    showSearch(
      context: context,
      delegate: DisPreferredSearchDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String _langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.disIng,
          style: const TextStyle(color: kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, 'basket/');
        },
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black.withOpacity(0.1),
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: StreamBuilder(
            stream:Stream.fromFuture(_backendController.getDisPreferedIngredients(_langCode)),
            builder: (context,
                AsyncSnapshot<List<Ingredient>> snapshot) {
              return snapshot.hasData
                  ? snapshot.data!.isNotEmpty
                  ? GridView(
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  //childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: [
                  for (int i = 0; i < snapshot.data!.length; i++)
                    IngredientBox(
                      ingredient:
                      snapshot.data![i],
                      index: i,
                      onDelete: deleteItem,
                    ),
                  AddBox(onTab: addItem),
                ],
              )
                  : const EmptyDisPreferredPage()
                  : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }),
      ),
    );
  }

  Future<void> deleteItem(String ingredientName,String langCode) async {
    setState(() {
      _isLoading = true;
    });
    // await _homePageController.deletePreferredIngredient(
    //     langCode, ingredientName);
    setState(() {
      _isLoading = false;
    });
  }
}
