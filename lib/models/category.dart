import 'package:foodcam_frontend/models/recipe.dart';

class Category {
  final String categoryName;
  final String categoryImageUrl;
  final List<Recipe> recipes;

  Category({
    required this.categoryName,
    required this.categoryImageUrl,
    required this.recipes,
  });

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        categoryName: map['categoryName'],
        categoryImageUrl: map['categoryImageUrl'],
        recipes: map['recipes']);
  }
}
