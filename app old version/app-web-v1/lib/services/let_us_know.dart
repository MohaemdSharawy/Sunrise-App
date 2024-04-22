import 'dart:io';

import 'package:dio/adapter.dart';
// import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class LetUsKnowApi extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
        baseUrl: 'https://letusknow.sunrise-resorts.com/api/',
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
          '${error}',
          // 'Something Wrong Happened Please Try Again!!',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

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
    // var postData = {
    //   "name": "Hossam Hossam",
    //   "phone": "+201208024170",
    //   "email": "mohamed.sharawy@sunrise-resorts.com",
    //   "priority_id": "2",
    //   "room_num": "12345",
    //   "dep_id": "1",
    //   "hotel_code": "CB",
    //   "description": "Testest"
    // };
    print(postData);
    return dio.post('store', data: postData);
  }
} //end of api
