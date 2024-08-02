import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/let_us_know_model.dart';
import 'package:sunrise_app_v2/response/let_us_know_response.dart';
import 'package:sunrise_app_v2/services/letusKnow.dart';

class LetUsKnowController extends GetxController {
  var isLoaded = false.obs;
  var let_us_know_hotel = LetUsKnowHotels().obs;
  var country_codes = <CountryCodes>[].obs;
  var priorities = <Priorities>[].obs;
  var let_us_know_departments = <LetUsKnowDepartment>[].obs;
  var hotel_code = ''.obs;
  var submitting = true.obs;

  Future<void> get_hotel({required int let_us_know_hotel_id}) async {
    var response = await LetUsKnowApi.get_hotel(hotel_id: let_us_know_hotel_id);
    hotel_code.value = response.data['hotel']['code'];
  }

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
    submitting.value = false;
    try {
      // Map data = {
      //   'name': name,
      //   'phone': phone,
      //   'email': email,
      //   'priority_id': priority_id,
      //   'room_num': room_num,
      //   'dep_id': dep_id,
      //   'hotel_code': hotel_code,
      //   'description': description,
      // };
      // print(data);
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
        );
      } else {
        Get.snackbar(
          'Message',
          'Booking Failed',
        );
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data);
        Get.snackbar(
          'Message',
          'Some Thing Wrong Happened',
        );
      }
    }
    submitting.value = true;
  }
}
