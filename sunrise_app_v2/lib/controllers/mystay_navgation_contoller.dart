import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/models/hotel_model.dart';
import 'package:sunrise_app_v2/screens/Auth/profile.dart';
import 'package:sunrise_app_v2/screens/my_stay/dining_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/hotel_home_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/wellness_screen.dart';

class MyStayNavNController extends GetxController {
  var current_index = 0.obs;
  var hotel = Hotels().obs;
  var check_in_data;
  var screens = [].obs;

  @override
  void onInit() {
    check_in_data = jsonDecode(GetStorage().read('check_in_hotel'));
    hotel.value = Hotels.fromJson(check_in_data);
    screens.addAll([
      HotelHomeScreen(hotel_id: hotel.value.id),
      DinningScreen(hotel_id: hotel.value.id),
      WellnessScreen(
        hotel_id: hotel.value.id,
      ),
      ProfileScreen()
    ]);
    super.onInit();
  }

  var screens_name = [
    'Resort',
    'Dining',
    'Wellness',
    'Account',
  ];

  // var screens_icon = [
  //   Icon(Icons.business),
  //   Icon(Icons.restaurant),
  //   Icon(Icons.spa_outlined),
  //   Icon(Icons.account_circle),
  // ].obs;
  var screens_icon = [
    Icons.meeting_room_outlined,
    Icons.restaurant_menu_outlined,
    Icons.spa_outlined,
    Icons.account_circle_outlined,
  ].obs;
}
