import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/pages/collections_recipes_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CollectionBox extends StatefulWidget {
  const CollectionBox({
    Key? key,
    required this.collection,
    required this.onDelete,
  }) : super(key: key);
  final Collection collection;
  final Function onDelete;

  @override
  _CollectionBoxState createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    final BackEndController _backendController = BackEndController();
    String collectionName = "";
    if (_langCode == "ar") {
      if (widget.collection.collectionName == 'Breakfast') {
        collectionName = "فطور";
      } else if (widget.collection.collectionName == 'Dinner') {
        collectionName = "عشاء";
      } else if (widget.collection.collectionName == 'Launch') {
        collectionName = "غداء";
      } else {
        collectionName = widget.collection.collectionName;
      }
    } else {
      collectionName = widget.collection.collectionName;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: //Image.asset('lib/assets/avatar.png' , fit:BoxFit.cover ,),

                  Image.network(
                widget.collection.collectionImageUrl,
                //'https://lh3.googleusercontent.com/pw/AM-JKLV1C6Mi-CZEqv3wlMpRH9upKndR88M4XoM72HCi1S4bdyLnrpDXk9tq0suoPxvEKrOMos7lkVU453EFntvWrtglKXCmBzKqKU-s5qNoPeQdcp8sPzuvuw_XJYnfs_mrne_3rlTcuMGaAgUp7Ej82YcQ=w670-h370-no?authuser=0',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x30000000),
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
                    collectionName,
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
                        widget.collection.recipeCount,
                        _langCode,
                      ),
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
                            builder: (context) => CollectionsRecipes(
                              collection: widget.collection,
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
                      widget.collection.collectionName, _langCode);
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
      } else if (quantity == 0) {
        return 'فارغة';
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
