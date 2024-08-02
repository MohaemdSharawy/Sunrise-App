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

class LetUsKnowApi extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.letUsKnow + 'api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() async {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        // var token = await GetStorage().read('login_token');

        var headers = {
          'Accept': 'application/json',
          'Content-Type': "application/json",
          'Access-Control-Allow-Origin': '*',
          "Access-Control-Allow-Credentials": true,
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

  static Future<Response> getDate({required String hotel_code}) async {
    return dio.get('get_data/${hotel_code}');
  }

  static Future<Response> postDate({
    required String name,
    required String phone,
    required String email,
    required String priority_id,
    required String room_num,
    required String dep_id,
    required String hotel_code,
    required String description,
  }) async {
    var postData = {
      'name': name,
      'phone': phone,
      'email': email,
      'priority_id': priority_id,
      'room_num': room_num,
      'dep_id': dep_id,
      'hotel_code': hotel_code,
      'description': description
    };

    print(postData);
    return dio.post('store', data: postData);
  }

  static Future<Response> get_hotel({required int hotel_id}) async {
    return dio.get('get_hotel/${hotel_id}');
  }
} //end of api
