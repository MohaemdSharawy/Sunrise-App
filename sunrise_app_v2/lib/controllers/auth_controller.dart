import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/controllers/custom_btn_navgation_controller.dart';
import 'package:sunrise_app_v2/models/user_model.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/screens/check_reservation_screen.dart';
import 'package:sunrise_app_v2/screens/home_screen.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';
import 'package:sunrise_app_v2/services/api.dart';

class AuthController extends GetxController {
  var tryLogin = true.obs;
  var registerLoading = true.obs;
  var checkInLoading = true.obs;

  // var user = UserModel().obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    tryLogin.value = false;
    try {
      var response = await Api.login(email: email, password: password);
      GetStorage().write("user_token", response.data['access_token']);
      GetStorage().write('user_data', jsonEncode(response.data['data']));
      if (response.data['data']['checked_in'] == 1) {
        Get.off(MainScree());
      } else {
        Get.off(CheckHaveReservation());
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          Get.snackbar('Message', e.response!.data['message']);
        } else {
          Get.snackbar('Message', e.response!.data['message']);
        }
      }
    }

    tryLogin.value = true;
  }

  Future<void> register({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) async {
    registerLoading.value = false;

    try {
      await Api.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      Get.snackbar('Success', "User Created Successfully");
      Get.to(LoginScreen());
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          Get.snackbar('Message', 'This Email Already Used');
        }
      }
    }
    registerLoading.value = true;
  }

  Future<void> logout() async {
    try {
      await Api.logout();
    } on DioException catch (e) {
      // if (e.response != null) {
      //   print('ERRRRRRRRorrrrrrrr');
      //   if (e.response!.statusCode == 404) {
      //     Get.snackbar('Message', e.response!.data['message']);
      //   } else {
      //     Get.snackbar('Message', e.response!.data['message']);
      //   }
      // }
    }
    GetStorage().remove('check_id_data');
    GetStorage().remove('user_token');
    GetStorage().remove('user_data');
    final navigationController = Get.put(CustomNavigationNController());
    navigationController.current_index.value = 0;
    Get.to(LoginScreen());
  }

  Future<void> check_in({
    required String room_number,
    required int hotel_id,
    required String departure_date,
  }) async {
    checkInLoading.value = false;
    try {
      var response = await Api.check_in(
        room_number: room_number,
        hotel_id: hotel_id,
        departure_date: departure_date,
      );
      print(GetStorage().read("user_token"));
      GetStorage().write('check_id_data', jsonEncode(response.data['data']));
      GetStorage().write('check_in_hotel', jsonEncode(response.data['hotel']));
      Get.snackbar('Message', 'Check In Success!!');
      Get.to(MainScree());
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          Get.snackbar('Message', e.response!.data['message']);
        } else {
          Get.snackbar('Message', e.response!.data['message']);
        }
      }
    }

    checkInLoading.value = true;
  }

  Future<void> get_user_data() async {
    try {
      var response = await Api.get_user_data();
      // user.value = UserModel.fromJson(response.data['user']);
      GetStorage().write('user_data', jsonEncode(response.data['user']));
    } on DioException catch (e) {
      //
    }
  }
}
