import 'dart:convert';

import 'package:tucana/model/categories_model.dart';

class CategoriesResponse {
  List<Categories> categories = [];

  CategoriesResponse.fromJson(json) {
    json['categories']
        .forEach((data) => categories.add(Categories.fromJson(data)));
  }
}

class CategoryResponse {
  List<Categories> category = [];
  CategoryResponse.fromJson(json) {
    category.add(Categories.fromJson(json['category']));
  }
}
