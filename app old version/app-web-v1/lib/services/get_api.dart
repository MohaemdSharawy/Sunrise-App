import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class Api_img extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsign.sunrise-resorts.com/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        // var token = await GetStorage().read('login_token');

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
        print('${request.method} ${request.path}');
        print('${request.headers}');
        return handler.next(request); //continue
      },
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

  static Future<Response> img() {
    return dio.get(
      'assets/signatures/9f3a8-mr.-hossam.jpg',
    );
  }
} //end of api
