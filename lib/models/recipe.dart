import 'package:foodcam_frontend/models/nutrition_info.dart';

import 'ingredient.dart';

class Recipe {
  const Recipe({
    required this.recipeId,
    required this.recipeLvId,
    required this.prepareTime,
    required this.numberOfPeopleRated,
    required this.country,
    required this.nutritionInfo,
    required this.ingredients,
    required this.recipeName,
    required this.recipeRate,
    required this.recipeImageUrl,
    required this.steps,
  });

  final int recipeId;
  final int recipeLvId;
  final int prepareTime;
  final int numberOfPeopleRated;
  final NutritionInfo nutritionInfo;
  final String country;
  final String recipeName;
  final double recipeRate;
  final String recipeImageUrl;
  final List<String> steps;
  final List<Ingredient> ingredients;

  factory Recipe.fromMap(Map<String, dynamic> map) {
    final NutritionInfo nutritionInfo =
        NutritionInfo.fromMap(map['recipe']['nutrition_info']);
    final List<Ingredient> ingredients = [];
    for (final Map<String, dynamic> ingredient in map['recipe']
        ['ingredients']) {
      ingredients.add(Ingredient.fromMap(ingredient));
    }
    // String result = map['recipe']['image']
    //     .replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    // result =
    //     'https://drive.google.com/uc?id=${result.substring(0, result.indexOf('/'))}';
    // print("sadad");
    //print(result);
    return Recipe(
      recipeName: map['recipe_name'],
      recipeRate: map['recipe']['rate'],
      recipeImageUrl:map['recipe']['image'],
      steps: map['recipe_description'].split('\$'),
      ingredients: ingredients,
      country: map['country'],
      recipeId: map['recipe']['id'],
      recipeLvId: map['id'],
      numberOfPeopleRated: map['recipe']['number_of_people_rated'],
      nutritionInfo: nutritionInfo,
      prepareTime: map['recipe']['prepare_time'],
    );
  }
}
