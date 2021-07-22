import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RandomRecipePage extends StatelessWidget {
  const RandomRecipePage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final HomePageController _homepageController = HomePageController();
    final String _langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.randomRecipe,
          style: const TextStyle(
            color: kTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'basket/');
        },
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: StreamBuilder(
        stream: Stream.fromFuture(
          _homepageController.getRandomRecipe(_langCode, categoryName),
        ),
        builder: (context, AsyncSnapshot<Recipe> snapshot) => snapshot.hasData
            ? GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  RecipeBox(recipe: snapshot.data!),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }
}
