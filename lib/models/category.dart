
class Category {
  final String categoryName;
  final String categoryImageUrl;
  final int recipeCount;
  final int categoryId;
  //final List<Recipe> recipes;

  Category({
    required this.categoryName,
    required this.categoryImageUrl,
    required this.recipeCount,
    required this.categoryId,
    //required this.recipes,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    // String url = map['categoryImage']
    //     .replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    // url =
    // 'https://drive.google.com/uc?id=${url.substring(0, url.indexOf('/'))}';

    // final List<Recipe> recipes = [];
    // for (final recipe in map['recipes']) {
    //   recipes.add(Recipe.fromMap(recipe));
    // }
    return Category(
      categoryName: map['categoryName'],
      categoryImageUrl: map['categoryImage'],
      recipeCount: map['recipes'],
      categoryId:map['id'],
      //recipes: recipes,
    );
  }
}
