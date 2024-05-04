

import 'package:discover_training_location/modals/data/data_model.dart';
import 'package:discover_training_location/services/response.dart';

class Repo {
  Repo._();

  static Future<List<DataModel>> callResponse() async {
    final List<dynamic> responseJsonList = await ResponseService.getResponse();

    final List<DataModel> responseList = [];

    responseJsonList.forEach((response) {
      responseList.add(DataModel.fromJson(response));
    });

    return responseList;
  }
}
