import 'package:flutter/material.dart';
import 'package:foodcam_frontend/pages/collections_recipes_page.dart';
import 'package:foodcam_frontend/pages/recipe_page.dart';

import '../constants.dart';

class CollectionBox extends StatelessWidget {
  const CollectionBox({
    Key? key,
    required this.imagePath,
    required this.category,
    this.recipeNumber,
    required this.isRecipe,
    required this.isIngredient,
  }) : super(key: key);
  final imagePath;
  final recipeNumber;
  final category;
  final bool isRecipe;
  final bool isIngredient;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
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
                color: Color(0x40000000),
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
                    category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= KMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (recipeNumber != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        recipeNumber,
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
                if (!isRecipe && !isIngredient) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionsRecipes(
                        collectionName: category,
                      ),
                    ),
                  );
                }
                // if (isRecipe) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => RecipePage(),
                //     ),
                //   );
                // }
              },
              onLongPress: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => makeDismissible(
                    child: DraggableScrollableSheet(
                      minChildSize: 0.3,
                      maxChildSize: 0.3,
                      initialChildSize: 0.3,
                      builder: (context, scrollController) => Container(
                        color: KBgColor,
                        child: Material(
                          color: KBgColor,
                          child: ListView(
                            controller: scrollController,
                            children: [
                              Material(
                                elevation: 1,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Options',
                                      style: TextStyle(
                                        color: KTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    context: context,
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
