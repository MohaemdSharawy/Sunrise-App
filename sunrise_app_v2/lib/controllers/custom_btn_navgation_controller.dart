import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/screens/Auth/profile.dart';
import 'package:sunrise_app_v2/screens/home_screen.dart';
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
      ProfileScreen(),
    ],
    "outsider": [
      HomeScreen(),
      ResortsScreen(),
    ]
  }.obs;

  // var screens = [
  //   HomeScreen(),
  //   ResortsScreen(),
  //   ProfileScreen(),
  // ];

  var screen_names = {
    "auth": [
      "Home",
      "Book",
      "Account",
    ],
    "outsider": {
      "Home",
      "Book",
      "Account",
    }
  }.obs;
  var screen_icons = {
    "auth": [
      "Home",
      "Book",
      "Account",
    ],
    "outsider": {
      "Home",
      "Book",
      "Account",
    }
  }.obs;

  // var selected_type = 'outsider'.obs;

  // var selected_type = GetStorage().read('screen_type').obs;
  var selected_type = 'outsider';

  var current_index = 0.obs;
}