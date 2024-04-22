import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class SurveyApi extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://surveys.sunrise-resorts.com/api/',
      receiveDataWhenStatusError: true,
      // headers: {
      //   // 'Accept': 'application/json',
      //   'Access-Control-Allow-Origin': '*',
      //   'Access-Control-Allow-Headers': '*',
      //   'authtoken':
      //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiQ1JNIiwibmFtZSI6IkNSTSIsInBhc3N3b3JkIjpudWxsLCJBUElfVElNRSI6MTU5NDM4NTQ1OX0.AwiaqClDd8qVsddxLBQi_naM2bobOHFPjXDJRNY7S7U',
      // },
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

  static Future<Response> get_questions({
    required String hotel_token,
    required String restaurant_id,
  }) {
    late String lang;
    if (GetStorage().read('lang') != null && GetStorage().read('lang') != '') {
      lang = GetStorage().read('lang');
    } else {
      lang = 'en';
    }
    return dio
        .get('restaurant/question/${hotel_token}/${restaurant_id}/${lang}');
  }

  static Future<Response> get_nps({
    required String hotel_token,
  }) {
    late String lang;
    if (GetStorage().read('lang') != null && GetStorage().read('lang') != '') {
      lang = GetStorage().read('lang');
    } else {
      lang = 'en';
    }
    return dio.get('restaurant/nps/${hotel_token}/${lang}');
  }

  static Future<Response> check_nps({
    required String survey_token,
  }) {
    String confirmation = GetStorage().read('confirmation');
    return dio.get('restaurant/check_nps/${survey_token}/${confirmation}');
  }
} //end of api