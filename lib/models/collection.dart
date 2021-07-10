import 'package:foodcam_frontend/models/recipe.dart';

class Collection {
  final String collectionName;
  final List<Recipe> recipes;
  final String collectionImageUrl;

  const Collection(
      {required this.collectionImageUrl,
      required this.collectionName,
      required this.recipes});

  static Collection fromMap(Map<String, dynamic> map) {
    return Collection(
        collectionName: map['collectionName'],
        recipes: map['recipes'],
        collectionImageUrl: map['collectionImageUrl']);
  }

  static Map<String, dynamic> toMap(Collection collection) {
    return {
      'collectionName': collection.collectionName,
      'recipes': collection.recipes,
      'collectionImageUrl': collection.collectionImageUrl
    };
  }
}
