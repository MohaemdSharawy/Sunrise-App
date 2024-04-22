import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/model/ResturanModel.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/model/spa_model.dart';
import 'package:tucana/response/Resturan_response.dart';
import 'package:tucana/response/hotel_response.dart';
import 'package:tucana/response/spa_response.dart';

import '../../services/api.dart';

class RestaurantController extends GetxController {
  var isLoaded = false.obs;
  var restaurant = <Restaurant>[].obs;
  var currentIndex = 0.obs;
  var hotel = <Hotels>[].obs;
  var spa = <Spa>[].obs;
  var room_service = <Restaurant>[].obs;
  var shisha = <Restaurant>[].obs;
  var mine_bar = <Restaurant>[].obs;
  var bars = <Restaurant>[].obs;
  var spaLoaded = false.obs;
  var barsLoaded = false.obs;
  var gym = <Spa>[].obs;
  var gymLoaded = false.obs;

  var diningLoading = false.obs;

  var wellnessLoading = false.obs;

  var single_restaurant = Restaurant().obs;

  final hotelController = Get.put(HotelsController());

  Future<void> getRestaurant({required int hotel_id}) async {
    var response = await Api.hotelResturan(hotel_id: hotel_id);

    // var checkResponse = jsonDecode(response.data);

    var restaurantResponse = RestaurantResponse.fromJson(response.data);
    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();

    restaurant.clear();

    restaurant.addAll(restaurantResponse.restaurant);

    hotel.addAll(hotelResponse.hotel);

    currentIndex.value = 0;
    isLoaded.value = true;
    // print(lo)
  }

  Future<void> getSpas({required String hotel_code}) async {
    var response = await Api.getHotelActivity(hotel_code: hotel_code);

    var spaResponse = SpaResponse.fromJson(response.data);

    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();

    spa.clear();

    spa.addAll(spaResponse.spa);

    hotel.addAll(hotelResponse.hotel);

    // print(spa);
    currentIndex.value = 0;
    spaLoaded.value = true;
  }

  Future<void> getRoomService({required int hotel_id}) async {
    var response = await Api.getRoomService(h_id: hotel_id);

    var restaurantResponse = RestaurantResponse.fromJson(response.data);

    room_service.clear();
    room_service.addAll(restaurantResponse.restaurant);

    // var restaurantResponse = RestaurantResponse.fromJson(response.data);

    // restaurant.clear();

    // restaurant.addAll(restaurantResponse.restaurant);

    // currentIndex.value = 0;
    // isLoaded.value = true;
    // print(lo)
  }

  Future<void> getShisha({required int hotel_id}) async {
    var response = await Api.getShisha(h_id: hotel_id);

    var restaurantResponse = RestaurantResponse.fromJson(response.data);

    shisha.clear();
    shisha.addAll(restaurantResponse.restaurant);
  }

  Future<void> getMineBar({required int hotel_id}) async {
    var response = await Api.getMineBar(h_id: hotel_id);

    var restaurantResponse = RestaurantResponse.fromJson(response.data);

    mine_bar.clear();
    mine_bar.addAll(restaurantResponse.restaurant);
  }

  Future<void> getBars({required int hotel_id}) async {
    var response = await Api.getBars(hotel_id: hotel_id);

    var barsResponse = RestaurantResponse.fromJson(response.data);

    bars.clear();

    bars.addAll(barsResponse.restaurant);
    barsLoaded.value = true;
  }

  Future<void> getGym({required String hotel_code}) async {
    var response = await Api.getHotelGym(hotel_code: hotel_code);
    // print(response.data);
    var gymResponse = GymResponse.fromJson(response.data);

    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();

    gym.clear();

    gym.addAll(gymResponse.gym);

    hotel.addAll(hotelResponse.hotel);

    gymLoaded.value = true;
  }

  Future<void> restaurantByCode({required String restaurant_code}) async {
    var response =
        await Api.get_restaurant_by_code(restaurant_code: restaurant_code);
    single_restaurant.value = Restaurant.fromJson(response.data['restaurant']);

    await hotelController.getHotel(hid: single_restaurant.value.hid);
  }

  Future<void> getRestaurantBooking({required int hotel_id}) async {
    var response = await Api.hotelResturan(hotel_id: hotel_id);

    // var checkResponse = jsonDecode(response.data);

    var restaurantResponse = RestaurantBookingResponse.fromJson(response.data);
    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();

    restaurant.clear();

    print(restaurantResponse.restaurant_booking);
    restaurant.addAll(restaurantResponse.restaurant_booking);

    hotel.addAll(hotelResponse.hotel);

    currentIndex.value = 0;
    isLoaded.value = true;
  }
}
