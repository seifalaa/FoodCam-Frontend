import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/empty_collection_page.dart';
import 'package:foodcam_frontend/pages/empty_collection_recipe_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_search_delegate.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:provider/provider.dart';

class CollectionsRecipes extends StatefulWidget {
  const CollectionsRecipes({
    Key? key,
    required this.collectionName,
    required this.recipes,
  }) : super(key: key);
  final String collectionName;
  final List<Recipe> recipes;

  @override
  _CollectionsRecipesState createState() => _CollectionsRecipesState();
}

class _CollectionsRecipesState extends State<CollectionsRecipes> {
  final BackEndController _backendController = BackEndController();

  @override
  Widget build(BuildContext context) {
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    String collectionNamee = "";
    if (_langCode == "ar") {
      if (widget.collectionName == 'Breakfast') {
        collectionNamee = "فطور";
      }
      else if (widget.collectionName == 'Dinner') {
        collectionNamee = "عشاء";
      }
      else if (widget.collectionName == 'Launch') {
        collectionNamee = "غداء";
      }
      else{collectionNamee = widget.collectionName;}
    } else {
      collectionNamee = widget.collectionName;
    }
    return Scaffold(
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
          collectionNamee,
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
      body: widget.recipes.isNotEmpty
          ? GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 0.8,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              children: [
                for (int i = 0; i < widget.recipes.length; i++)
                  RecipeBox(recipe: widget.recipes[i]),
                AddBox(
                  onTab: () {
                    showSearch(
                        context: context,
                        delegate: CollectionRecipeSearchDelegate());
                  },
                ),
              ],
            )
          : const emptyCollectionRecipePage(),
    );
  }
}
