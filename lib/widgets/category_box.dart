import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/pages/category_page.dart';

import '../constants.dart';

class CategoryBox extends StatefulWidget {
  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;

  @override
  _CategoryBoxState createState() =>
      _CategoryBoxState(category.categoryImageUrl);
}

class _CategoryBoxState extends State<CategoryBox> {
  final String imageUrl;

  _CategoryBoxState(this.imageUrl);

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadImage());
  }

  Future loadImage() async {
    setState(() {
      isLoading = true;
    });
    await cacheImage(context, imageUrl);
    setState(() {
      isLoading = false;
    });
  }

  Future cacheImage(BuildContext context, String imageUrl) async {
    precacheImage(CachedNetworkImageProvider(imageUrl), context);
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _lang = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: !isLoading
          ? Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: CachedNetworkImageProvider(
                          widget.category.categoryImageUrl),
                      fit: BoxFit.cover,
                    ),
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
                          widget.category.categoryName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _screenWidth <= kMobileScreenSize
                                ? _screenWidth * 0.045
                                : _screenWidth * 0.0225,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            handleRecipesOrRecipe(
                                widget.category.recipes.length, _lang),
                            style: TextStyle(
                              color: const Color(0xFFFFC107),
                              fontWeight: FontWeight.bold,
                              fontSize: _screenWidth <= kMobileScreenSize
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
                      splashColor: const Color(0x50D0F1DD),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              categoryName: widget.category.categoryName,
                              recipes: widget.category.recipes,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  String handleRecipesOrRecipe(int quantity, String langCode) {
    if (langCode == 'ar') {
      if (quantity > 1 && quantity < 11) {
        return quantity == 2 ? 'وصفتين' : '$quantity وصفات';
      } else {
        return 'وصفة';
      }
    } else if (langCode == 'en') {
      return quantity == 1 ? '$quantity recipe' : '$quantity recipes';
    } else {
      return '';
    }
  }
}
