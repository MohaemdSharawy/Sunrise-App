import 'dart:convert';

import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/yourcard/category_model.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/models/yourcard/spa_category_model.dart';
import 'package:sunrise_app_v2/response/yourcard/category_response.dart';
import 'package:sunrise_app_v2/response/yourcard/restaurant_response.dart';
import 'package:sunrise_app_v2/response/yourcard/spa_category_response.dart';
import 'package:sunrise_app_v2/response/yourcard/wellness_response.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class WellnessController extends GetxController {
  var spaLoaded = false.obs;

  var spas = <Restaurant>[].obs;

  var spa = Restaurant().obs;

  var spaCategories = <SpaCategories>[].obs;

  Future<void> getSpas({required int yourCart_hotel_id}) async {
    spaLoaded.value = false;
    var hotel_code = await getYourCardHotelCode(
      yourCartHotelId: yourCart_hotel_id,
    );
    var response = await ApiYourCard.getHotelActivity(hotel_code: hotel_code);
    spa.value = Restaurant.fromJson(response.data['spas'][0]);
    spaLoaded.value = true;
  }

  // ! Get Hotel Code Form Your Card
  getYourCardHotelCode({required int yourCartHotelId}) async {
    var response = await ApiYourCard.getHotelData(hotel_id: yourCartHotelId);
    return response.data['hotel']['code'];
  }

  Future<void> getSpaCategories({required String spa_code}) async {
    var response =
        await ApiYourCard.get_activity_categories(spa_code: spa_code);

    var spaCategoriesResponse = SpaCategoriesResponse.fromJson(response.data);

    spaCategories.clear();

    spaCategories.addAll(spaCategoriesResponse.spa_categories);
  }
}
