import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';

class RestaurantResponse {
  List<Restaurant> restaurants = [];
  RestaurantResponse.fromJson(json) {
    json['restaurants']
        .forEach((data) => restaurants.add(Restaurant.fromJson(data)));
  }
}
