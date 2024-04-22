import 'package:get/get.dart';
import 'package:tucana/model/art_of_food_model.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/response/art_of_food_response.dart';
import 'package:tucana/services/api.dart';

class ArtOfFoodController extends GetxController {
  var art_of_food = <ArtOfFoodModel>[].obs;
  var art_of_food_restaurant = <ArtOfFoodRestaurantModel>[].obs;
  var art_of_food_loaded = false.obs;

  var art_of_food_restaurant_view = ArtOfFoodRestaurantModel().obs;
  var art_of_restaurant_hotels = <ArtOfFoodHotels>[].obs;
  var art_of_food_restaurant_loaded = false.obs;

  Future<void> getArtOfFood() async {
    art_of_food_loaded.value = false;
    var response = await Api.get_art_of_foods();
    var art_of_food_response = ArtOfFoodResponse.fromJson(response.data);

    var art_of_food_restaurant_response =
        ArtOfFoodRestaurantResponse.fromJson(response.data);
    art_of_food.clear();
    art_of_food.addAll(art_of_food_response.art_of_food);
    art_of_food_restaurant.clear();
    art_of_food_restaurant
        .addAll(art_of_food_restaurant_response.art_of_food_restaurant);
    art_of_food_loaded.value = true;
  }

  Future<void> getViewArtOfFood({required String art_of_food_id}) async {
    art_of_food_restaurant_loaded.value = false;
    var resposne = await Api.get_art_of_food(art_of_food_id: art_of_food_id);
    // art_of_food_restaurant_view.value =
    //     ArtOfFoodRestaurantModel.fromJson(resposne.data['art_of_food_data']);

    art_of_food_restaurant_view.value = ArtOfFoodRestaurantModel.fromJson(
        resposne.data['art_of_food_restaurant']);

    var art_of_food_restaurant_hotel_response =
        ArtOfFoodRestaurantHotelsResponse.fromJson(resposne.data);
    art_of_restaurant_hotels.clear();
    art_of_restaurant_hotels.addAll(
        art_of_food_restaurant_hotel_response.art_of_food_restaurant_hotels);

    art_of_food_restaurant_loaded.value = true;
  }
}
