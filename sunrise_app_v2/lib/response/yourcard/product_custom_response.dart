import 'package:sunrise_app_v2/models/yourcard/product_custom_option.dart';

class ProductCustomOptionResponse {
  List<ProductCustomOption> custom_option = [];

  ProductCustomOptionResponse.fromJson(json) {
    json['custom_option'].forEach(
        (data) => custom_option.add(ProductCustomOption.fromJson(data)));
  }
}
