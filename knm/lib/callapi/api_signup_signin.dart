// ignore: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;


class CallApi {
  final String _url = 'http://10.0.2.2:8000/api/';
  final String _urlorder = 'http://10.0.2.2:8000/api/order/insert';
  postData(
    data,
    apiUrl,
  ) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }
  postDataOrder(
    data,
    token
  ) async {
    var fullUrl = _urlorder;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders1(token));
  }

  postDatalogin(
    data,
    apiUrl,
  ) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }



  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _setHeaders1(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
 

}
