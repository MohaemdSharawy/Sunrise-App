import 'package:sunrise_app_v2/models/hotel_includes_model.dart';

class HotelIncludesResponse {
  List<HotelIncludes> hotel_includes = [];
  HotelIncludesResponse.fromJson(json) {
    json['includes']
        .forEach((data) => hotel_includes.add(HotelIncludes.fromJson(data)));
  }
}
