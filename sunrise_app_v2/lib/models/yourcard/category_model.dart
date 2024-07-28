import 'package:sunrise_app_v2/models/yourcard/product_model.dart';
import 'package:sunrise_app_v2/response/yourcard/product_response.dart';

class Categories {
  late int id;

  late String category_name;

  late String code;

  List<Product> product = [];

  Categories.fromJson(json) {
    id = int.parse(json['id']);

    category_name = json['category_name'] ?? '';

    code = json['code'] ?? ' ';

    json['products'].forEach((data) => product.add(Product.fromJson(data))) ??
        [];
  }
}

class CategoriesTypes {
  late String id;
  late String categoryName;
  late String code;
  late String logo;
  late String image;
  late String description;

  CategoriesTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName =
        (json['category_name'] != null) ? json['category_name'] : ' ';
    code = (json['code'] != null) ? json['code'] : ' ';
    logo = (json['logo'] != null) ? json['logo'] : ' ';
    image = (json['image'] != null) ? json['image'] : ' ';
    description = (json['description'] != null) ? json['description'] : ' ';
  }
}
