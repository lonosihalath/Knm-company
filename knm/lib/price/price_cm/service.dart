import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:knm/price/price_cm/model.dart';

class RemoteServicePriceCM {
  static var client = http.Client();

  static Future<List<PriceCM>?> fetchCategories() async {
    var response = await client
        .get(Uri.parse('http://10.0.2.2:8000/api/price/cm'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(jsonString);
      return priceCMFromJson(response.body);
    } else {
      //show error message
      return null;
    }
  }
}