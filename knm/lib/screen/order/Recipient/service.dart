import 'package:http/http.dart' as http;
import 'package:knm/screen/order/Recipient/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteServiceRecipient {
  static Future<List<Recipient>?> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? id = preferences.getString('id');
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:8000/api/recipient/show/1');
    var response = await client.get(uri,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      
    }
  }
}
