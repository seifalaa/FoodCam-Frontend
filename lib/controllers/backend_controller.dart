import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/models/allergy.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BackEndController {
  Future<String> refreshToken(String refreshToken) async {
    final url =
        Uri.parse("http://192.168.1.5:8000/dj-rest-auth/token/refresh/");
    final http.Response response = await http.post(
      url,
      body: convert.jsonEncode(
        {'refresh': refreshToken},
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final responseJson = jsonDecode(
      utf8.decode(response.bodyBytes),
    );
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    flutterSecureStorage.write(
      key: 'access_token',
      value: responseJson['access'],
    );
    return responseJson['access'];
  }

  Future<List<Recipe>> searchRecipeByName(String query) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/SearchRecipeByName?user_input=$query");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    final List<Recipe> recipes = [];
    for (final item in _responseJson) {
      recipes.add(Recipe.fromMap(item));
    }
    return recipes;
  }

  Future<List<String>> getCategoriesNames(String langCode) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/GetCategoriesName/?lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    final List<String> names = [];
    for (final item in _responseJson) {
      names.add(item['category_name']);
    }
    return names;
  }

  Future<Recipe> getRandomRecipe(String langCode, String categoryName) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');

    final url = Uri.parse(
        "http://192.168.1.5:8000/GeneratorButton/?lang_code=$langCode&category=$categoryName");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    var _responseJson;
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
    } else {
      _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    }

    final Recipe recipe = Recipe.fromMap(_responseJson[0]);

    return recipe;
  }

  Future<List<Ingredient>> getRecipeIngredients(
      int recipeId, String langCode) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/GetIngredientsInRecipe?recipe=$recipeId&lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Ingredient> ingredients = [];
    for (final item in _responseJson) {
      ingredients.add(Ingredient.fromMap(item));
    }
    return ingredients;
  }

  Future<List<Recipe>> getCategoryRecipes(
      int categoryId, String langCode) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/GetRecipesInCategory?category=$categoryId&lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Recipe> recipes = [];
    for (final item in _responseJson) {
      recipes.add(Recipe.fromMap(item));
    }
    return recipes;
  }

  Future<List<Collection>> getUserCollections(String langCode) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken =
          await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken =
          await flutterSecureStorage.read(key: 'refresh_token');
      final url = Uri.parse(
          "http://192.168.1.5:8000/CollectionView/?username=$userName&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
      final List<Collection> collections = [];

      for (final item in _responseJson) {
        collections.add(Collection.fromMap(item));
      }

      return collections;
    } else {
      return [];
    }
  }

  Future<List<Recipe>> getCollectionRecipes(
      int collectionId, String langCode) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken =
          await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken =
          await flutterSecureStorage.read(key: 'refresh_token');
      final url = Uri.parse(
          "http://192.168.1.5:8000/CollectionRecipeView/?collection_id=$collectionId&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;

      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
      final List<Recipe> recipes = [];
      for (final item in _responseJson) {
        recipes.add(Recipe.fromMap(item));
      }
      return recipes;
    } else {
      return [];
    }
  }

  Future<List<Recipe>> getRecentlySearched(String langCode) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken =
          await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken =
          await flutterSecureStorage.read(key: 'refresh_token');
      final url = Uri.parse(
          "http://192.168.1.5:8000/RecentRecipes/?username=$userName&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;

      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
      final List<Recipe> recipes = [];
      for (final item in _responseJson) {
        recipes.add(Recipe.fromMap(item));
      }
      return recipes;
    } else {
      return [];
    }
  }

  Future<void> addRecentlySearched(int recipeId) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final url = Uri.parse('http://192.168.1.5:8000/RecentRecipes/');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: convert.jsonEncode(
        <String, dynamic>{
          'recipe': recipeId,
          'username': userName,
        },
      ),
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
        body: convert.jsonEncode(
          <String, dynamic>{
            'recipe': recipeId,
            'username': userName,
          },
        ),
      );
    }
  }

  Future<List<Category>> getAllCategories(String langCode) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/ListRecipeCategories/?lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Category> categories = [];
    for (final item in _responseJson) {
      categories.add(Category.fromMap(item));
    }
    return categories;
  }

  Future<List<Recipe>> searchByMultipleIngredients(
      String langCode, List<String> ingredientName) async {
    final url = Uri.parse("http://192.168.1.5:8000/SearchRecipeByIngredients/");
    final http.Response response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'lang_code': langCode,
        'ingredients_name': ingredientName,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Recipe> recipes = [];
    for (final item in _responseJson) {
      recipes.add(Recipe.fromMap(item));
    }
    return recipes;
  }

  Future<List<Recipe>> getTopRated(String langCode) async {
    final url = Uri.parse(
        "http://192.168.1.5:8000/GetTopRatedRecipes/?lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Recipe> recipes = [];
    for (final item in _responseJson) {
      recipes.add(Recipe.fromMap(item));
    }
    return recipes;
  }

  Future<List<Ingredient>> getBasketIngredients(String langCode) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/UserIngredientView/?username=$userName&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }

      final List<Ingredient> ingredients = [];

      for (final item in _responseJson) {
        ingredients.add(Ingredient.fromMapBasket(item));
      }
      return ingredients;
    } else {
      return [];
    }
  }

  Future<List<Ingredient>> getPreferedIngredients(String langCode) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/UserPreferenceIngredientView/?username=$userName&is_preferred=1&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
      } else {
        _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      }
      final List<Ingredient> ingredients = [];

      for (final item in _responseJson) {
        ingredients.add(Ingredient.fromMapBasket(item));
      }
      return ingredients;
    } else {
      return [];
    }
  }

  Future<List<Ingredient>> getDisPreferedIngredients(String langCode) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/UserPreferenceIngredientView/?username=$userName&is_preferred=0&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
      } else {
        _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      }
      final List<Ingredient> ingredients = [];

      for (final item in _responseJson) {
        ingredients.add(Ingredient.fromMapBasket(item));
      }

      return ingredients;
    } else {
      return [];
    }
  }

  Future<void> addPreferredIngredient(int ingredientId) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken =
          await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken =
          await flutterSecureStorage.read(key: 'refresh_token');
      final url =
          Uri.parse("http://192.168.1.5:8000/UserPreferenceIngredientView/");
      final http.Response response = await http.post(
        url,
        body: convert.jsonEncode(<String, dynamic>{
          "username": userName,
          "ingredient": ingredientId,
          "is_preferred": 1,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;

      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
    }
  }

  Future<void> addDisPreferredIngredient(int ingredientId) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken =
          await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken =
          await flutterSecureStorage.read(key: 'refresh_token');
      final url =
          Uri.parse("http://192.168.1.5:8000/UserPreferenceIngredientView/");
      final http.Response response = await http.post(
        url,
        body: convert.jsonEncode(<String, dynamic>{
          "username": userName,
          "ingredient": ingredientId,
          "is_preferred": 0,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;

      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
    }
  }

  Future<void> deleteIngredientFromBasket(int ingredientID) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/UserIngredientView/?username=$userName&ingredient=$ingredientID");
      final http.Response response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
      }
    }
  }

  Future<http.Response> addIngredientInBasket(int ingredientId) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = sharedPreferences.getString('userName');

    final url = Uri.parse("http://192.168.1.5:8000/UserIngredientView/");
    final http.Response response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'username': userName,
        'ingredient': ingredientId,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.post(
        url,
        body: convert.jsonEncode(<String, dynamic>{
          'username': userName,
          'ingredient': ingredientId,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      return newResponse;
    } else {
      return response;
    }
  }

  Future<List<Map<String, dynamic>>> ingredientBasketSearch(
      String query) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/searchIngredient/?user_input=$query&username=$userName");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
      } else {
        _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      }
      final List<Map<String, dynamic>> ingredients = [];

      for (final Map<String, dynamic> item in _responseJson) {
        final Ingredient ingredient = Ingredient.fromMapBasket(item);
        final bool isAdded = item['ingredient']['my_ingredient'];
        ingredients.add({
          'ingredient': ingredient,
          'isAdded': isAdded,
        });
      }
      return ingredients;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> ingredientpreferredSearch(
      String query) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/SearchIngredientInPreference/?user_input=$query&username=$userName&is_pref=1");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
      } else {
        _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      }
      final List<Map<String, dynamic>> ingredients = [];

      for (final Map<String, dynamic> item in _responseJson) {
        final Ingredient ingredient = Ingredient.fromMapBasket(item);
        final bool isAdded = item['ingredient']['isExist_inPref'];
        ingredients.add({
          'ingredient': ingredient,
          'isAdded': isAdded,
        });
      }
      return ingredients;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> ingredientDispreferredSearch(
      String query) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/SearchIngredientInPreference/?user_input=$query&username=$userName&is_pref=0");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var _responseJson;
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        _responseJson = jsonDecode(utf8.decode(newResponse.bodyBytes));
      } else {
        _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      }
      final List<Map<String, dynamic>> ingredients = [];

      for (final Map<String, dynamic> item in _responseJson) {
        final Ingredient ingredient = Ingredient.fromMapBasket(item);
        final bool isAdded = item['ingredient']['isExist_inPref'];
        ingredients.add({
          'ingredient': ingredient,
          'isAdded': isAdded,
        });
      }
      return ingredients;
    } else {
      return [];
    }
  }

  Future<http.Response> addCollection(
      String collectionName, String image) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String? userName = sharedPreferences.getString('userName');
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final url = Uri.parse("http://192.168.1.5:8000/CollectionView/");
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'collection_name': collectionName,
        'username': userName,
        'image': image,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.post(
        url,
        body: convert.jsonEncode(<String, dynamic>{
          'collection_name': collectionName,
          'username': userName,
          'image': image,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      return newResponse;
    } else {
      return response;
    }
  }

  Future<void> deleteCollection(String collectionName) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/CollectionView/?username=$userName&collection_name=$collectionName");
      final http.Response response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.body.contains('Given token not valid')) {
        final String newAccessToken = await this.refreshToken(refreshToken!);
        await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> getRecipesIntoCollection(
      String query, String collectionName) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String userName = sharedPreferences.getString('userName')!;
    final url = Uri.parse(
        'http://192.168.1.5:8000/SearchRecipeByNameInCollection?user_input=$query&username=$userName&collection_name=$collectionName');
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    var responseJson;
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
      );
      responseJson = jsonDecode(
        utf8.decode(newResponse.bodyBytes),
      );
    } else {
      responseJson = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
    }

    final List<Map<String, dynamic>> recipes = [];
    for (final Map<String, dynamic> item in responseJson) {
      final Recipe recipe = Recipe.fromMap(item);
      final bool isAdded = item['isExist_InCollection'];
      recipes.add({
        'recipe': recipe,
        'isAdded': isAdded,
      });
    }
    return recipes;
  }

  Future<void> addRecipeInCollection(int recipeId, int collectionId) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final url = Uri.parse('http://192.168.1.5:8000/CollectionRecipeView/');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: convert.jsonEncode(<String, String>{
        'collection': collectionId.toString(),
        'recipe': recipeId.toString(),
      }),
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
        body: convert.jsonEncode(<String, String>{
          'collection': collectionId.toString(),
          'recipe': recipeId.toString(),
        }),
      );
    }
  }

  Future<void> deleteRecipeFromCollection(
      int recipeId, int collectionId) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final url = Uri.parse(
        'http://192.168.1.5:8000/CollectionRecipeView/?collection_id=$collectionId&recipe_id=$recipeId');
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
      );
    }
  }

  Future<List<Allergy>> getUserAllergies(String langCode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String userName = sharedPreferences.getString('userName')!;
    final url = Uri.parse(
        'http://192.168.1.5:8000/userPrefAllergy/?username=$userName&lang_code=$langCode');
    final http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    });
    var _responseJson;
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $newAccessToken',
      });
      _responseJson = jsonDecode(
        utf8.decode(newResponse.bodyBytes),
      );
    } else {
      _responseJson = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
    }
    final List<Allergy> allergies = [];
    for (final item in _responseJson) {
      allergies.add(Allergy.fromMap(item));
    }
    return allergies;
  }

  Future<List<Map<String, dynamic>>> getAllergies(String langCode) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String userName = sharedPreference.getString('userName')!;
    final url = Uri.parse(
        'http://192.168.1.5:8000/GetAllergies/?lang_code=$langCode&username=$userName');
    final http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    });
    var _responseJson;
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      final http.Response newResponse = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $newAccessToken',
      });
      _responseJson = jsonDecode(
        utf8.decode(newResponse.bodyBytes),
      );
    } else {
      _responseJson = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
    }
    final List<Map<String, dynamic>> allergies = [];
    for (final item in _responseJson) {
      final Allergy allergy = Allergy.fromMapAllAllergies(item);
      final bool isAdded = item['isExist_In_my_Allergies'];
      allergies.add({
        'allergy': allergy,
        'isAdded': isAdded,
      });
    }
    return allergies;
  }

  Future<void> addAllergy(int allergyId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String userName = sharedPreferences.getString('userName')!;
    final url = Uri.parse('http://192.168.1.5:8000/userPrefAllergy/');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: convert.jsonEncode(
        <String, dynamic>{'username': userName, 'allergy': allergyId},
      ),
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
        body: convert.jsonEncode(
          <String, dynamic>{'username': userName, 'allergy': allergyId},
        ),
      );
    }
  }

  Future<void> deleteAllergy(int allergyId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final String userName = sharedPreferences.getString('userName')!;
    final url = Uri.parse(
        'http://192.168.1.5:8000/DeleteAllergy/?allergy=$allergyId&username=$userName');
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
        body: convert.jsonEncode(
          <String, dynamic>{'username': userName, 'allergy': allergyId},
        ),
      );
    }
  }

  Future<void> rateRecipe(int recipeId, int rate) async {
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken =
        await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken =
        await flutterSecureStorage.read(key: 'refresh_token');
    final url = Uri.parse('http://192.168.1.5:8000/RecipeRateView/');
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'recipe': recipeId,
        'rete': rate,
      }),
    );
    if (response.body.contains('Given token not valid')) {
      final String newAccessToken = await this.refreshToken(refreshToken!);
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $newAccessToken',
        },
        body: convert.jsonEncode(<String, dynamic>{
          'recipe': recipeId,
          'rete': rate,
        }),
      );
    }
  }
}
