import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:knm/price/price_nn/model.dart';

class RemoteServicePriceNN {
  static var client = http.Client();

  static Future<List<PriceNN>?> fetchCategories() async {
    var response = await client
        .get(Uri.parse('http://10.0.2.2:8000/api/price/weight'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      print(jsonString);
      return priceNNFromJson(response.body);
    } else {
      //show error message
      return null;
    }
  }
}