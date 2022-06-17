// ignore: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class CallApiOrder {
  final String _url = 'http://10.0.2.2:8000/api/order/';
  final String _urlphuhub = 'http://10.0.2.2:8000/api/recipient/';
  final String _urlphusong = 'http://10.0.2.2:8000/api/sender/';


  postDataupOrder(
    data,
    apiUrl,
    token,
  ) async {
    var fullUrl = _url+ apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(token));
  }
  postDataphuhub(
    data,
    apiUrl,
    token,
  ) async {
    var fullUrl = _urlphuhub+ apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(token));
  }
  postDataphusong(
    data,
    apiUrl,
    token,
  ) async {
    var fullUrl = _urlphusong+ apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders(token));
  }

  _setHeaders(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

}