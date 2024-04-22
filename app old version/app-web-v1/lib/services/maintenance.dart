import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class MaintenancesApi extends HttpOverrides {
  static final dio = Dio(
    BaseOptions(
        baseUrl: 'https://tickets.sunrise-resorts.com/api/',
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

  static var lang = GetStorage().read('lang');

  static Future<Response> getDepartment() async {
    return dio.get('service_category/${lang}');
  }

  static Future<Response> getServices({String department_id = ''}) async {
    return dio.get('guests_service/${lang}/${department_id}');
  }

  static Future<Response> getAllServices() async {
    return dio.get('guests_service/${lang}');
  }

  static Future<Response> guestRequest({required String hid}) async {
    String room_num = GetStorage().read('room_num');
    String conf_num = GetStorage().read('confirmation');
    return dio.get('guest_ticket/${hid}/${room_num}/${conf_num}/${lang}');
  }

  static Future<Response> confirmTicket({required int ticket_id}) async {
    String room_num = GetStorage().read('room_num');
    String conf_num = GetStorage().read('confirmation');
    return dio.get('ticket_confirm/${ticket_id}');
  }

  static Future<Response> reopenTicket({required int ticket_id}) async {
    String room_num = GetStorage().read('room_num');
    String conf_num = GetStorage().read('confirmation');
    return dio.get('ticket_reopen/${ticket_id}');
  }
} //end of api
