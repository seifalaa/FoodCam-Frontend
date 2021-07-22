import 'ingredient.dart';

class Recipe {
  const Recipe({
    required this.ingredients,
    required this.recipeName,
    required this.recipeRate,
    required this.recipeImageUrl,
    required this.steps,
  });

  final String recipeName;
  final double recipeRate;
  final String recipeImageUrl;
  final List<String> steps;
  final List<Ingredient> ingredients;

  static Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeName: map['recipeName'],
      recipeRate: map['recipeRate'],
      recipeImageUrl: map['recipeImageUrl'],
      steps: map['steps'].split(','),
      ingredients: map['ingredients'],
    );
  }
}
