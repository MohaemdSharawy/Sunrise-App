import 'package:sunrise_app_v2/models/brand_model.dart';

class BrandsResponse {
  List<Brands> brands = [];
  BrandsResponse.fromJson(json) {
    json['brands'].forEach((data) => brands.add(Brands.fromJson(data)));
  }
}
