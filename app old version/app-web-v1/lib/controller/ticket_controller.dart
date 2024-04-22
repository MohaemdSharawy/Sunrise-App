import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/model/ticket/department_service_model.dart';
import 'package:tucana/model/ticket/service_model.dart';
import 'package:tucana/model/ticket/ticket_model.dart';
import 'package:tucana/response/ticket_response.dart';
import 'package:tucana/services/maintenance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:html' as htmls;

class TicketController extends GetxController with BaseController {
  var services = <Services>[].obs;
  var services_loaded = false.obs;
  var department_service = <DepartmentService>[].obs;
  var department_service_loaded = false.obs;
  var tickets = <Ticket>[].obs;
  var tickets_loaded = false.obs;

  Future<void> getDepartmentService() async {
    var response = await MaintenancesApi.getDepartment();
    var departmentServiceResponse =
        DepartmentServiceResponse.fromJson(response.data);
    department_service.clear();
    department_service.addAll(departmentServiceResponse.department_service);
    getServices();
    department_service_loaded.value = true;
  }

  Future<void> getServices({String department_id = '0'}) async {
    var response =
        await MaintenancesApi.getServices(department_id: department_id);
    var serviceResponse = ServiceResponse.fromJson(response.data);
    services.clear();
    services.addAll(serviceResponse.services);
    services_loaded.value = true;
  }

  Future sendPost(Map<String, dynamic> data, url) async {
    http.Client client = new http.Client();
    final String encodedData = json.encode(data);
    print(encodedData);
    try {
      final response = await client.post(
        Uri.parse(url), //your address here
        body: encodedData,
        headers: {
          "security-code": "tGGLLxRIKBR1dhdEavkUWQ6Fwd3G9inQZHz5hm2U",
          "content-type": "application/json"
        },
      );
      switch (response.statusCode) {
        case 200:
          return Get.snackbar(
            'Message',
            'Order Done Successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception catch (_) {
      Get.snackbar(
        'Message',
        'Something Wrong happened',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // rethrow;
    }
  }

  Future<void> makeRequest({
    required String hid,
    String? service_id,
    required String description,
  }) async {
    Map<String, dynamic> postData = {
      'hid': hid,
      'service_id': service_id,
      'description': description,
      'guest_name': GetStorage().read('full_name'),
      'conf_num': GetStorage().read('confirmation'),
      'room_num': GetStorage().read('room_num')
    };

    await sendPost(
        postData, 'https://tickets.sunrise-resorts.com/api/ticket/create');
  }

  Future<void> myPreviousRequest({required String hid}) async {
    var response = await MaintenancesApi.guestRequest(hid: hid);
    var ticketsResponse = TicketResponse.fromJson(response.data);
    tickets.clear();
    tickets.addAll(ticketsResponse.tickets);
    tickets_loaded.value = true;
  }

  Future<void> changeTicketStatus({
    required String action,
    required int ticket_id,
  }) async {
    if (action == 'confirm') {
      await MaintenancesApi.confirmTicket(ticket_id: ticket_id);
    }
    if (action == 'reopen') {
      await MaintenancesApi.reopenTicket(ticket_id: ticket_id);
    }
    htmls.window.location.reload();
  }
}
