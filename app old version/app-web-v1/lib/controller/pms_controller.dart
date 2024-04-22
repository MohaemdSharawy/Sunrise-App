import 'dart:convert';
import 'dart:io';
import 'dart:js';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/const/app_constant.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:tucana/screens/main_screen.dart';
import 'dart:html' as htmls;

class PmsController extends GetxController with BaseController {
  var isLogin = false.obs;
  // final dio = Dio();
  Future login({
    required String hotel_id,
    required String room_no,
    required BuildContext context,
    required String birthday,
    String? login_type,
  }) async {
    if (hotel_id != '19') {
      print('updated');
      GetStorage().write('lang_loaded', "false");
      isLogin.value = false;
      // print(isLogin.value);
      showLoading();

      String hotel = map_hotel(hotel_id);

      // print('Old Hotel Id ${hotel_id}');
      // print('Old New Hotel ${hotel}');

      var url = Uri.parse(
          "https://pms.sunrise-resorts.com:3000/reservations/get-reservation-by-room/?hotel=${hotel}&room=${room_no}");
      // try {
      //Dio
      // var response = await dio.get(
      //   "https://pms.sunrise-resorts.com:8080/reservations/get-reservation-by-room/?hotel=${hotel}&room=${room_no}",
      // );

      //Http
      const Map<String, String> _JSON_HEADERS = {
        "content-type": "application/json",
        // "Content-Type": "multipart/form-data,multipart/form-data",
        "Access-Control-Allow-Headers":
            "Content-Type, Authorization, X-Requested-With",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
        "Access-Control-Max-Age": "3600",
        "authorization":
            "Bearer d8e6b1636e779dcbb2f60bd027dbe53c7430743bee289cb93f77f40b7abff379"
      };
      http.Client client = new http.Client();
      var response = await client.get(
        url,
        headers: _JSON_HEADERS,
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        var pms_birthday = body['birthdate'].split("T");
        var departure = body['departure'].split("T");
        var pms_lang = body['lang'];
        var full_name = body['firstname'] + ' ' + body['lastname'];
        var pax = body['adult'] + body['child'];
        var title = body['title'];
        var confirmation = body['reservation_no'].toString();
        var arrival = body['arrival'];
        var firstname = body['firstname'];
        var lastname = body['lastname'];
        var phone = body['phonenumber'];
        var country = body['country'];
        var email = body['email'];
        hideLoading();
        ////Chnage Lange
        update_lang(context, pms_lang);

        print(departure[0]);
        print(birthday);
        if (birthday == departure[0]) {
          // if (birthday.toLowerCase() == body['lastname'].toLowerCase()) {
          print('ccccc');
          GetStorage().write('room_num', room_no);
          GetStorage().write('departure', departure[0]);
          GetStorage().write('birthday', pms_birthday[0]);
          GetStorage().write('h_id', hotel_id);
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

          //CHECK FOR DEPARTURE

          // ignore: use_build_context_synchronously
          if (isNotDeparture()) {
            //LOGIN FROM MY ORDER SCREEN
            if (login_type == 'ordering' || login_type == 'restaurant_survey') {
              //LOGIN FROM LOGIN SCREEN
            } else {
              Navigator.pushNamed(context, '/home/${hotel_id}');
            }
          } else {
            Get.snackbar(
              'Message',
              tr('failed auth'),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }

          //FAILED LOGIN  (lAST NAME NOT MATCH WITH ROOM NUMBER)
        } else {
          Get.snackbar(
            'Message',
            tr('failed auth'),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        /// FAilD TO Connect To pms
      } else {
        hideLoading();

        Get.snackbar(
          'Message',
          tr('failed auth'),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      //KWANZA Login

      DateTime date = DateTime.parse(birthday);
      String day = date.day.toString().padLeft(2, '0');
      String month = date.month.toString().padLeft(2, '0');

      print('Day: $day');
      print('Month: $month');
      var url = Uri.parse(
          "https://apis.obifi.io/api/v1/feed/sunrise?client_key=5uOK7KZkwkq2mFToxWbV65Bnm8a3OqD3&client_secret=D722B4FD8F98287D55B377A2E81AB&tenant=panel&property_id=506&room_number=${room_no}&departure_day=${day}&departure_month=${month}");

      http.Client client = new http.Client();
      var response = await client.post(
        url,
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['success'] == true) {
          // ignore: use_build_context_synchronously
          login_confirmation(
              hotel_id: map_hotel(hotel_id),
              confirmation_no: body['data']['confirmation_id'].toString(),
              context: context);
        } else {
          Get.snackbar(
            'Message',
            tr('failed auth'),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Message',
          tr('failed auth'),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    //End KWANZA Login
  }

  void update_lang(BuildContext context, pms_lang) {
    // ignore: deprecated_member_use
    context.locale = map_lang(pms_lang);
    // context.setLocale(pms_lang);
    // EasyLocalization.of(context)?.setLocale(pms_lang);

    GetStorage().write(
      'lang',
      context.locale.toString(),
    );
  }

  map_lang(pms_lang) {
    switch (pms_lang) {
      case "en":
        return AppConstant.EN_LOCAL;
      case "ar":
        return AppConstant.AR_LOCAL;
      case "ru":
        return AppConstant.RU_LOCAL;
      case "it":
        return AppConstant.IT_LOCAL;
      case "fr":
        return AppConstant.FR_LOCAL;
      case "du":
        return AppConstant.DU_LOCAL;
      case "de":
        return AppConstant.GR_LOCAL;
      case "ro":
        return AppConstant.RO_LOCAL;
      case "pl":
        return AppConstant.PL_LOCAL;
      case "cz":
        return AppConstant.CZ_LOCAL;
      case "ua":
        return AppConstant.UA_LOCAL;
      default:
        return AppConstant.EN_LOCAL;
    }
  }

  String map_hotel(hotel_id) {
    switch (hotel_id) {
      case "1":
        return '5';
      case "2":
        return '7';
      case "3":
        return '3';
      case "4":
        return '2';
      case "5":
        return '6';
      case "6":
        return '4';
      case "7":
        return '1';
      case "8":
        return '9';
      case "9":
        return '10';
      case "10":
        return '19';
      case "11":
        return '20';
      case "12":
        return '22';
      case "13":
        return '23';
      case "14":
        return '24';
      case "15":
        return '25';
      case "16":
        return '26';
      case "17":
        return '21';
      case "19":
        return '27';
      case "20":
        return '28';
      case "21":
        return '15';
      case "22":
        return '16';
      case "23":
        return '18';
      case "24":
        return '17';
      case "25":
        return '13';
      case "26":
        return '29';
      case "27":
        return '14';
      case "28":
        return '12';

      ///Not work case 19
      default:
        return 'no Hotel Selected';
    }
  }

  String map_hotel_form_crm(hotel_id) {
    switch (hotel_id) {
      case "5":
        return '1';
      case "7":
        return '2';
      case "3":
        return '3';
      case "2":
        return '4';
      case "6":
        return '5';
      case "4":
        return '6';
      case "1":
        return '7';
      case "9":
        return '8';
      case "10":
        return '9';
      case "19":
        return '10';
      case "20":
        return '11';
      case "22":
        return '12';
      case "23":
        return '13';
      case "24":
        return '14';
      case "25":
        return '15';
      case "26":
        return '16';
      case "21":
        return '17';
      case "27":
        return '19';
      case "28":
        return '20';
      case "15":
        return '21';
      case "16":
        return '22';
      case "18":
        return '23';
      case "17":
        return '24';
      case "13":
        return '25';
      case "29":
        return '26';
      case "14":
        return '27';
      case "12":
        return '28';

      ///Not work case 19
      default:
        return 'no Hotel Selected';
    }
  }

  Future login_confirmation({
    required String hotel_id,
    required String confirmation_no,
    required BuildContext context,
  }) async {
    print('ssssssss');
    var hotel = map_hotel_form_crm(hotel_id);

    GetStorage().write('lang_loaded', "false");
    isLogin.value = false;
    // print(isLogin.value);
    // showLoading();
    var url = Uri.parse(
        "https://pms.sunrise-resorts.com:3000/reservations/get-reservation-confirm/?hotel=${hotel_id}&confirm=${confirmation_no}");

    const Map<String, String> _JSON_HEADERS = {
      "content-type": "application/json",
      // "Content-Type": "multipart/form-data,multipart/form-data",
      "Access-Control-Allow-Headers":
          "Content-Type, Authorization, X-Requested-With",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
      "Access-Control-Max-Age": "3600",
      "authorization":
          "Bearer d8e6b1636e779dcbb2f60bd027dbe53c7430743bee289cb93f77f40b7abff379"
    };
    http.Client client = new http.Client();
    var response = await client.get(
      url,
      headers: _JSON_HEADERS,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var pms_birthday = body['birthdate'].split("T");
      var departure = body['departure'].split("T");
      var pms_lang = body['lang'];
      var full_name = body['firstname'] + ' ' + body['lastname'];
      var pax = body['adult'] + body['child'];
      var title = body['title'];
      var confirmation = body['reservation_no'].toString();
      var arrival = body['arrival'];
      var firstname = body['firstname'];
      var lastname = body['lastname'];
      var phone = body['phonenumber'];
      var country = body['country'];
      var email = body['email'];
      var room_no = body['room_number'];
      // hideLoading();

      update_lang(context, pms_lang);
      print(confirmation_no);
      if (confirmation_no == body['reservation_no'].toString()) {
        print('data_success');
        GetStorage().write('room_num', room_no.toString());
        GetStorage().write('departure', departure[0]);
        GetStorage().write('birthday', pms_birthday[0]);
        GetStorage().write('h_id', hotel);
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

        //CHECK FOR DEPARTURE

        if (isNotDeparture()) {
          print('login_success');

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/home/${hotel}');
        } else {
          print('depature');

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/login/${hotel}');
          Get.snackbar(
            'Message',
            tr('failed auth'),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        //FAILED LOGIN  (lAST NAME NOT MATCH WITH ROOM NUMBER)
      } else {
        print('confirmation Not Match');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/login/${hotel}');
        Get.snackbar(
          'Message',
          tr('failed auth'),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      /// FAilD TO Connect To pms
    } else {
      print('fild Get data');
      // hideLoading();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login/${hotel}');
      Get.snackbar(
        'Message',
        tr('failed auth'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
