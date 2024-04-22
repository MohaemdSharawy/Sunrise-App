import 'dart:convert';

import 'package:tucana/model/ResturanModel.dart';

class RestaurantResponse {
  List<Restaurant> restaurant = [];

  RestaurantResponse.fromJson(json) {
    // final data_type = jsonDecode(json);
    // print(json['restaurants']);
    json['restaurants']
        .forEach((data) => restaurant.add(Restaurant.fromJson(data)));
  }
}

class RestaurantCategory {
  List<Restaurant> restaurant = [];
  RestaurantCategory.fromJson(json) {
    restaurant.add(Restaurant.fromJson(json['restaurant']));
  }
}

class RestaurantBookingResponse {
  List<Restaurant> restaurant_booking = [];

  RestaurantBookingResponse.fromJson(json) {
    // final data_type = jsonDecode(json);
    // print(json['restaurants']);
    json['restaurants'].forEach((data) => (data['ordering'] == "1")
        ? restaurant_booking.add(Restaurant.fromJson(data))
        : print(data));
  }
}
