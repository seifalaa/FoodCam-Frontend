import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/category_page.dart';

import '../constants.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    Key? key,
    required this.imagePath,
    required this.categoryName,
    required this.recipes,
  }) : super(key: key);
  final imagePath;
  final categoryName;
  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    String _lang = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x50000000),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= KMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      handleRecipesOrRecipe(recipes.length, _lang),
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.bold,
                        fontSize: _screenWidth <= KMobileScreenSize
                            ? _screenWidth * 0.038
                            : _screenWidth * 0.0194,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.transparent,
                splashColor: Color(0x50D0F1DD),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                          categoryName: categoryName, recipes: recipes),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String handleRecipesOrRecipe(quantity, lang) {
    if (lang == 'ar') {
      if (quantity > 1 && quantity < 11) {
        return quantity == 2 ? 'وصفتين' : quantity.toString() + ' وصفات';
      } else
        return 'وصفة';
    } else if (lang == 'en') {
      return quantity == 1
          ? quantity.toString() + ' recipe'
          : quantity.toString() + ' recipes';
    } else
      return '';
  }
}
