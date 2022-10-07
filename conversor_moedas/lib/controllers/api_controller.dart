import 'dart:convert';

import 'package:http/http.dart' as http;

const requisitionUrl = "https://api.hgbrasil.com/finance?key=278f0d9e";

class ApiController {
  static Future<Map<String, dynamic>?> getData() async {
    final response = await http.get(Uri.parse(requisitionUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }
}
