import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "6 Items",
                  style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
