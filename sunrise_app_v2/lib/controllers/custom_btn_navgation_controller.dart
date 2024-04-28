import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/screens/Auth/profile.dart';
import 'package:sunrise_app_v2/screens/home_screen.dart';
import 'package:sunrise_app_v2/screens/mystay_screen.dart';
import 'package:sunrise_app_v2/screens/resorts_screen.dart';

class CustomNavigationNController extends GetxController {
  // var screens = [
  //   HomeScreen(),
  // ].obs;

  // var outSiderScreens = [
  //   HomeScreen(),
  // ].obs;

  var screens = {
    "auth": [
      HomeScreen(),
      ResortsScreen(),
      MyStayScreen(),
      ProfileScreen(),
    ],
    "outsider": [
      HomeScreen(),
      ResortsScreen(),
    ]
  }.obs;

  var screen_names = {
    "auth": [
      "Home",
      "Book",
      "My Stay",
      "Account",
    ],
    "outsider": [
      "Home",
      "Book",
    ]
  }.obs;
  var screen_icons = {
    "auth": [
      Icon(Icons.home),
      Icon(Icons.calendar_today_rounded),
      Icon(Icons.bed),
      Icon(Icons.account_circle),
    ],
    "outsider": [
      Icon(Icons.home),
      Icon(Icons.home),
    ]
  }.obs;

  // var selected_type = 'outsider'.obs;

  // var selected_type = GetStorage().read('screen_type').obs;
  var selected_type = 'auth'.obs;

  var current_index = 0.obs;
}
