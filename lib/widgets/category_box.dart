import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    Key? key,
    required this.imagePath,
    required this.category,
  }) : super(key: key);
  final imagePath;
  final category;
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
                  Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "6 Recipes",
                    style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.bold,
                        fontSize:_screenWidth <= KMobileScreenSize
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

               
              },
            ),
          )),
        ],
      ),
    );
  }
}





