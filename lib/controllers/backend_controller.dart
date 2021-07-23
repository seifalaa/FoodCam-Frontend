import 'dart:convert';
import 'dart:convert' as convert;
//import 'dart:html';
import 'package:flutter/services.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
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
  // Future<List<Category>> getAllCategories() async{
  //
  //
  //
  // }

  Future<List<Recipe>> getTopRated(String langCode) async{
    final url = Uri.parse(
        "http://192.168.1.5:8000/GetTopRatedRecipes?lang_code=$langCode");
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final _responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    print(_responseJson);
    print("saeed");
    final List<Recipe> recipes = [];
    for (final item in _responseJson) {
      recipes.add(Recipe.fromMap(item));
    }
    return recipes;


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
