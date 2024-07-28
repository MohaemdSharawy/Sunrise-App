import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/screens/Auth/profile.dart';
import 'package:sunrise_app_v2/screens/Auth/wish_list_scrren.dart';
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
  var selected_type = ''.obs;

  @override
  void onInit() {
    print('navgation COnn');
    if (GetStorage().read('user_token') == null) {
      selected_type.value = 'outsider';
    } else {
      selected_type.value = 'auth';
    }
    super.onInit();
  }

  var screens = {
    "auth": [
      HomeScreen(),
      ResortsScreen(),
      MyStayScreen(),
      WishListScreen(),
      ProfileScreen(),
    ],
    "outsider": [
      HomeScreen(),
      ResortsScreen(),
      MyStayScreen(),
    ]
  }.obs;

  var screen_names = {
    "auth": [
      "Home",
      "Book",
      "My Stay",
      "Wish List",
      "Account",
    ],
    "outsider": [
      "Home",
      "Book",
      "My Stay",
    ]
  }.obs;
  // var screen_icons = {
  //   "auth": [
  //     Icon(Icons.home),
  //     Icon(Icons.calendar_today_rounded),
  //     Icon(Icons.bed),
  //     Icon(Icons.account_circle),
  //   ],
  //   "outsider": [
  //     Icon(Icons.home),
  //     Icon(Icons.home),
  //   ]
  // }.obs;

  var screen_icons = {
    "auth": [
      Icons.home_outlined,
      Icons.calendar_today_rounded,
      Icons.bed_outlined,
      Icons.favorite_outline,
      Icons.account_circle_outlined,
    ],
    "outsider": [
      Icons.home_outlined,
      Icons.calendar_today_rounded,
      Icons.bed_outlined,
    ]
  }.obs;
  // var selected_type = 'outsider'.obs;

  // var selected_type = GetStorage().read('screen_type').obs;

  var current_index = 0.obs;
}
