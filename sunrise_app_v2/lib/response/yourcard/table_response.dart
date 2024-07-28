import 'package:sunrise_app_v2/models/yourcard/table_model.dart';

class TablesResponse {
  List<Tables> tables = [];

  TablesResponse.fromJson(json) {
    json['tables'].forEach((data) => tables.add(Tables.fromJson(data)));
  }
}
