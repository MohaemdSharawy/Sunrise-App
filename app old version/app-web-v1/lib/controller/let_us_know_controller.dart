import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/model/let_us_know_model.dart';
import 'package:tucana/response/let_us_know_response.dart';
import 'package:tucana/services/let_us_know.dart';

class LetUsKnowController extends GetxController {
  //var interface = <Interface>[].obs;

  var isLoaded = false.obs;
  var let_us_know_hotel = LetUsKnowHotels().obs;
  var country_codes = <CountryCodes>[].obs;
  var priorities = <Priorities>[].obs;
  var let_us_know_departments = <LetUsKnowDepartment>[].obs;

  Future<void> getData({
    required String hotel_code,
  }) async {
    isLoaded.value = false;

    var response = await LetUsKnowApi.getDate(hotel_code: hotel_code);

    // var hotels = LetUsKnowHotelsResponse.fromJson(response.data);
    var codes = CountryCodesResponse.fromJson(response.data);
    var priority = PrioritiesResponse.fromJson(response.data);
    var department = LetUsKnowDepartmentResponse.fromJson(response.data);
    //
    country_codes.clear();
    priorities.clear();
    let_us_know_departments.clear();
    //
    let_us_know_hotel.value = LetUsKnowHotels.fromJson(response.data['hotel']);

    country_codes.addAll(codes.countryCodes);
    priorities.addAll(priority.priorities);
    let_us_know_departments.addAll(department.departments);

    isLoaded.value = true;
  }

  Future<void> postData({
    required String name,
    required String phone,
    required String email,
    required String priority_id,
    required String room_num,
    required String dep_id,
    required String hotel_code,
    required String description,
  }) async {
    try {
      var response = await LetUsKnowApi.postDate(
        name: name,
        phone: phone,
        email: email,
        priority_id: priority_id,
        room_num: room_num,
        dep_id: dep_id,
        hotel_code: hotel_code,
        description: description,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Message',
          'Done',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Message',
          'Booking Failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (e is DioError) {
        Get.snackbar(
          'Message',
          'Some Thing Wrong Happened'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
