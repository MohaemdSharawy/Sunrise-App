import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class HotelGuideApi extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
        baseUrl: 'https://hotelguide.sunrise-resorts.com/api/',
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

  static Future<Response> getHotelInfo(
      {required int h_id, required int room_number}) async {
    return dio.get('hotel_info/${h_id}');
  }
} //end of api
