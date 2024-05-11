import 'package:flutter/services.dart';

class Request {
  Request._();

  static Future<String> readJson(String url) async {
    final String response = await rootBundle.loadString(
      url,
    );
    return response;
  }
}
