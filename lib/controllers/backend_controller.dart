import 'dart:convert';
import 'dart:convert' as convert;
//import 'dart:html';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BackEndController {
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
      final url = Uri.parse(
          "http://192.168.1.5:8000/CollectionView/?username=$userName&lang_code=$langCode");
      final http.Response response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));

      final List<Collection> collections = [];

      for (final item in _responseJson) {

        collections.add(Collection.fromMap(item));
      }

      return collections;
    } else {
      print("username is null");
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

    final url = Uri.parse("http://192.168.1.5:8000/CollectionView/");
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'collection_name': collectionName,
        'username': userName,
        'image':image,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
  Future<void> deleteCollection(String collectionName)async{
    final SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();

    final String? userName = _sharedPreferences.getString('userName');
    if (userName != null) {
      final url = Uri.parse(
          "http://192.168.1.5:8000/CollectionView/?username=$userName&collection_name=$collectionName");
      await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }

  }



}
