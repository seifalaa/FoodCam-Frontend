import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';

class HomePageController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<Recipe> recipeFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Map<String, dynamic> recipeData = snapshot.data();
    List<dynamic> ingredientsReference = recipeData['ingredients'];
    List<Ingredient> ingredients = [];
    for (var reference in ingredientsReference) {
      DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
          await fireStore.doc(reference.path).get();
      Map<String, dynamic>? ingredient = ingredientDoc.data();
      ingredients.add(Ingredient.fromMap(ingredient!));
    }
    return Recipe(
      recipeName: recipeData['recipeName'],
      recipeRate: recipeData['recipeRate'].toDouble(),
      recipeImageUrl: recipeData['recipeImageUrl'],
      steps: recipeData['steps'].split(','),
      ingredients: ingredients,
    );
  }

  Future<Recipe> recipeFromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Map<String, dynamic>? recipeData = snapshot.data();
    List<dynamic> ingredientsReference = recipeData!['ingredients'];
    List<Ingredient> ingredients = [];

    for (var reference in ingredientsReference) {
      DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
          await fireStore.doc(reference.path).get();
      Map<String, dynamic>? ingredient = ingredientDoc.data();
      ingredients.add(Ingredient.fromMap(ingredient!));
    }
    return Recipe(
      recipeName: recipeData['recipeName'],
      recipeRate: recipeData['recipeRate'].toDouble(),
      recipeImageUrl: recipeData['recipeImageUrl'],
      steps: recipeData['steps'].split(','),
      ingredients: ingredients,
    );
  }

  Future<Category> categoryFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Map<String, dynamic> categoryData = snapshot.data();
    List<dynamic> recipesReference = categoryData['recipes'];
    List<Recipe> recipes = [];

    for (var reference in recipesReference) {
      DocumentSnapshot<Map<String, dynamic>> recipeDoc =
          await fireStore.doc(reference.path).get();
      Recipe recipe = await recipeFromDocumentSnapshot(recipeDoc);
      recipes.add(recipe);
    }
    return Category(
      categoryName: categoryData['categoryName'],
      categoryImageUrl: categoryData['categoryImageUrl'],
      recipes: recipes,
    );
  }

  Future<List<Recipe>> search(query, langCode) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore.collection('Recipes-ar').get()
        : await fireStore.collection('Recipes').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> recipesDocs =
        querySnapshot.docs;
    List<Recipe> recipes = [];
    for (var doc in recipesDocs) {
      Recipe recipe = await recipeFromQueryDocumentSnapshot(doc);
      recipes.add(recipe);
    }
    List<Recipe> searchResults = recipes
        .where((element) => element.recipeName.startsWith(query))
        .toList();
    return searchResults;
  }
}
