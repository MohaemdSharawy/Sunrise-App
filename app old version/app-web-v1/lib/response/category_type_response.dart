import 'dart:convert';

import 'package:tucana/model/category_type_model.dart';

class CategoryTypeResponse {
  List<CategoryType> categoryType = [];

  CategoryTypeResponse.fromJson(json) {
    json['types']
        .forEach((data) => categoryType.add(CategoryType.fromJson(data)));
  }
}
