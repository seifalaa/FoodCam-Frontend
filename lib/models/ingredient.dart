class Ingredient {
  Ingredient({
    required this.id,
    required this.ingredientAmount,
    required this.unit,
    required this.ingredientName,
    required this.ingredientImageUrl,
  });
  final int id;
  final double ingredientAmount;
  final String unit;
  final String ingredientName;
  final String ingredientImageUrl;

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      ingredientName: map['name'],
      ingredientImageUrl: map['image'],
      id: map['id'],
      ingredientAmount: map['ingredient_amount'],
      unit: map['unit'],
    );
  }
  factory Ingredient.fromMapBasket(Map<String, dynamic> map) {

      return Ingredient(
      ingredientName: map['ingredient_name'],
      ingredientImageUrl: map['ingredient']['image'],
      id: map['ingredient']['id'],
      ingredientAmount: 0.0,
      unit: "",
    );
  }
  factory Ingredient.fromMapBasketSearch(Map<String, dynamic> map) {

    return Ingredient(
      ingredientName: map['ingredient_name'],
      ingredientImageUrl: map['ingredient']['image'],
      id: map['ingredient']['id'],
      ingredientAmount: 0.0,
      unit: "",
    );
  }

  // static Map<String, dynamic> toMap(Ingredient ingredient) {
  //   return {
  //     'ingredientName': ingredient.ingredientName,
  //     'ingredientImageUrl': ingredient.ingredientImageUrl,
  //   };
  // }
}
