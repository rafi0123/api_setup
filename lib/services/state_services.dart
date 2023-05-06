import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_api/models/world_state_model.dart';
import 'package:learn_api/services/utility/app_url.dart';

class StateServices {
  Future<WorldStateModel> getWorldStateRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      print('Successfully');
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Erro');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('Successfully');
      return data;
    } else {
      throw Exception('Erro');
    }
  }
}
