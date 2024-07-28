import 'dart:convert';

import 'package:sunrise_app_v2/models/yourcard/product_model.dart';

class ProductResponse {
  List<Product> product = [];

  ProductResponse.fromJson(json) {
    json['products'].forEach((data) => product.add(Product.fromJson(data)));
  }
}
