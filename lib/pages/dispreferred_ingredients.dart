import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/pages/empty_dispreferred_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisPreferredIngredients extends StatefulWidget {
  const DisPreferredIngredients({
    Key? key,
  }) : super(key: key);

  @override
  _DisPreferredIngredientsState createState() =>
      _DisPreferredIngredientsState();
}

class _DisPreferredIngredientsState extends State<DisPreferredIngredients> {
  final HomePageController _controller = HomePageController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> deleteItem() async {}

  void addItem() {
    showSearch(
      context: context,
      delegate: PreferredSearchDelegate('disPreferred'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
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
        onPressed: () {},
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: StreamBuilder(
          stream: langCode == 'ar'
              ? _fireStore.collection('DisPreferredIngredients-ar').snapshots()
              : _fireStore.collection('DisPreferredIngredients').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.docs.isNotEmpty
                    ? GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        children: [
                          for (int i = 0; i < snapshot.data!.docs.length; i++)
                            FutureBuilder<Ingredient>(
                                future: _controller
                                    .ingredientFromQueryDocumentSnapshot(
                                        snapshot.data!.docs[i]),
                                builder: (context, ingredientSnapshot) {
                                  return ingredientSnapshot.hasData
                                      ? IngredientBox(
                                          ingredient: ingredientSnapshot.data!,
                                          index: i,
                                          onDelete: deleteItem,
                                        )
                                      : Container();
                                }),
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
    );
  }
}
