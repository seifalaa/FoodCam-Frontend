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
    String url =
        map['image'].replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    url =
        'https://drive.google.com/uc?id=${url.substring(0, url.indexOf('/'))}';
    return Ingredient(
      ingredientName: map['name'],
      ingredientImageUrl: url,
      id: map['id'],
      ingredientAmount: map['ingredient_amount'],
      unit: map['unit'],
    );
  }

  // static Map<String, dynamic> toMap(Ingredient ingredient) {
  //   return {
  //     'ingredientName': ingredient.ingredientName,
  //     'ingredientImageUrl': ingredient.ingredientImageUrl,
  //   };
  // }
}
