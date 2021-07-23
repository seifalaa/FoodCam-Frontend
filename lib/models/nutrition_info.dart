class NutritionInfo {
  final int id;
  final double calories;
  final double protein;
  final double carbs;
  final double sugar;
  final double fats;
  final double recipeAmount;

  NutritionInfo({
    required this.id,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.sugar,
    required this.fats,
    required this.recipeAmount,
  });
  factory NutritionInfo.fromMap(final Map<String, dynamic> map) =>
      NutritionInfo(
        calories: map['calories'],
        carbs: map['carbs'],
        fats: map['fats'],
        id:map['id'],
        protein: map['protein'],
        recipeAmount: map['recipe_amount'],
        sugar: map['sugar'],
      );
}
