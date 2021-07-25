import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/pages/empty_preferred_page.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_overlay/loading_overlay.dart';

class PreferredIngredients extends StatefulWidget {
  const PreferredIngredients({
    Key? key,
  }) : super(key: key);

  @override
  _PreferredIngredientsState createState() => _PreferredIngredientsState();
}

class _PreferredIngredientsState extends State<PreferredIngredients> {
  final BackEndController _backendController = BackEndController();

  bool _isLoading = false;

  void addItem() {
    showSearch(
      context: context,
      delegate: PreferredSearchDelegate(),
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
          AppLocalizations.of(context)!.prefIng,
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
            stream: Stream.fromFuture(
                _backendController.getPreferredIngredients(_langCode)),
            builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
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
                                ingredient: snapshot.data![i],
                                index: i,
                                onDelete: deleteItem,
                              ),
                            AddBox(onTab: addItem),
                          ],
                        )
                      : const EmptyPreferredPage()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
            }),
      ),
    );
  }

  Future<void> deleteItem(String ingredientName, String langCode) async {
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
