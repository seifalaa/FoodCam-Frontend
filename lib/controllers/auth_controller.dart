import 'dart:convert' as convert;

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<bool> loginWithEmailAndPassword(
      String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/auth/token/');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'client_id': kClientId,
        'client_secret': kClientSecret,
        'grant_type': 'password',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final url = Uri.parse('http://10.0.2.2:8000/auth/convert-token');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'client_id': kClientId,
        'client_secret': kClientSecret,
        'grant_type': 'convert_token',
        'backend': 'google-oauth2',
        'token': googleAuth.accessToken,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final url = Uri.parse('http://10.0.2.2:8000/auth/convert-token');
    final response = await http.post(
      url,
      body: convert.jsonEncode(<String, dynamic>{
        'client_id': kClientId,
        'client_secret': kClientSecret,
        'grant_type': 'convert_token',
        'backend': 'facebook',
        'token': result.accessToken!.token,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String username, String email, String password,
      String password2, String firstName, String lastName) async {
    final url = Uri.parse('http://10.0.2.2:8000/register/');
    final response = await http.post(url,
        body: convert.jsonEncode(<String, dynamic>{
          'username': username,
          'email': email,
          'password1': password,
          'password2': password2,
          'first_name': firstName,
          'last_name': lastName,
        }),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
