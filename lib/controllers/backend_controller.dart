import 'dart:convert';
import 'dart:convert' as convert;
//import 'dart:html';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
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
    //print(response.body);
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

  // Future<Recipe> generateRandomRecipe(String categoryName,String langcode){

  // }

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
      //TODO: check response and send refresh token if the access token is exired
      var _responseJson;
      //print(response.body);
      if (response.body.contains('Given token not valid')) {
        //print('here');
        final String newAccessToken = await this.refreshToken(refreshToken!);
        final http.Response newResponse = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $newAccessToken',
          },
        );
        //print(newResponse);
        _responseJson = jsonDecode(
          utf8.decode(newResponse.bodyBytes),
        );
      } else {
        _responseJson = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
      }
      //print(_responseJson);
      final List<Collection> collections = [];

      for (final item in _responseJson) {

        collections.add(Collection.fromMap(item));
      }

      return collections;
    } else {
      //print("username is null");
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
        //print(newResponse);
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
  Future<List<Category>> getAllCategories(String langCode) async{
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

   Future<List<Recipe>> searchByMultipleIngredients(String langCode,List<String> ingredientName)async{

     final url = Uri.parse(
         "http://192.168.1.5:8000/SearchRecipeByIngredients/");
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
  Future<List<Recipe>> getTopRated(String langCode) async{
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

  Future<http.Response> addCollection(
      String collectionName, String image) async {
    // Future<List<Recipe>> getRecentlySearch ()async{
    //
    //
    //
    //
    // }
    Future<List<Ingredient>> getBasketIngredients(String langCode)async{
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    final String? accessToken = await flutterSecureStorage.read(key: 'access_token');
    final String? refreshToken = await flutterSecureStorage.read(key: 'refresh_token');
    final SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
    //print("Saeed");
      final String? userName = _sharedPreferences.getString('userName');
      if (userName != null) {
        final url = Uri.parse(
            "http://192.168.1.5:8000/UserIngredientView/?username=$userName&lang_code=$langCode");
        final http.Response response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization' :'Bearer $accessToken',
          },
        );

        final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

        //print(_responseJson);
        final List<Ingredient> ingredients = [];

        for (final item in _responseJson) {
          //print(item);
          ingredients.add(Ingredient.fromMapBasket(item));
        }
       // print("sae");
        //print(ingredients);
        return ingredients;
      } else {
        print("username is null");
        return [];
      }
    }



    Future<void> deleteIngredientFromBasket (int ingredientID)async{
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken = await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken = await flutterSecureStorage.read(key: 'refresh_token');
      final SharedPreferences _sharedPreferences =
      await SharedPreferences.getInstance();

      final String? userName = _sharedPreferences.getString('userName');
      if (userName != null) {
        final url = Uri.parse(
            "http://192.168.1.5:8000/UserIngredientView/?username=$userName&ingredient=$ingredientID");
        await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization' :'Bearer $accessToken',
          },
        );
      }



    }

    Future<http.Response> addIngredientInBasket(int ingredientId)async{
      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken = await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken = await flutterSecureStorage.read(key: 'refresh_token');

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
          'Authorization' :'Bearer $accessToken',
        },

      );
      final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print(_responseJson);
      return response;
    }




    Future<List<Map<String,dynamic>>> ingredientBasketSearch(String query)async{

      const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      final String? accessToken = await flutterSecureStorage.read(key: 'access_token');
      final String? refreshToken = await flutterSecureStorage.read(key: 'refresh_token');
      final SharedPreferences _sharedPreferences =
      await SharedPreferences.getInstance();
      //print("Saeed");
      final String? userName = _sharedPreferences.getString('userName');
      if (userName != null) {
        final url = Uri.parse(
            "http://192.168.1.5:8000/searchIngredient/?user_input=$query&username=$userName");
        final http.Response response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization' :'Bearer $accessToken',
          },
        );

        final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

        print(_responseJson);
        //print("Saeed");
        final List<Map<String,dynamic>> ingredients = [];

        for(final Map<String,dynamic> item in _responseJson){
           final Ingredient ingredient = Ingredient.fromMapBasket(item);
          final bool isAdded=item['ingredient']['my_ingredient'];
          ingredients.add({
            'ingredient' : ingredient,
            'isAdded' : isAdded,

          });

        }
        //print("Saeed");
        //print(ingredients);
        return ingredients;
      } else {
        print("username is null");
        return [];
      }

    }

    Future<http.Response> addCollection(String collectionName,String image) async {
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
    //TODO: check response and send refresh token if the access token is exired
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
          'Authorization': 'Bearer $accessToken',
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
    final SharedPreferences sharedPreferences =
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
    //TODO: check response and send refresh token if the access token is exired
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
}
