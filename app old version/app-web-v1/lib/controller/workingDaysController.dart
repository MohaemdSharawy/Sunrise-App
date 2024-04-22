import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/model/ResturanModel.dart';
import 'package:tucana/model/allergies_model.dart';
import 'package:tucana/model/booking_type_model.dart';
import 'package:tucana/model/spa_model.dart';
import 'package:tucana/model/workingDaysModel.dart';
import 'package:tucana/response/Resturan_response.dart';
import 'package:tucana/response/allergies_response.dart';
import 'package:tucana/response/booking_type_response.dart';
import 'package:tucana/response/spa_response.dart';
import 'package:tucana/response/workingDaysResponse.dart';

import '../../services/api.dart';
import 'package:http/http.dart' as http;

class WorkingDayController extends GetxController {
  var singleWorkingDay = <WorkingDay>[].obs;
  var singleWorkingDayLoaded = false.obs;
  var isLoaded = false.obs;
  var time_loaded = false.obs;
  var workingDay = <WorkingDay>[].obs;
  var booking_type = <BookingType>[].obs;

  var restaurant = <Restaurant>[].obs;
  var allergies = <Allergies>[].obs;

  // var activity = <SpaCategories>[].obs;
  // var currentIndex = 0.obs;
  var spaProduct = <SpaProduct>[].obs;
  var activity = <Spa>[].obs;

  var booking_meals = <BookingMeals>[].obs;
  var meals_loaded  = false.obs;


  static const Map<String, String> _JSON_HEADERS = {
    "content-type": "application/json"
  };

