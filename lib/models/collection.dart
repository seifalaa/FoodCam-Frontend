import 'package:foodcam_frontend/models/recipe.dart';

class Collection {
  final int id;
  final String collectionName;
  final int recipeCount;
  final String collectionImageUrl;
  final int userId;

  const Collection(
      {required this.id,
      required this.userId,
      required this.collectionImageUrl,
      required this.collectionName,
      required this.recipeCount});

  factory Collection.fromMap(Map<String, dynamic> map) {
    // String url = map['collection_image']
    //     .replaceAll(RegExp("https://drive.google.com/file/d/"), "");
    // url =
    //     'https://drive.google.com/uc?id=${url.substring(0, url.indexOf('/'))}';
    final List<Recipe> recipes = [];

    return Collection(
        id: map['id'],
        userId: map['user'],
        collectionName: map['collection_name'],
        recipeCount: map['recipes'],
        collectionImageUrl: url);
  }

  // static Map<String, dynamic> toMap(Collection collection) {
  //   return {
  //     'collectionName': collection.collectionName,
  //     'recipes': collection.recipes,
  //     'collectionImageUrl': collection.collectionImageUrl
  //   };
  // }
}
