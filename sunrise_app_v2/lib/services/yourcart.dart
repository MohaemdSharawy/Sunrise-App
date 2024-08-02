import 'dart:io';

// import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ApiYourCard extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.restaurant_domain + 'clients/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() async {
    // if (!kIsWeb) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (HttpClient client) {
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   };
    // }

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${token}',
          // 'api-header-key':
          //     'KRRwnLbblDsmwEVFemgToplxd1BWq3MovJBnzTy2Gd4BwAquzOmZyn2nf2nzVmxw'
        };

        var params = {
          "apikey": "751c45cae60a2839711a94c8d6bf0089e78b2149ca602fd",
        };
        request.queryParameters.addAll(params);

        request.headers.addAll(headers);
        // print('${request.method} ${request.path}');
        // print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        // print('${response.data}');

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        print(error);
        if (GET.Get.isDialogOpen == true) {
          GET.Get.back();
        }

        GET.Get.snackbar(
          'error'.tr,
          '${error}',
          // 'Some Thing  Went Wrong!',
          // 'Something Wrong Happened Please Try Again!!',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> hotelRestaurant({required int hotel_id}) async {
    // return dio.post('getHotelRestaurants/${hotel_id}');
    return dio.get('getHotelRestaurants/${hotel_id}');
  }

  static Future<Response> hotelGetRoomService({required int hotel_id}) async {
    return dio.get('get_room_service/${hotel_id}');
  }

  static Future<Response> getMiniBar({required int hotel_id}) async {
    return dio.get('get_mini_bar/${hotel_id}');
  }

  static Future<Response> getShisha({required int hotel_id}) async {
    return dio.get('get_shisha/${hotel_id}');
  }

  static Future<Response> getHotelBars({required int hotel_id}) async {
    return dio.post('getHotelBars/${hotel_id}');
  }

  static Future<Response> getProduct({
    required int category_id,
    String? language,
  }) {
    return dio.get('get_category_products/${category_id}/$language/');
  }

  static Future<Response> restaurantCategories({
    required String restaurant_code,
    String? language,
    String? type,
  }) {
    return dio.get('get_categories/${restaurant_code}/$language/$type');
  }

  static Future<Response> get_categories_with_product({
    required String restaurant_code,
    String? language,
    String? type,
  }) {
    if (type == null) {
      return dio
          .get('get_categories_with_product/${restaurant_code}/$language');
    } else {
      return dio.get(
          'get_categories_with_product/${restaurant_code}/$language/$type');
    }
  }

  static Future<Response> restaurantCategoriesTypes({
    required String restaurant_code,
  }) {
    return dio.get('get_category_types/${restaurant_code}');
  }

  static Future<Response> getRestaurantTable({required int restaurant_id}) {
    return dio.get('get_restaurant_tables/${restaurant_id}');
  }

  static Future<Response> product_custom({
    required String product_id,
  }) async {
    return dio.get(
      'product_custom_option/${product_id}',
    );
  }

  static Future<Response> get_wellness({required int hotel_code}) async {
    return dio.get('get_hotel_activities');
  }

  static Future<Response> getHotelActivity({required String hotel_code}) {
    return dio.get('get_hotel_activities/${hotel_code}');
  }

  static Future<Response> getHotelData({required int hotel_id}) {
    return dio.get('getHotel/${hotel_id}');
  }

  static Future<Response> get_activity_categories(
      {required String spa_code}) async {
    return dio.get('get_activity_categories/${spa_code}');
  }

  static Future<Response> bookOrder({
    required dynamic restaurant_id,
    required dynamic room_no,
    required int table,
    required dynamic total_price,
    required List products,
  }) async {
    var postData = {
      'room': room_no,
      'table': table,
      'total_price': total_price,
      'order_id': '',
      'restaurant_id': '',
      'products': products
    };
    var formData = FormData.fromMap(postData);
    return dio.post('post_order/${restaurant_id}', data: formData);
  }

  static Future<Response> restaurant_open_by_day({
    required String restaurant_code,
    required String day,
  }) {
    return dio.get('restaurant_working_time_by_day/${restaurant_code}/${day}');
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
        'get_categories/${restaurant_code}/en/${type_id}/${meal_id}/${day}');
  }

  static Future<Response> get_restaurant_by_code({
    required String restaurant_code,
  }) {
    return dio.get('get_restaurant_by_code/${restaurant_code}');
  }

  static Future<Response> workingDay({required int restaurant_id}) async {
    return dio.get('RestaurantWorkingDays/${restaurant_id}');
  }
} //end of api
