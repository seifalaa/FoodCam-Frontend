class Ingredient {
  Ingredient({
    required this.id,
    required this.ingredientAmount,
    required this.unit,
    required this.ingredientName,
    required this.ingredientImageUrl,
    //required this.my_ingredient,
  });
  final int id;
  final double ingredientAmount;
  final String unit;
  final String ingredientName;
  final String ingredientImageUrl;
  //final bool my_ingredient;

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    // String url =
    //     map['image'].replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    // url =
    //     'https://drive.google.com/uc?id=${url.substring(0, url.indexOf('/'))}';
    return Ingredient(
      ingredientName: map['name'],
      ingredientImageUrl: map['image'],
      id: map['id'],
      ingredientAmount: map['ingredient_amount'],
      unit: map['unit'],
     // my_ingredient: false,
    );
  }
  factory Ingredient.fromMapBasket(Map<String, dynamic> map) {

      return Ingredient(
      ingredientName: map['ingredient_name'],
      ingredientImageUrl: map['ingredient']['image'],
      id: map['ingredient']['id'],
      ingredientAmount: 0.0,
      unit: "",
          //my_ingredient: false,
    );
  }
  factory Ingredient.fromMapBasketSearch(Map<String, dynamic> map) {

    return Ingredient(
      ingredientName: map['ingredient_name'],
      ingredientImageUrl: map['ingredient']['image'],
      id: map['ingredient']['id'],
      ingredientAmount: 0.0,
      unit: "",
      //my_ingredient: map['ingredient']['my_ingredient'],
    );
  }

  // static Map<String, dynamic> toMap(Ingredient ingredient) {
  //   return {
  //     'ingredientName': ingredient.ingredientName,
  //     'ingredientImageUrl': ingredient.ingredientImageUrl,
  //   };
  // }
}
