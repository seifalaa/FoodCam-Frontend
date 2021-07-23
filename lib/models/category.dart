import 'package:foodcam_frontend/models/recipe.dart';

class Category {
  final int id;
  final String categoryName;
  final String categoryImageUrl;
  final List<Recipe> recipes;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.recipes,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: int.parse(map['id']),
        categoryName: map['categoryName'],
        categoryImageUrl: map['categoryImageUrl'],
        recipes: map['recipes']);
  }
}
