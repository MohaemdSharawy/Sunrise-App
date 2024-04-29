import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/screens/Auth/profile.dart';
import 'package:sunrise_app_v2/screens/my_stay/dining_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/hotel_home_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/wellness_screen.dart';

class MyStayNavNController extends GetxController {
  var current_index = 0.obs;

  var screens = [
    HotelHomeScreen(),
    DinningScreen(),
    WellnessScreen(),
    ProfileScreen()
  ].obs;

  var screens_name = [
    'Resort',
    'Dining',
    'Wellness',
    'Account',
  ];

  var screens_icon = [
    Icon(Icons.business),
    Icon(Icons.restaurant),
    Icon(Icons.spa_outlined),
    Icon(Icons.account_circle),
  ].obs;
}
