import 'package:tucana/model/art_of_food_model.dart';
import 'package:tucana/model/hotel_model.dart';

class ArtOfFoodResponse {
  List<ArtOfFoodModel> art_of_food = [];

  ArtOfFoodResponse.fromJson(json) {
    json['art_of_food']
        .forEach((data) => art_of_food.add(ArtOfFoodModel.fromJson(data)));
  }
}

class ArtOfFoodRestaurantResponse {
  List<ArtOfFoodRestaurantModel> art_of_food_restaurant = [];

  ArtOfFoodRestaurantResponse.fromJson(json) {
    json['art_of_food_restaurant'].forEach((data) =>
        art_of_food_restaurant.add(ArtOfFoodRestaurantModel.fromJson(data)));
  }
}

class ArtOfFoodRestaurantHotelsResponse {
  List<ArtOfFoodHotels> art_of_food_restaurant_hotels = [];

  ArtOfFoodRestaurantHotelsResponse.fromJson(json) {
    json['art_of_food_hotel'].forEach((data) =>
        art_of_food_restaurant_hotels.add(ArtOfFoodHotels.fromJson(data)));
  }
}
