import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import '../constants.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
    required this.categoryName,
    required this.recipes,
  }) : super(key: key);
  final String categoryName;
  final List<Recipe> recipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: KTextColor),
        title: Text(
          categoryName,
          style: TextStyle(
            color: KTextColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 0.8,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: [
          for (var i = 0; i < recipes.length; i++)
            RecipeBox(recipe: recipes[i]),
          AddBox(onTab: () {}),
        ],
      ),
    );
  }
}
