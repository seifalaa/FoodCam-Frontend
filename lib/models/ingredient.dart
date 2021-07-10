class Ingredient {
  Ingredient({
    required this.ingredientName,
    required this.ingredientImageUrl,
    required this.addedToBasket,
  });

  final String ingredientName;
  final String ingredientImageUrl;
  final bool addedToBasket;

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      ingredientName: map['ingredientName'],
      ingredientImageUrl: map['ingredientImageUrl'],
      addedToBasket: map['addedToBasket'],
    );
  }

  static Map<String, dynamic> toMap(Ingredient ingredient) {
    return {
      'ingredientName': ingredient.ingredientName,
      'ingredientImageUrl': ingredient.ingredientImageUrl,
      'addedToBasket': ingredient.addedToBasket,
    };
  }
}
