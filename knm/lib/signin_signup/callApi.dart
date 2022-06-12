// ignore: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class CallApiOrder {
  final String _url = 'http://10.0.2.2:8000/api/';


  postDataupOrder(
    data,
    apiUrl,
    token,
  ) async {
    var fullUrl = _url+ apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(token));
  }

  _setHeaders(token) => {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

}