  Future sendPost(Map<String, dynamic> data, url) async {
    http.Client client = new http.Client();
    final String encodedData = json.encode(data);
    // client.post(
    //   Uri.parse(url), //your address here
    //   body: encodedData,
    //   // headers: _JSON_HEADERS,
    // );
    try {
      final response = await client.post(
        Uri.parse(url), //your address here
        body: encodedData,
        // headers: {
        //   "security-code": "tGGLLxRIKBR1dhdEavkUWQ6Fwd3G9inQZHz5hm2U",
        //   "content-type": "application/json"
        // },
      );
      switch (response.statusCode) {
        case 200:
          return Get.snackbar(
            'Message',
            'Order Done Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        default:
          Get.snackbar(
            'Message',
            json.decode(response.body)['msg'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        // print(response.body);
        // throw Exception(json.decode(response.body)['msg']);
      }
    } on Exception catch (_) {
      // Get.snackbar(
      //   'Message',
      //   'Something Wrong happened',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      // rethrow;
    }
  }

  Future<void> getWorkingDays({required int restaurant_id}) async {
    var response = await Api.workingDay(restaurant_id: restaurant_id);

    // var checkResponse = jsonDecode(response.data);

    var workingDayResponse = WorkingDayResponse.fromJson(response.data);

    workingDay.clear();

    workingDay.addAll(workingDayResponse.workingDay);

    isLoaded.value = true;
    // await getRestaurantByCode(restaurant_Code: restaurant_Code);
    // currentIndex.value = 0;
    // print(lo)
  }

  Future<void> getRestaurantByCode({
    required String restaurant_Code,
    String? day_name,
    String? date,
  }) async {
    var response =
        await Api.restaurantCategories(restaurant_code: restaurant_Code);

    var restaurantResponse =
        RestaurantCategory.fromJson(response.data); //Return Single Restaurant

    restaurant.clear();

    restaurant.addAll(restaurantResponse.restaurant);

    if (day_name != null) {
      print(day_name);
      // await get_shifts_by_day(day_name: day_name, date: date);
    } else {
      await getWorkingDays(restaurant_id: int.parse(restaurant[0].id));
    }

    isLoaded.value = true;
  }

  Future<void> bookRestaurant({
    required int restaurant_id,
    required int hotel_id,
    required String room_no,
    required int pax,
    required String date,
    required String time,
    String? type_id,
    String? notes,
    required List allergies,
  }) async {
    // var response = await Api.bookRestaurant(
    //   restaurant_id: restaurant_id,
    //   hotel_id: hotel_id,
    //   room_no: room_no,
    //   pax: pax,
    //   date: date,
    //   time: time,
    // );

    Map<String, dynamic> postData = {
      'booking_restaurant': restaurant_id,
      'booking_hotel': hotel_id,
      'booking_room': room_no,
      'booking_pax': pax,
      'booking_date': date,
      'booking_time': time,
      'booking_id': '',
      'booking_type': type_id,
      'confirmation_num'  : GetStorage().read('confirmation'),
      'notes': notes,
      "allergies": allergies,
    };
    await sendPost(postData,
        'https://yourcart.sunrise-resorts.com/clients/api/post_booking');
    // var checkResponse = jsonDecode(response.data);

    // var workingDayResponse = WorkingDayResponse.fromJson(response.data);

    // workingDay.clear();

    // workingDay.addAll(workingDayResponse.workingDay);
  }

  Future<void> getActivityByCode({required String product_id}) async {
    var response = await Api.get_activity_category_product(
        product_id: int.parse(product_id));

    var spaResponse = SingleSpaResponse.fromJson(response.data);

    var spaProductResponse = SingleSpaProductResponse.fromJson(response.data);

    var spaActivityResponse = SingleSpaResponse.fromJson(response.data);

    activity.clear();

    spaProduct.clear();

    spaProduct.addAll(spaProductResponse.spa_product);

    activity.addAll(spaActivityResponse.spa);

    // spa.clear();

    // spa.addAll(spaResponse.spa);

    // var restaurantResponse =
    //     RestaurantCategory.fromJson(response.data); //Return Single Restaurant

    // restaurant.clear();

    // restaurant.addAll(restaurantResponse.restaurant);

    // await getWorkingDays(restaurant_id: int.parse(activity[0].id));

    isLoaded.value = true;
  }

  Future<void> bookSpa(
      {required int restaurant_id,
      required int hotel_id,
      required String room_no,
      required int pax,
      required String date,
      required String time,
      required int product_id}) async {
    // var response = await Api.bookSpa(
    //   restaurant_id: restaurant_id,
    //   product_id: product_id,
    //   hotel_id: hotel_id,
    //   room_no: room_no,
    //   pax: pax,
    //   date: date,
    //   time: time,
    // );
    // print(response);

    Map<String, dynamic> postData = {
      'booking_hotel': hotel_id.toString(),
      'booking_restaurant': restaurant_id.toString(),
      'booking_product': product_id.toString(),
      'booking_room': room_no,
      'booking_pax': pax,
      'booking_date': date,
      'booking_time': time,
      'booking_guset': null,
      'booking_birth_date': '1999-07-25',
      'booking_id': ''
    };
    await sendPost(postData,
        'https://yourcart.sunrise-resorts.com/clients/api/post_spa_booking');
  }

  Future<void> getSingleWorkingDay({
    required String restaurant_code,
    required String day,
  }) async {
    var response = await Api.restaurant_open_by_day(
      restaurant_code: restaurant_code,
      day: day,
    );
    var singleWorkingDayResponse =
        SingleWorkingDayResponse.fromJson(response.data);

    singleWorkingDay.clear();

    singleWorkingDay.addAll(singleWorkingDayResponse.workingDay);

    // var restaurantResponse = RestaurantResponse.fromJson(response.data);

    // // restaurantInfo.clear();

    // // restaurantInfo.addAll(restaurantResponse.restaurant);

    singleWorkingDayLoaded.value = true;
  }

  Future<void> get_shifts_by_day({
    required String day_name,
    String? date,
    required String restaurant_id,
    String? meal_id
  }) async {
    time_loaded.value = false;

    var response = await Api.workingTimeByDay(
        restaurant_id: restaurant_id, day_name: day_name, date: date , meal_id: meal_id);
    var workingDayResponse = WorkingDayResponse.fromJson(response.data);

    workingDay.clear();

    workingDay.addAll(workingDayResponse.workingDay);
    time_loaded.value = true;
  }

  Future<void> get_shifts_by_day_spa({
    required String day_name,
    required String restaurant_id,
    String? date,
  }) async {
    var response = await Api.workingTimeByDay(
        restaurant_id: restaurant_id, day_name: day_name, date: date);
    print(restaurant_id);
    var workingDayResponse = WorkingDayResponse.fromJson(response.data);

    workingDay.clear();

    workingDay.addAll(workingDayResponse.workingDay);
    isLoaded.value = true;
  }

  Future<void> get_booking_types() async {
    var response = await Api.get_booking_types();
    var booking_type_response = BookingTypeResponse.fromJson(response.data);
    booking_type.clear();
    booking_type.addAll(booking_type_response.booking_type);
  }

  Future<void> get_allergies() async {
    var response = await Api.get_allergies();
    var allergies_response = AllergiesResponse.fromJson(response.data);
    allergies.clear();
    allergies.addAll(allergies_response.allergies);
  }


  Future<void> get_booking_meals({required String h_id}) async{
    meals_loaded.value = false;
    var response = await Api.get_booking_meals(h_id: h_id);
    var booking_meals_response = BookingMealResponse.fromJson(response.data);
    booking_meals.clear();
    booking_meals.addAll(booking_meals_response.booking_meals);
    meals_loaded.value = true;
  }


}
