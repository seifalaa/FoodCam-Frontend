class Ingredient {
  Ingredient({
    required this.ingredientName,
    required this.ingredientImageUrl,
  });

  final ingredientName;
  final ingredientImageUrl;

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      ingredientName: map['ingredientName'],
      ingredientImageUrl: map['ingredientImageUrl'],
    );
  }
}
