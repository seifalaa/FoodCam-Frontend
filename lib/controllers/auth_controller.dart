import 'dart:convert' as convert;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<http.Response> loginWithEmailAndPassword(
      String email, String password) async {
    final url = Uri.parse('http://192.168.1.5:8000/dj-rest-auth/login/');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<void> logout() async {
    final url = Uri.parse('http://192.168.1.5:8000//dj-rest-auth/logout/');
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
    await _sharedPreferences.remove('userName');
    await _sharedPreferences.remove('firstName');
    await _sharedPreferences.remove('lastName');
    await _flutterSecureStorage.deleteAll();
  }

  Future<http.Response> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final url = Uri.parse('http://192.168.1.5:8000/GoogleLogin/');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'access_token': googleAuth.accessToken,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final url = Uri.parse('http://192.168.1.5:8000/FacebookLogin/');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'access_token': result.accessToken!.token,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> register(String username, String email, String password,
      String password2, String firstName, String lastName) async {
    final url = Uri.parse('http://192.168.1.5:8000/register/');
    final response = await http.post(url,
        body: convert.jsonEncode(<String, dynamic>{
          'username': username,
          'email': email,
          'password1': password,
          'password2': password2,
          'first_name': firstName,
          'last_name': lastName,
        }),
        headers: {'Content-Type': 'application/json', 'charset': 'utf-8'});
    return response;
  }
}
