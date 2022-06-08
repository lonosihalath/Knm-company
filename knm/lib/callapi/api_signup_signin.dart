// ignore: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;


class CallApi {
  final String _url = 'http://10.0.2.2:8000/api/';
  postData(
    data,
    apiUrl,
  ) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }
  /// Facebook ////
  postloginFacebook(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl));
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
 

}
