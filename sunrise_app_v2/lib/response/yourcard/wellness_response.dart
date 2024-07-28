import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';

class WellnessResponse {
  List<Restaurant> wellness = [];
  WellnessResponse.fromJson(json) {
    json['spas'].forEach((data) => wellness.add(Restaurant.fromJson(data)));
  }
}
