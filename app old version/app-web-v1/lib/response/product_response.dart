import 'dart:convert';

import 'package:tucana/model/product_model.dart';

class ProductResponse {
  List<Product> product = [];

  ProductResponse.fromJson(json) {
    json['products'].forEach((data) => product.add(Product.fromJson(data)));
  }
}

class SingleProductResponse {
  List<Product> product = [];
  SingleProductResponse.fromJson(json) {
    product.add(Product.fromJson(json['product']));
  }
}
