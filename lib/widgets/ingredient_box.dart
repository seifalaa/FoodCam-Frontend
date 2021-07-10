import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class IngredientBox extends StatefulWidget {
  const IngredientBox({
    Key? key,
    required this.ingredient,
    required this.onDelete,
    required this.index,
  }) : super(key: key);
  final Ingredient ingredient;
  final index; //TODO:to be removed later
  final Function onDelete;

  @override
  _IngredientBoxState createState() => _IngredientBoxState();
}

class _IngredientBoxState extends State<IngredientBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.ingredient.ingredientImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _isVisible ? Color(0x70000000) : Color(0x40000000),
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
                    widget.ingredient.ingredientName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= KMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
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
                  setState(() {
                    _isVisible = false;
                  });
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
                child: Icon(Icons.clear),
                onPressed: () async {

                  await widget.onDelete(
                      widget.ingredient.ingredientName, langCode);
                  setState(() {
                    _isVisible = false;
                  });
                },
              ),
            )),
          )
        ],
      ),
    );
  }
}
