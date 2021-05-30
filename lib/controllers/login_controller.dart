import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginController {
  Future<bool> getToken(username, password) async {
    var url = Uri.parse('http://10.0.2.2:8000/api-token/');
    try {
      var response = await http.post(
        url,
        body: convert.jsonEncode(
            <String, String>{'username': username, 'password': password}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
