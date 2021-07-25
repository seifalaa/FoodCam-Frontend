import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class IngredientBox extends StatefulWidget {
  const IngredientBox({
    Key? key,
    required this.ingredient,
    required this.onDelete,
    required this.index,
  }) : super(key: key);

  final int index; //TODO:to be removed later
  final Ingredient ingredient;
  final Function onDelete;

  @override
  _IngredientBoxState createState() => _IngredientBoxState();
}

class _IngredientBoxState extends State<IngredientBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String langCode = Provider.of<LanguageProvider>(context).getLangCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.ingredient.ingredientImageUrl,
                //'https://lh3.googleusercontent.com/YyQQ9BJBBfbavol1bRbjTTG4mVHjaj6-XgXAjuRQunhtVKIRc5yXJKITfSsHNWkeLwFm6vTmm7SFjeHUB9nnq1d-myD-m_iJBxffX3Cgvo5WoLyyVWQZeq5Nw8hZ2_zgqUJrzKGh-B0I_etDQxR-Wy_KfnuyYg68fX_vleXKHtdgItrq3uBQcDN1tSaJJRC4_AED0aeNcL_8LTIMKqy0DObqIpJxhKhe8UP0npLm0BVthty9At78oCkhUh8cBN4ZG7N0jA9n4_HOvmhOvHSlZ4Zqorp7g1Y8SQbg7iPjsP1U_97r1wgabdK_wPfWT5LQI_vC_yNt76iJf-wTnjzDQanjND1_8y8ys4rqNJYhMZDnMdB6xRjn24lIST8IsLoJvyD6qwzae5aNuTE19K1pBqFxkZfVW-n0cv199vD4CdR1hRVVr8Be8Otc9wHvEueu2Tu2et8qPewQzMh3c5mh1NCS1-4cpraM2soHUZ80TzbrrWwsj6FuGlYkvnoL9TtPI1CoFd3IsAKOEAWVUGttBgBjp5emyFg1BVKS7T9QemDA0i3pnMaODjemAQzliw5oNluYH5tcEnzTGwTlorWrsMOidpzxgAOdYsa24SJe2Y6cm7VFD470QiXAU0mraTizHffnP8rOLbO9Uo3Gjhe3W_OIgxZOEJt96sQx2jE8paRYLQ3L6DMzONRJ4UKh3i9ljcWNlAkDhtRrLRnV8A1nkVE1=w630-h300-no?authuser=0',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _isVisible
                    ? const Color(0x70000000)
                    : const Color(0x40000000),
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
                      fontSize: _screenWidth <= kMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
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
                onPressed: () async {
                  await widget.onDelete(
                    widget.ingredient.id

                  );
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
