import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class RecipeBox extends StatelessWidget {
  const RecipeBox({Key? key}) : super(key: key);

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
                'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.jpg',
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
                    'Meat Balls',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= KMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 4; i++)
                        Icon(
                          Icons.star_rounded,
                          size: _screenWidth <= KMobileScreenSize
                              ? _screenWidth * 0.045
                              : _screenWidth * 0.0225,
                          color: Color(0xFFFFC107),
                        ),
                      Icon(
                        Icons.star_rounded,
                        size: _screenWidth <= KMobileScreenSize
                            ? _screenWidth * 0.045
                            : _screenWidth * 0.0225,
                        color: Colors.white54,
                      )
                    ],
                  )
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
              onTap: () {},
            ),
          )),
        ],
      ),
    );
  }
}
