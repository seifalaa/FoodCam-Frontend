import 'package:foodcam_frontend/models/recipe.dart';

class Collection {
  final int id;
  final String collectionName;
  final List<Recipe> recipes;
  final String collectionImageUrl;
  final int userId;

  const Collection(
      {required this.id,
      required this.userId,
      required this.collectionImageUrl,
      required this.collectionName,
      required this.recipes});

  factory Collection.fromMap(Map<String, dynamic> map) {
    // String url = map['collection_image']
    //     .replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    // url =
    //     'https://drive.google.com/uc?id=${url.substring(0, url.indexOf('/'))}';
    final List<Recipe> recipes = [];
    for (final recipe in map['recipes']) {
      recipes.add(Recipe.fromMap(recipe));
    }
    return Collection(
        id: map['id'],
        userId: map['user'],
        collectionName: map['collection_name'],
        recipes: recipes,
        collectionImageUrl:map['collection_image']);
  }

  // static Map<String, dynamic> toMap(Collection collection) {
  //   return {
  //     'collectionName': collection.collectionName,
  //     'recipes': collection.recipes,
  //     'collectionImageUrl': collection.collectionImageUrl
  //   };
  // }
}
