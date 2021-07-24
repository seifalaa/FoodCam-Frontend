import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/no_results_page.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import '../constants.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({
    Key? key,
    required this.ingredientsDocs,
  }) : super(key: key);
  final List<Ingredient> ingredientsDocs;

  @override
  Widget build(BuildContext context) {
    final BackEndController _backendController = BackEndController();
    final String lang = Localizations.localeOf(context).languageCode;
    final List<String> ingredientsName = [];
    for (final item in ingredientsDocs) {
      ingredientsName.add(item.ingredientName);
    }
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.results,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: FutureBuilder<List<Recipe>>(
        future: _backendController.searchByMultipleIngredients(
            lang, ingredientsName),
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data!.isNotEmpty
                ? GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) =>
                        RecipeBox(recipe: snapshot.data![index]),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
            : const NoResultsPage(),
      ),
    );
  }
}
