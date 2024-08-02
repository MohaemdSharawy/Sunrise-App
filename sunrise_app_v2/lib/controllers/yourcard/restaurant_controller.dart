import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/yourcard/meal_model.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/models/yourcard/workingDaysModel.dart';
import 'package:sunrise_app_v2/response/yourcard/meal_response.dart';
import 'package:sunrise_app_v2/response/yourcard/restaurant_response.dart';
import 'package:sunrise_app_v2/response/yourcard/workingDaysResponse.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class RestaurantController extends GetxController {
  var restaurants = <Restaurant>[].obs;
  var loaded = false.obs;
  var room_service = Restaurant().obs;
  //! Use in Restaurant Or Bar Screen To Show Hotel Name On Title
  var hotel_name = ''.obs;
  var singleWorkingDay = <WorkingDay>[].obs;
  var singleWorkingDayLoaded = false.obs;
  var restaurant = Restaurant().obs;
  var info_loaded = false.obs;
  var meal = <Meal>[].obs;
  var meal_loaded = false.obs;

  // var meals =

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

  Future<void> getRestaurantInfo({
    required String restaurant_code,
    required String day,
  }) async {
    info_loaded.value = false;
    var response = await ApiYourCard.restaurant_open_by_day(
      restaurant_code: restaurant_code,
      day: day,
    );
    print(response.data);
    var singleWorkingDayResponse =
        SingleWorkingDayResponse.fromJson(response.data);
    singleWorkingDay.clear();
    singleWorkingDay.addAll(singleWorkingDayResponse.workingDay);
    restaurant.value = Restaurant.fromJson(response.data['restaurant']);
    info_loaded.value = true;
  }

  Future<void> updateRestaurantWorkingDays({
    required String restaurant_code,
    required String day,
  }) async {
    singleWorkingDayLoaded.value = false;
    var response = await ApiYourCard.restaurant_open_by_day(
      restaurant_code: restaurant_code,
      day: day,
    );
    var singleWorkingDayResponse =
        SingleWorkingDayResponse.fromJson(response.data);
    singleWorkingDay.clear();
    singleWorkingDay.addAll(singleWorkingDayResponse.workingDay);
    singleWorkingDayLoaded.value = true;
  }

  Future<void> getMails({required String restaurant_code}) async {
    var response = await ApiYourCard.get_meal(restaurant_code: restaurant_code);
    var mealResponse = MealResponse.fromJson(response.data);
    meal.clear();
    meal.addAll(mealResponse.meal);
    meal_loaded.value = true;
  }

  Future<void> get_restaurant_by_code({required String restaurant_code}) async {
    var response = await ApiYourCard.get_restaurant_by_code(
        restaurant_code: restaurant_code);
    restaurant.value = Restaurant.fromJson(response.data['restaurant']);
  }
}
