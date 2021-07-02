import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RecipeController {
  Future<List<Recipe>> getRecipes(String langCode) async {
    await Firebase.initializeApp();
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'en'
        ? await fireStore.collection('Recipes').get()
        : await fireStore.collection('Recipes-ar').get();
    List<Recipe> recipes = [];
    snapshot.docs.forEach((element) {
      List<Ingredient> ingredients = [];
      List docRefs = element.data()['ingredients'];
      docRefs.forEach((ref) async {
        DocumentSnapshot<Map<String,dynamic>> snapshot = await ref.get();
        Map<String, dynamic>? data = snapshot.data();
        ingredients.add(Ingredient(
            ingredientName: data!['ingredientName'],
            ingredientImageUrl: snapshot.data()!['ingredientImageUrl']));
      });
      Map<String, dynamic> recipe = {
        'recipeName': element.data()['recipeName'],
        'recipeRate': element.data()['recipeRate'],
        'recipeImageUrl': element.data()['recipeImageUrl'],
        'steps': element.data()['steps'],
        'ingredients': ingredients
      };
      recipes.add(Recipe.fromMap(recipe));
    });
    return recipes;
  }
}
