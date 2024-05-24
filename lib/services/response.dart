import 'dart:convert';
import 'package:discover_training_location/constants/data_location.dart';
import 'package:discover_training_location/services/request.dart';
class ResponseService {
  ResponseService._();

  static Future<List<dynamic>> getResponse() async {
    // * LOCAL CALL
    final String request = await Request.readJson(DataLocations.localData);
    final Map<String, dynamic> jsonMap =
        jsonDecode(request) as Map<String, dynamic>;

    // * API CALL
    // final responseRaw = await http.get(
    //   Uri.parse(
    //     DataLocations.url,
    //   ),
    // );
    // final Map<String, dynamic> jsonMap =
    //     jsonDecode(responseRaw.body) as Map<String, dynamic>;

    List<dynamic> rs = [];

    jsonMap.forEach((key, value) {
      if (value is List) {
        if (rs.isEmpty) rs = value;
      }
    });

    return rs;
  }
}
