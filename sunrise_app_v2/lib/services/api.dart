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

class Api extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.main_domain + 'api/',
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
        // var token = await GetStorage().read('login_token');

        var headers = {
          'Accept': 'application/json',
          'Content-Type': "application/json",
          'Access-Control-Allow-Origin': '*',
          "Access-Control-Allow-Credentials": true,
          "Authorization":
              // 'Bearer 12|LInJfawiET6GF7rGld25myZ0XY01jmjqdqGeLiGz20c22a77'
              'Bearer ${GetStorage().read('user_token')}'
          // 'Access-Control-Allow-Headers': 'X-Requested-With,content-type'
          // 'Authorization': 'Bearer ${token}',
          // 'api-header-key':
          //     'KRRwnLbblDsmwEVFemgToplxd1BWq3MovJBnzTy2Gd4BwAquzOmZyn2nf2nzVmxw'
        };

        // var params = {
        //   "apikey": "751c45cae60a2839711a94c8d6bf0089e78b2149ca602fd",
        // };
        // request.queryParameters.addAll(params);

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

        // GET.Get.snackbar(
        //   'error'.tr,
        //   '${error}',
        //   // 'Some Thing  Went Wrong!',
        //   // 'Something Wrong Happened Please Try Again!!',
        //   snackPosition: GET.SnackPosition.BOTTOM,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> login(
      {required String email, required String password}) async {
    Map<String, String> data = {'email': email, 'password': password};
    print('Payload  ${data}');
    return dio.post('guest/login', data: data);
  }

  static Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    Map payload = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    };
    return dio.post('guest/register', data: payload);
  }

  static Future<Response> logout() async {
    return dio.post('guest/logout');
  }

  static Future<Response> get_user_data() async {
    return dio.post('guest/get_user_data');
  }

  static Future<Response> destinations() async {
    return dio.get('destinations');
  }

  static Future<Response> brands() async {
    return dio.get('brands');
  }

  static Future<Response> hotel_destination(
      {required int destination_id}) async {
    return dio.get('destination/hotel/${destination_id}');
  }

  static Future<Response> hotel_list() async {
    return dio.get('hotels');
  }

  static Future<Response> hotel_view({required int hotel_id}) async {
    return dio.get('hotels/show/${hotel_id}');
  }

  static Future<Response> hotel_brand({required int brand_id}) async {
    return dio.get('hotels/brand/${brand_id}');
  }

  static Future<Response> get_sliders({
    required int hotel_id,
    required String type_name,
  }) async {
    return dio.post(
      'slider',
      data: {
        'hotel_id': hotel_id,
        'type_name': type_name,
      },
    );
  }

  static Future<Response> get_hotel_includes({required int hotel_id}) async {
    return dio.get('hotels/includes/${hotel_id}');
  }

  static Future<Response> get_hotel_facilities({required int hotel_id}) async {
    return dio.get('facilities/${hotel_id}');
  }

  static Future<Response> get_facility({required int facility_id}) async {
    return dio.get('facilities/show/${facility_id}');
  }

  static Future<Response> get_hotel_card(
      {required int hotel_id, required int type_id, int? master_id}) async {
    String pass = '';
    (master_id == null)
        ? pass = 'hotels/card/${hotel_id}/${type_id}'
        : pass = 'hotels/card/${hotel_id}/${type_id}/${master_id}';
    return dio.get(pass);
  }

  static Future<Response> get_home_offers() {
    return dio.get('offers/offer_home');
  }

  static Future<Response> get_all_offers() {
    return dio.get('offers/all_offers');
  }

  static Future<Response> get_hotel_offers({required int hotel_id}) {
    return dio.get('offers/hotel_offer/${hotel_id}');
  }

  static Future<Response> get_hotel_info({required int hotel_id}) {
    return dio.get('hotels/info/${hotel_id}');
  }

  static Future<Response> get_hotel_city_guide({required int hotel_id}) {
    return dio.get('hotels/city_guide/${hotel_id}');
  }

  static Future<Response> get_hotel_ids_mapping({required int hotel_id}) {
    return dio.get('hotels/hotel_id_mapping/${hotel_id}');
  }

  static Future<Response> get_entertainment(
      {required int hotel_id, required String day}) async {
    return dio.post('hotels/entertainment_day/${hotel_id}', data: {'day': day});
  }

  static Future<Response> get_rooms({required int hotel_id}) {
    return dio.get('rooms/${hotel_id}');
  }

  static Future<Response> get_room({required int room_id}) {
    return dio.get('rooms/show/${room_id}');
  }

  static Future<Response> get_rooms_by_type(
      {required int hotel_id, required String type}) {
    return dio.get('rooms/show/filter/type/${hotel_id}');
  }

  static Future<Response> check_in({
    required String room_number,
    required int hotel_id,
    required String departure_date,
  }) async {
    Map payload = {
      'room_num': room_number,
      'hotel_id': hotel_id,
      'departure': departure_date
    };
    print(payload);
    return dio.post('guest/check_in', data: payload);
  }

  static Future<Response> get_hotel_gallery({required int hotel_id}) {
    return dio.get('hotels/gallery/${hotel_id}');
  }

  static Future<Response> get_wish_list({String? type}) {
    Map data = {'type': type};
    return dio.post('guest/wish_list', data: data);
  }

  static Future<Response> add_wish_list({required Map data}) {
    return dio.post('guest/add_wish_list', data: data);
  }

  static Future<Response> remove_wish_list({required int wish_id}) {
    return dio.post('guest/remove_wish_list/${wish_id}');
  }
} //end of api
