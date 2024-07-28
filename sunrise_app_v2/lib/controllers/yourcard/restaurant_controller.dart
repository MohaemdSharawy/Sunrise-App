import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/response/yourcard/restaurant_response.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class RestaurantController extends GetxController {
  var restaurants = <Restaurant>[].obs;
  var loaded = false.obs;
  var room_service = Restaurant().obs;
  //! Use in Restaurant Or Bar Screen To Show Hotel Name On Title
  var hotel_name = ''.obs;

  Future<void> get_restaurants({required int hotel_id}) async {
    loaded.value = false;
    var response = await ApiYourCard.hotelRestaurant(hotel_id: hotel_id);
    restaurants.clear();
    var restaurnatResponse = RestaurantResponse.fromJson(response.data);
    hotel_name.value = response.data['hotel']['hotel_name'];
    restaurants.addAll(restaurnatResponse.restaurants);
    loaded.value = true;
  }

  Future<void> get_bars({required int hotel_id}) async {
    loaded.value = false;
    var response = await ApiYourCard.getHotelBars(hotel_id: hotel_id);
    restaurants.clear();
    var barResponse = RestaurantResponse.fromJson(response.data);
    hotel_name.value = response.data['hotel']['hotel_name'];
    restaurants.addAll(barResponse.restaurants);
    loaded.value = true;
  }

  Future<void> get_room_service({required int hotel_id}) async {
    loaded.value = false;
    var response = await ApiYourCard.hotelGetRoomService(hotel_id: hotel_id);
    if (response.data['restaurants'].length > 0) {
      room_service.value = Restaurant.fromJson(response.data['restaurants'][0]);
    }
  }

  Future<void> get_spa({required int hotel_id}) async {
    loaded.value = false;
    var response = await ApiYourCard.getHotelBars(hotel_id: hotel_id);
    restaurants.clear();
    var spaResponse = RestaurantResponse.fromJson(response.data);
    hotel_name.value = response.data['hotel']['hotel_name'];
    restaurants.addAll(spaResponse.restaurants);
    loaded.value = true;
  }
}
