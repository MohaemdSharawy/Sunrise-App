import 'package:sunrise_app_v2/models/yourcard/category_model.dart';

class CategoriesResponse {
  List<Categories> categories = [];

  CategoriesResponse.fromJson(json) {
    json['categories']
        .forEach((data) => categories.add(Categories.fromJson(data)));
  }
}

class CategoriesTypesResponse {
  List<CategoriesTypes> categoriesTypesResponse = [];

  CategoriesTypesResponse.fromJson(json) {
    json['types'].forEach((data) => (data['category_data'].length > 0)
        ? categoriesTypesResponse.add(CategoriesTypes.fromJson(data))
        : print(data));
  }
}
