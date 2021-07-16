import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/pages/collections_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CollectionBox extends StatefulWidget {
  const CollectionBox({
    Key? key,
    required this.category,
    required this.onDelete,
  }) : super(key: key);
  final Category category;
  final Function onDelete;

  @override
  _CollectionBoxState createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _langCode = Provider.of<LanguageProvider>(context).langCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.category.categoryImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x50000000),
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
                          widget.category.recipes.length, _langCode),
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
                  _isVisible
                      ? setState(() {
                          _isVisible = false;
                        })
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CollectionPage(),
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
                      widget.category.categoryName, _langCode);
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
