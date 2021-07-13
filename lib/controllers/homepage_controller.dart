import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';

class HomePageController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<List<Recipe>> getTopRated(String langCode) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('Recipes-ar').get()
        : await fireStore.collection('Recipes').get();
    List<Recipe> recipes = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      List<Ingredient> ingredients =
          await getIngredients(doc.data()['ingredients']);
      recipes.add(
        Recipe(
          ingredients: ingredients,
          recipeImageUrl: doc.data()['recipeImageUrl'],
          recipeName: doc.data()['recipeName'],
          recipeRate: doc.data()['recipeRate'].toDouble(),
          steps: doc.data()['steps'].split(','),
        ),
      );
    }
    return recipes;
  }

  Future<List<Category>> getCategories(String langCode) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('Categories-ar').get()
        : await fireStore.collection('Categories').get();
    List<Category> categories = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      List<dynamic> recipeRefs = doc.data()['recipes'];
      List<Recipe> recipes = await getRecipes(recipeRefs);
      categories.add(
        Category.fromMap(
          {
            'categoryName': doc.data()['categoryName'],
            'categoryImageUrl': doc.data()['categoryImageUrl'],
            'recipes': recipes,
          },
        ),
      );
    }
    return categories;
  }

  Future<List<Recipe>> getRecipes(List<dynamic> references) async {
    List<Recipe> recipes = [];
    for (DocumentReference reference in references) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStore.doc(reference.path).get();
      Map<String, dynamic> recipeData = snapshot.data()!;
      List<Ingredient> ingredients =
          await getIngredients(recipeData['ingredients']);

      recipes.add(Recipe(
          ingredients: ingredients,
          recipeImageUrl: recipeData['recipeImageUrl'],
          recipeName: recipeData['recipeName'],
          recipeRate: recipeData['recipeRate'].toDouble(),
          steps: recipeData['steps'].split(',')));
    }
    return recipes;
  }

  Future<List<Ingredient>> getIngredients(List<dynamic> references) async {
    List<Ingredient> ingredients = [];
    for (DocumentReference reference in references) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStore.doc(reference.path).get();
      ingredients.add(Ingredient.fromMap(snapshot.data()!));
    }
    return ingredients;
  }

  Future<List<Recipe>> getRecentlySearched(String langCode) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('RecentlySearched-ar').get()
        : await fireStore.collection('RecentlySearched').get();
    List<Recipe> recipes = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
          await fireStore.doc(doc.data()['recipe'].path).get();
      Map<String, dynamic> recipeDate = recipeSnapshot.data()!;
      List<Ingredient> ingredients =
          await getIngredients(recipeDate['ingredients']);
      recipes.add(
        Recipe(
          ingredients: ingredients,
          recipeImageUrl: recipeDate['recipeImageUrl'],
          recipeName: recipeDate['recipeName'],
          recipeRate: recipeDate['recipeRate'].toDouble(),
          steps: recipeDate['steps'].split(','),
        ),
      );
    }
    return recipes;
  }

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

  Future<List<Recipe>> recipeSearch(query, langCode) async {
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

  Future<List<Ingredient>> ingredientSearch(query, langCode) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore.collection('Ingredients-ar').get()
        : await fireStore.collection('Ingredients').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> ingredientsDocs =
        querySnapshot.docs;
    List<Ingredient> ingredients = [];
    for (var doc in ingredientsDocs) {
      Map<String, dynamic> ingredient = doc.data();
      ingredients.add(Ingredient.fromMap(ingredient));
    }
    return ingredients
        .where((element) => element.ingredientName.startsWith(query))
        .toList();
  }

  Future<void> addIngredientInBasket(Ingredient ingredient, langCode) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore
            .collection('Ingredients-ar')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get()
        : await fireStore
            .collection('Ingredients')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get();
    DocumentReference<Map<String, dynamic>> ingredientReference =
        querySnapshot.docs.first.reference;
    await ingredientReference.update({'addedToBasket': true});
    langCode == 'ar'
        ? await fireStore
            .collection('Basket-ar')
            .add({'ingredient': ingredientReference})
        : await fireStore
            .collection('Basket')
            .add({'ingredient': ingredientReference});
  }

  Future<Ingredient> ingredientFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Map<String, dynamic> basketData = snapshot.data();
    DocumentReference ingredientReference = basketData['ingredient'];
    DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
        await fireStore.doc(ingredientReference.path).get();
    Map<String, dynamic>? ingredientData = ingredientDoc.data();
    return Ingredient.fromMap(ingredientData!);
  }

  Future<List<Recipe>> recipeSearchWithMultipleIngredients(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> basketIngredients,
      langCode) async {
    List<QuerySnapshot<Map<String, dynamic>>> results = [];
    for (var basketIngredient in basketIngredients) {
      Map<String, dynamic> basketIngredientData = basketIngredient.data();
      DocumentReference ingredientReference =
          basketIngredientData['ingredient'];
      QuerySnapshot<Map<String, dynamic>> result = langCode == 'ar'
          ? await fireStore
              .collection('Recipes-ar')
              .where('ingredients', arrayContains: ingredientReference)
              .get()
          : await fireStore
              .collection('Recipes')
              .where('ingredients', arrayContains: ingredientReference)
              .get();
      results.add(result);
    }
    List<Recipe> recipes = [];
    for (var result in results) {
      for (var doc in result.docs) {
        Recipe recipe = await recipeFromQueryDocumentSnapshot(doc);
        recipes.add(recipe);
      }
    }
    return recipes;
  }

  Future<void> deleteIngredientFromBasket(
      String ingredientName, String langCode) async {
    QuerySnapshot<Map<String, dynamic>> ingredientDocument = langCode == 'ar'
        ? await fireStore
            .collection('Ingredients-ar')
            .where('ingredientName', isEqualTo: ingredientName)
            .get()
        : await fireStore
            .collection('Ingredients')
            .where('ingredientName', isEqualTo: ingredientName)
            .get();

    DocumentReference ingredientReference =
        ingredientDocument.docs.first.reference;

    QuerySnapshot<Map<String, dynamic>> ingredientInBasketDocument =
        langCode == 'ar'
            ? await fireStore
                .collection('Basket-ar')
                .where('ingredient', isEqualTo: ingredientReference)
                .get()
            : await fireStore
                .collection('Basket')
                .where('ingredient', isEqualTo: ingredientReference)
                .get();

    String ingredientInBasketPath =
        ingredientInBasketDocument.docs.first.reference.path;
    print(ingredientInBasketPath);
    langCode == 'ar'
        ? await fireStore.doc(ingredientInBasketPath).delete()
        : await fireStore.doc(ingredientInBasketPath).delete();
  }

  Future<Category> collectionFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Map<String, dynamic> collectionDate = snapshot.data();
    //print(collectionDate);
    var recipesReferences = collectionDate['recipes'];
    List<Recipe> recipes = [];
    for (DocumentReference reference in recipesReferences) {
      DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
          await fireStore.doc(reference.path).get();
      Recipe recipe = await recipeFromDocumentSnapshot(recipeSnapshot);
      recipes.add(recipe);
    }
    Map<String, dynamic> collectionMap = {
      'categoryName': collectionDate['collectionName'],
      'categoryImageUrl': collectionDate['collectionImageUrl'],
      'recipes': recipes,
    };
    return Category.fromMap(collectionMap);
  }

  Future<void> deleteCollection(String collectionName, String langCode) async {
    QuerySnapshot<Map<String, dynamic>> collectionDocument = langCode == 'ar'
        ? await fireStore
            .collection('Collections-ar')
            .where('collectionName', isEqualTo: collectionName)
            .get()
        : await fireStore
            .collection('Collections')
            .where('collectionName', isEqualTo: collectionName)
            .get();
    await fireStore.doc(collectionDocument.docs.first.reference.path).delete();
  }
}
