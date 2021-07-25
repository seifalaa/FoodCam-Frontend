import 'package:foodcam_frontend/models/nutrition_info.dart';

class Recipe {
  const Recipe({
    required this.recipeId,
    required this.recipeLvId,
    required this.prepareTime,
    required this.numberOfPeopleRated,
    required this.country,
    required this.nutritionInfo,
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

  factory Recipe.fromMap(Map<String, dynamic> map) {
    final NutritionInfo nutritionInfo =
        NutritionInfo.fromMap(map['recipe']['nutrition_info']);

    return Recipe(
      recipeName: map['recipe_name'],
      recipeRate: map['recipe']['rate'],
      recipeImageUrl: map['recipe']['image'],
      steps: map['recipe_description'].split('\$'),
      country: map['country'],
      recipeId: map['recipe']['id'],
      recipeLvId: map['id'],
      numberOfPeopleRated: map['recipe']['number_of_people_rated'],
      nutritionInfo: nutritionInfo,
      prepareTime: map['recipe']['prepare_time'],
    );
  }
}
