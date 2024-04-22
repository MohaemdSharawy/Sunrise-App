import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/services/api.dart';
import 'package:http/http.dart' as http;

class OutSideAuthController extends GetxController with BaseController {
  Future<void> out_side_login({
    required String employee_code,
    required String h_id,
    required BuildContext context,
    bool redirect_login = true,
  }) async {
    // var response = await Api.outSideLogin(
    //   employee_code: employee_code,
    //   h_id: h_id,
    // );

    Map<String, dynamic> postData = {'code': employee_code};

    await sendPost(
        postData,
        'https://yourcart.sunrise-resorts.com/clients/api/app_login/${h_id}',
        employee_code,
        h_id,
        context,
        redirect_login);
  }
}

void setValues(employee_code, body, h_id) {
  var pms_birthday = '2030-12-31';
  var departure = '2030-12-31';
  var pms_lang = 'en';
  var full_name = body['user']['name'];
  var pax = 1;
  var title = 'MR/MRS';
  var confirmation = '00';
  var arrival = '2020-12-31';
  var firstname = body['user']['name'];
  var lastname = body['user']['name'];
  var phone = "0";
  var country = body['country'];
  var restaurant_code = body['user']['restaurant_code'] ?? "COBF";
  var category_type_id = body['user']['category_type_id'] ?? "3205";
  var email = '0';
  GetStorage().write('room_num', employee_code);
  GetStorage().write('departure', departure);
  GetStorage().write('birthday', pms_birthday);
  GetStorage().write('h_id', h_id);
  GetStorage().write('full_name', full_name);
  GetStorage().write('title', title);
  GetStorage().write('confirmation', confirmation);
  GetStorage().write('pax', pax);
  GetStorage().write('arrival', arrival);
  GetStorage().write('firstname', firstname);
  GetStorage().write('lastname', lastname);
  GetStorage().write('phonenumber', phone);
  GetStorage().write('country', country);
  GetStorage().write('email', email);
  GetStorage().write('restaurant_code_employee', restaurant_code);
  GetStorage().write('category_type_id_employee', category_type_id);
}

Future sendPost(
  Map<String, dynamic> data,
  url,
  employee_code,
  h_id,
  context,
  redirect_login,
) async {
  http.Client client = new http.Client();
  final String encodedData = json.encode(data);

  try {
    final response = await client.post(
      Uri.parse(url), //your address here
      body: encodedData,
    );
    switch (response.statusCode) {
      case 200:
        setValues(employee_code, json.decode(response.body), h_id);
        if (redirect_login) {
           var restaurant_code = GetStorage().read('restaurant_code_employee');
           var category_type_id = GetStorage().read('category_type_id_employee');
           
          // Navigator.pushNamed(context, '/restaurant/${h_id}');
          // Navigator.pushNamed(context, 'restaurant_category_by_type/COBF/3205');
          Navigator.pushNamed(context, 'restaurant_category_by_type/${restaurant_code}/${category_type_id}');
        }
        return '';
      default:
        Get.snackbar(
          'Message',
          'Code is Not Correct',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
