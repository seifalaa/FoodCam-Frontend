import 'package:flutter/material.dart';

class RecipeBox extends StatelessWidget {
  const RecipeBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'lib/assets/gettyimages-154963660-612x612.jpg',
              width: 400,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0x30000000),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              children: [
                Text(
                  'Shawerma',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 20,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 20,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 20,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 20,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFC4C4C4),
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
