import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:knm/condition/model.dart';

class RemoteServiceCondition {
  static var client = http.Client();

  static Future<List<Condition1>?> fetchBranch() async {
    var response = await client
        .get(Uri.parse('http://10.0.2.2:8000/api/condition'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(jsonString);
      return conditionFromJson(response.body);
    } else {
      //show error message
      return null;
    }
  }
}
