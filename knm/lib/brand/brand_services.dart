import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:knm/brand/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteServiceBranch {
  static var client = http.Client();

  static Future<List<Brand>?> fetchBranch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    var response = await client
        .get(Uri.parse('http://10.0.2.2:8000/api/branch'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(jsonString);
      return postFromJson(response.body);
    } else {
      //show error message
      return null;
    }
  }
}
