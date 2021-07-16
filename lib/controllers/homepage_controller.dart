import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodcam_frontend/models/allergy.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';

class HomePageController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<List<Recipe>> getTopRated(String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('Recipes-ar').get()
        : await fireStore.collection('Recipes').get();
    final List<Recipe> recipes = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
      final List<Ingredient> ingredients =
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
    final QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('Categories-ar').get()
        : await fireStore.collection('Categories').get();
    final List<Category> categories = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
      final List<dynamic> recipeRefs = doc.data()['recipes'];
      final List<Recipe> recipes = await getRecipes(recipeRefs);
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
    final List<Recipe> recipes = [];
    for (final DocumentReference reference in references) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStore.doc(reference.path).get();
      final Map<String, dynamic> recipeData = snapshot.data()!;
      final List<Ingredient> ingredients =
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
    final List<Ingredient> ingredients = [];
    for (final DocumentReference reference in references) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStore.doc(reference.path).get();
      ingredients.add(Ingredient.fromMap(snapshot.data()!));
    }
    return ingredients;
  }

  Future<List<Recipe>> getRecentlySearched(String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('RecentlySearched-ar').get()
        : await fireStore.collection('RecentlySearched').get();
    final List<Recipe> recipes = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
      final DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
          await fireStore.doc(doc.data()['recipe'].path).get();
      final Map<String, dynamic> recipeDate = recipeSnapshot.data()!;
      final List<Ingredient> ingredients =
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

  Future<void> addCollection(Map<String, dynamic> collectionData) async {
    //langCode == 'ar'
    //    ? await fireStore.collection('Collections-ar').add(collectionData)
    //    : await fireStore.collection('Collections').add(collectionData);
  }

  Future<List<Allergy>> getAllergies(String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
        ? await fireStore.collection('Allergies-ar').get()
        : await fireStore.collection('Allergies').get();
    final List<Allergy> allergies = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
      final Map<String, dynamic> allergyData = doc.data();
      allergies.add(Allergy.fromMap(allergyData));
    }
    return allergies;
  }

  //Future<void> addAllergy(String allergyName,String langCode)async{
  //  final QuerySnapshot<Map<String, dynamic>> snapshot = langCode == 'ar'
  //      ? await fireStore.collection('Allergies-ar').where('allergyName',isEqualTo: allergyName).get()
  //      : await fireStore.collection('Allergies').where('allergyName',isEqualTo: allergyName).get();
  //  final QueryDocumentSnapshot doc = snapshot.docs.first;
  //  langCode == 'ar'? await fireStore.collection('UserAllergies-')
  //}
  Future<Recipe> recipeFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final Map<String, dynamic> recipeData = snapshot.data();
    final List<dynamic> ingredientsReference = recipeData['ingredients'];
    final List<Ingredient> ingredients = [];
    for (final reference in ingredientsReference) {
      final DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
          await fireStore.doc(reference.path).get();
      final Map<String, dynamic>? ingredient = ingredientDoc.data();
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
    final Map<String, dynamic>? recipeData = snapshot.data();
    final List<dynamic> ingredientsReference = recipeData!['ingredients'];
    final List<Ingredient> ingredients = [];

    for (final reference in ingredientsReference) {
      final DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
          await fireStore.doc(reference.path).get();
      final Map<String, dynamic>? ingredient = ingredientDoc.data();
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
    final Map<String, dynamic> categoryData = snapshot.data();
    final List<dynamic> recipesReference = categoryData['recipes'];
    final List<Recipe> recipes = [];

    for (final reference in recipesReference) {
      final DocumentSnapshot<Map<String, dynamic>> recipeDoc =
          await fireStore.doc(reference.path).get();
      final Recipe recipe = await recipeFromDocumentSnapshot(recipeDoc);
      recipes.add(recipe);
    }
    return Category(
      categoryName: categoryData['categoryName'],
      categoryImageUrl: categoryData['categoryImageUrl'],
      recipes: recipes,
    );
  }

  Future<List<Recipe>> recipeSearch(String query, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore.collection('Recipes-ar').get()
        : await fireStore.collection('Recipes').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> recipesDocs =
        querySnapshot.docs;
    final List<Recipe> recipes = [];
    for (final doc in recipesDocs) {
      final Recipe recipe = await recipeFromQueryDocumentSnapshot(doc);
      recipes.add(recipe);
    }
    final List<Recipe> searchResults = recipes
        .where((element) => element.recipeName.startsWith(query))
        .toList();
    return searchResults;
  }

  Future<List<Ingredient>> ingredientSearch(
      String query, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore.collection('Ingredients-ar').get()
        : await fireStore.collection('Ingredients').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> ingredientsDocs =
        querySnapshot.docs;
    final List<Ingredient> ingredients = [];
    for (final doc in ingredientsDocs) {
      final Map<String, dynamic> ingredient = doc.data();
      ingredients.add(Ingredient.fromMap(ingredient));
    }
    return ingredients
        .where((element) => element.ingredientName.startsWith(query))
        .toList();
  }

  Future<void> addIngredientInBasket(
      Ingredient ingredient, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore
            .collection('Ingredients-ar')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get()
        : await fireStore
            .collection('Ingredients')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get();
    final DocumentReference<Map<String, dynamic>> ingredientReference =
        querySnapshot.docs.first.reference;
    await ingredientReference.update({'addedToBasket': false});
    langCode == 'ar'
        ? await fireStore
            .collection('Basket-ar')
            .add({'ingredient': ingredientReference})
        : await fireStore
            .collection('Basket')
            .add({'ingredient': ingredientReference});
  }

  Future<void> addIngredientInPreferred(
      Ingredient ingredient, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore
            .collection('Ingredients-ar')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get()
        : await fireStore
            .collection('Ingredients')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get();
    final DocumentReference<Map<String, dynamic>> ingredientReference =
        querySnapshot.docs.first.reference;
    await ingredientReference.update({
      'addedToBasket': false
    }); // i made it false beacause it conflict with basket
    langCode == 'ar'
        ? await fireStore
            .collection('PreferredIngredients-ar')
            .add({'ingredient': ingredientReference})
        : await fireStore
            .collection('PreferredIngredients')
            .add({'ingredient': ingredientReference});
  }

  Future<void> addIngredientInDisPreferred(
      Ingredient ingredient, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = langCode == 'ar'
        ? await fireStore
            .collection('Ingredients-ar')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get()
        : await fireStore
            .collection('Ingredients')
            .where('ingredientName', isEqualTo: ingredient.ingredientName)
            .get();
    final DocumentReference<Map<String, dynamic>> ingredientReference =
        querySnapshot.docs.first.reference;
    await ingredientReference.update({
      'addedToBasket': false
    }); // i made it false beacause it conflict with basket
    langCode == 'ar'
        ? await fireStore
            .collection('DisPreferredIngredients-ar')
            .add({'ingredient': ingredientReference})
        : await fireStore
            .collection('DisPreferredIngredients')
            .add({'ingredient': ingredientReference});
  }

  Future<Ingredient> ingredientFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final Map<String, dynamic> basketData = snapshot.data();
    final DocumentReference ingredientReference = basketData['ingredient'];
    final DocumentSnapshot<Map<String, dynamic>> ingredientDoc =
        await fireStore.doc(ingredientReference.path).get();
    final Map<String, dynamic>? ingredientData = ingredientDoc.data();
    return Ingredient.fromMap(ingredientData!);
  }

  Future<List<Recipe>> recipeSearchWithMultipleIngredients(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> basketIngredients,
      String langCode) async {
    final List<QuerySnapshot<Map<String, dynamic>>> results = [];
    for (final basketIngredient in basketIngredients) {
      final Map<String, dynamic> basketIngredientData = basketIngredient.data();
      final DocumentReference ingredientReference =
          basketIngredientData['ingredient'];
      final QuerySnapshot<Map<String, dynamic>> result = langCode == 'ar'
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
    final List<Recipe> recipes = [];
    for (final result in results) {
      for (final doc in result.docs) {
        final Recipe recipe = await recipeFromQueryDocumentSnapshot(doc);
        recipes.add(recipe);
      }
    }
    return recipes;
  }

  Future<void> deleteIngredientFromBasket(
      String ingredientName, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> ingredientDocument =
        langCode == 'ar'
            ? await fireStore
                .collection('Ingredients-ar')
                .where('ingredientName', isEqualTo: ingredientName)
                .get()
            : await fireStore
                .collection('Ingredients')
                .where('ingredientName', isEqualTo: ingredientName)
                .get();

    final DocumentReference ingredientReference =
        ingredientDocument.docs.first.reference;

    final QuerySnapshot<Map<String, dynamic>> ingredientInBasketDocument =
        langCode == 'ar'
            ? await fireStore
                .collection('Basket-ar')
                .where('ingredient', isEqualTo: ingredientReference)
                .get()
            : await fireStore
                .collection('Basket')
                .where('ingredient', isEqualTo: ingredientReference)
                .get();

    final String ingredientInBasketPath =
        ingredientInBasketDocument.docs.first.reference.path;
    langCode == 'ar'
        ? await fireStore.doc(ingredientInBasketPath).delete()
        : await fireStore.doc(ingredientInBasketPath).delete();
  }

  Future<Category> collectionFromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final Map<String, dynamic> collectionDate = snapshot.data();
    //print(collectionDate);
    final recipesReferences = collectionDate['recipes'];
    final List<Recipe> recipes = [];
    for (final DocumentReference reference in recipesReferences) {
      final DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
          await fireStore.doc(reference.path).get();
      final Recipe recipe = await recipeFromDocumentSnapshot(recipeSnapshot);
      recipes.add(recipe);
    }
    final Map<String, dynamic> collectionMap = {
      'categoryName': collectionDate['collectionName'],
      'categoryImageUrl': collectionDate['collectionImageUrl'],
      'recipes': recipes,
    };
    return Category.fromMap(collectionMap);
  }

  Future<void> deleteCollection(String collectionName, String langCode) async {
    final QuerySnapshot<Map<String, dynamic>> collectionDocument =
        langCode == 'ar'
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
