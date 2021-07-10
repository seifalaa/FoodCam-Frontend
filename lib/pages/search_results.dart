import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({
    Key? key,
    required this.ingredientsDocs,
  }) : super(key: key);
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> ingredientsDocs;

  @override
  Widget build(BuildContext context) {
    final HomePageController _controller = HomePageController();
    final String lang = Provider.of<LanguageProvider>(context).langCode;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.results,
          style: TextStyle(
            color: KTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'basket/');
        },
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: FutureBuilder<List<Recipe>>(
        future: _controller.recipeSearchWithMultipleIngredients(
            ingredientsDocs, lang),
        builder: (context, snapshot) => snapshot.hasData
            ? GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) =>
                    RecipeBox(recipe: snapshot.data![index]),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: KPrimaryColor,
                ),
              ),
      ),
    );
  }
}
