import 'package:tucana/model/product_custom_model.dart';

class ProductCustomOptionResponse {
  List<ProductCustomOption> custom_option = [];

  ProductCustomOptionResponse.fromJson(json) {
    json['custom_option'].forEach(
        (data) => custom_option.add(ProductCustomOption.fromJson(data)));
  }
}
