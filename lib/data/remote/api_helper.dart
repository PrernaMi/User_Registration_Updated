import 'dart:convert';

import 'package:http/http.dart' as httpClient;

class ApiHelper {
  Future<dynamic> getApi({required String url}) async {
    Uri uri = Uri.parse(url);
    var response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
  }

  Future<bool> postApi(
      {required String url, required Map<String, dynamic> mBody}) async {
    Uri uri = Uri.parse(url);
    var response = await httpClient.post(uri, body: jsonEncode(mBody));
    if (response.statusCode == 200) {
      return true;
    }else{
      return false;
    }
  }
}
