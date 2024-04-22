import 'package:tucana/model/table_model.dart';

class TablesResponse {
  List<Tables> tables = [];

  TablesResponse.fromJson(json) {
    json['tables'].forEach((data) => tables.add(Tables.fromJson(data)));
  }
}
