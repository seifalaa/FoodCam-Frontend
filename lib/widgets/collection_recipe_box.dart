import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/recipe_page.dart';

import '../constants.dart';

class CollectionRecipeBox extends StatefulWidget {
  const CollectionRecipeBox({
    Key? key,
    required this.recipe,
    required this.onDelete,
    required this.collection,
  }) : super(key: key);
  final Recipe recipe;
  final Collection collection;
  final Function onDelete;

  @override
  _CollectionRecipeBoxState createState() => _CollectionRecipeBoxState();
}

class _CollectionRecipeBoxState extends State<CollectionRecipeBox> {
  List<Widget> getRate(double rate, double _screenWidth) {
    final List<Widget> stars = [];
    for (int i = 0; i < rate.toInt(); i++) {
      stars.add(
        Icon(
          Icons.star_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: const Color(0xFFFFC107),
        ),
      );
    }
    final bool noHalves = rate.toInt() == rate;
    if (noHalves) {
      for (int i = 0; i < 5 - widget.recipe.recipeRate.toInt(); i++) {
        stars.add(
          Icon(
            Icons.star_rounded,
            size: _screenWidth <= kMobileScreenSize
                ? _screenWidth * 0.045
                : _screenWidth * 0.0225,
            color: Colors.white54,
          ),
        );
      }
    } else {
      stars.add(
        Icon(
          Icons.star_half_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: const Color(0xFFFFC107),
        ),
      );
      for (int i = 0; i < 5 - widget.recipe.recipeRate.toInt() - 1; i++) {
        stars.add(Icon(
          Icons.star_rounded,
          size: _screenWidth <= kMobileScreenSize
              ? _screenWidth * 0.045
              : _screenWidth * 0.0225,
          color: Colors.white54,
        ));
      }
    }
    return stars;
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.recipe.recipeImageUrl,
                fit: BoxFit.cover,
              ),
              // child: Container(),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x40000000),
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
                    widget.recipe.recipeName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= kMobileScreenSize
                          ? _screenWidth * 0.05
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: getRate(
                      widget.recipe.recipeRate,
                      _screenWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
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
                splashColor: const Color(0x50D0F1DD),
                onTap: () {
                  _isVisible
                      ? setState(() {
                          _isVisible = false;
                        })
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipePage(
                              recipe: widget.recipe,
                            ),
                          ),
                        );
                },
                onLongPress: () {
                  setState(() {
                    _isVisible = true;
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Positioned(
                child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.zero,
                  primary: Colors.red,
                ),
                onPressed: () async {
                  await widget.onDelete(
                    widget.recipe.recipeId,
                    widget.collection.id,
                  );
                  setState(() {
                    _isVisible = false;
                  });
                },
                child: const Icon(Icons.clear),
              ),
            )),
          )
        ],
      ),
    );
  }
}
