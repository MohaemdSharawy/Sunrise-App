import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class Api extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
        baseUrl: 'https://yourcart.sunrise-resorts.com/clients/api/',
        receiveDataWhenStatusError: true,
        headers: {
          // "Content-Type": "multipart/form-data,multipart/form-data",
          // "Access-Control-Allow-Origin": "*",
          // 'Accept': 'application/json',
          // 'Content-Type': "multipart/form-data,multipart/form-data",
          // 'Access-Control-Allow-Origin': '*',
          // 'Access-Control-Allow-Methods':
          //     'GET, POST, OPTIONS, PUT, PATCH, DELETE',
          // "Access-Control-Allow-Credentials": true,
        }),
  );

  static void initializeInterceptors() {
    if (!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    // BrowserHttpClientAdapter   bca = new BrowserHttpClientAdapter();
    // bca.withCredentials = true;
    // dio.httpClientAdapter = bca;

    dio.interceptors.add(InterceptorsWrapper(
      // onRequest: (request, handler) async {
      //   // var token = await GetStorage().read('login_token');

      //   var headers = {
      //     'Accept': 'application/json',
      //     'Content-Type': "multipart/form-data,multipart/form-data",
      //     'Access-Control-Allow-Origin': '*',
      //     'Access-Control-Allow-Methods':
      //         'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      //     "Access-Control-Allow-Credentials": true,
      //     // 'Access-Control-Allow-Headers': 'X-Requested-With,content-type'
      //     // 'Authorization': 'Bearer ${token}',
      //     // 'api-header-key':
      //     //     'KRRwnLbblDsmwEVFemgToplxd1BWq3MovJBnzTy2Gd4BwAquzOmZyn2nf2nzVmxw'
      //   };

      //   // var params = {
      //   //   "apikey": "751c45cae60a2839711a94c8d6bf0089e78b2149ca602fd",
      //   // };
      //   // request.queryParameters.addAll(params);

      //   request.headers.addAll(headers);
      //   // print('${request.method} ${request.path}');
      //   // print('${request.headers}');
      //   return handler.next(request); //continue
      // },
      onResponse: (response, handler) {
        // print('${response.data}');

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        if (GET.Get.isDialogOpen == true) {
          GET.Get.back();
        }

        GET.Get.snackbar(
          'error'.tr,
          'Some Thing Wrong Happened',
          // 'Something Wrong Happened Please Try Again!!',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static var lang = GetStorage().read('lang');

  static Future<Response> getHotels() async {
    return dio.get('get_hotels');
  }

  static Future<Response> applogin(
      {required Map<String, dynamic> loginData}) async {
    var data = {
      'username': loginData['username'],
      'password': loginData['password'],
      'device_uiid': GetStorage().read('fcm_token')
    };
    return dio.post('applogin', data: data);

    // var data_get = await dio.post('applogin', data: data);
    // return data_get;
    // Response resposne = await post('applogin, {data : data}');
  }

  static Future<Response> hotelResturan({required int hotel_id}) async {
    return dio.get('getHotelRestaurants/${hotel_id}');
  }

  static Future<Response> workingDay({required int restaurant_id}) async {
    return dio.get('RestaurantWorkingDays/${restaurant_id}');
  }

  static Future<Response> interfaces({
    required int hotel_id,
    required String interface_type,
  }) async {
    return dio.get('get_hotel_interface/${hotel_id}/${interface_type}');
  }

  static Future<Response> restaurantCategories(
      {required String restaurant_code, String? type}) {
    return dio.get('get_categories/${restaurant_code}/${lang}/${type}');
  }

  static Future<Response> getProduct({required int category_id}) {
    return dio.get('get_category_products/${category_id}/${lang}');
  }

  static Future<Response> bookRestaurant({
    required int restaurant_id,
    required int hotel_id,
    required String room_no,
    required int pax,
    required String date,
    required String time,
  }) async {
    var postData = {
      'booking_restaurant': restaurant_id,
      'booking_hotel': hotel_id,
      'booking_room': room_no,
      'booking_pax': pax,
      'booking_date': date,
      'booking_time': time,
      'booking_id': ''
    };
    var formData = FormData.fromMap(postData);

    return dio.post('post_booking', data: formData);
  }

  static Future<Response> getRestaurantTable({required int restaurant_id}) {
    return dio.get('get_restaurant_tables/${restaurant_id}');
  }

  static Future<Response> getHotelActivity({required String hotel_code}) {
    return dio.get('get_hotel_activities/${hotel_code}');
  }

  static Future<Response> get_activity_categories(
      {required String spa_code}) async {
    return dio.get('get_activity_categories/${spa_code}/${lang}');
  }

  static Future<Response> get_activity_category_products(
      {required int category_id}) async {
    return dio.get('get_activity_category_products/${category_id}/${lang}');
  }

  static Future<Response> bookSpa({
    required int restaurant_id,
    required int product_id,
    required int hotel_id,
    required String room_no,
    required int pax,
    required String date,
    required String time,
  }) async {
    var postData = {
      'booking_hotel': hotel_id.toString(),
      'booking_restaurant': restaurant_id.toString(),
      'booking_product': product_id.toString(),
      'booking_room': room_no,
      'booking_pax': pax,
      'booking_date': date,
      'booking_time': time,
      'booking_guset': null,
      'booking_birth_date': '1999-07-25',
      'booking_id': ''
    };
    var formData = FormData.fromMap(postData);

    return dio.post('post_spa_booking', data: formData);
  }

  static Future<Response> bookOrder({
    required int restaurant_id,
    required String room_no,
    required int table,
    required double total_price,
    required List products,
  }) async {
    var postData = {
      'room': 100000,
      'table': table,
      'total_price': total_price,
      'order_id': '',
      'restaurant_id': '',
      'products': products
    };
    var formData = FormData.fromMap(postData);
    return dio.post('post_order/${restaurant_id}', data: formData);
  }

  static Future<Response> questionsRate() async {
    return dio.get('get_rateUs_Q/${lang}');
  }

  static Future<Response> postRate({
    required int hotel_id,
    required String room_num,
    required List answers,
  }) async {
    var postData = {
      'hid': hotel_id,
      'room': room_num,
      'answers': answers,
    };
    var formData = FormData.fromMap(postData);

    return dio.post('post_rateUs', data: formData);
  }

  static Future<Response> getRoomService({required int h_id}) async {
    return dio.get('get_room_service/${h_id}');
  }

  static Future<Response> getShisha({required int h_id}) async {
    return dio.get('get_shisha/${h_id}');
  }

  static Future<Response> getMineBar({required int h_id}) async {
    return dio.get('get_mini_bar/${h_id}');
  }

  static Future<Response> get_activity_category_product(
      {required int product_id}) async {
    return dio.get('get_activity_category_product/${product_id}/${lang}');
  }

  static Future<Response> get_single_product({required int product_id}) {
    return dio.get('get_category_product/${product_id}/${lang}');
  }

  static Future<Response> getBars({required int hotel_id}) {
    return dio.get('getHotelBars/${hotel_id}');
  }

  static Future<Response> getBackGround({
    required var search_key,
    String? api_type,
  }) {
    return dio.get('hotels_img_background/${search_key}/${api_type}');
  }

  static Future<Response> restaurant_open_by_day({
    required String restaurant_code,
    required String day,
  }) {
    return dio.get('restaurant_working_time_by_day/${restaurant_code}/${day}');
  }

  static Future<Response> getHotelGym({required String hotel_code}) {
    return dio.get('getHotelGym/${hotel_code}');
  }

  static Future<Response> getDiningCategoryType({required restaurant_code}) {
    return dio.get('get_category_types/${restaurant_code}');
  }

  static Future<Response> workingTimeByDay({
    required String restaurant_id,
    required String day_name,
    String? date,
    String? meal_id
  }) {
    return dio
        .get('RestaurantWorkingDaysByDay/${restaurant_id}/${day_name}/${date}/${meal_id}');
  }

  static Future<Response> getHotel({
    required String key,
    String? type = 'id',
  }) async {
    return dio.get('getHotel/${key}/${type}');
  }

  static Future<Response> getOrderHistory({required String h_id}) async {
    var confirmation = GetStorage().read('confirmation');
    return dio.get('guest_orders/${h_id}/${confirmation}');
  }

  static Future<Response> getOrderProductHistory({
    required String order_id,
  }) async {
    return dio.get('guest_order_product/${order_id}');
  }

  static Future<Response> getDiningHistory({required String h_id}) async {
    var confirmation = GetStorage().read('confirmation');

    return dio.get('guestRestaurantBooking/${h_id}/${confirmation}');
  }

  static Future<Response> getActivityHistory({required String h_id}) async {
    var confirmation = GetStorage().read('confirmation');
    return dio.get('guest_booking_activity/${h_id}/${confirmation}');
  }

  static Future<Response> get_restaurant_by_code({
    required String restaurant_code,
  }) async {
    return dio.get(
      'get_restaurant_by_code/${restaurant_code}',
    );
  }

  static Future<Response> product_custom({
    required String product_id,
  }) async {
    return dio.get(
      'product_custom_option/${product_id}',
    );
  }

  static Future<Response> get_meal({required String restaurant_code}) async {
    return dio.get('get_main_categories/${restaurant_code}');
  }

  static Future<Response> meal_category({
    required String restaurant_code,
    required String type_id,
    required String meal_id,
    required String day,
  }) async {
    return dio.get(
        'get_categories/${restaurant_code}/${lang}/${type_id}/${meal_id}/${day}');
  }

  static Future<Response> meal_product({
    required String category_id,
    required String meal_id,
    required String day,
  }) async {
    return dio
        .get('get_category_products/${category_id}/${lang}/${meal_id}/${day}');
  }

  static Future<Response> get_booking_types() async {
    String lang = GetStorage().read('lang');
    return dio.get('booking_type/${lang}');
  }

  static Future<Response> get_allergies() async {
    return dio.get('get_allergies');
  }

  static Future<Response> get_general_posh_club() async {
    return dio.get('get_posh_club/${lang}');
  }

  static Future<Response> get_art_of_foods() async {
    return dio.get('art_of_foods/${lang}');
  }

  static Future<Response> get_art_of_food(
      {required String art_of_food_id}) async {
    return dio.get('art_of_food/${art_of_food_id}');
  }

  static Future<Response> outSideLogin({
    required String employee_code,
    required String h_id,
  }) async {
    Map<String, dynamic> data = {'code': employee_code};
    return dio.post('app_login/${h_id}', data: data);
  }


  static Future<Response> get_booking_meals({required String h_id}) async{
    return dio.get('get_meals/${h_id}');
  }


} //end of api
