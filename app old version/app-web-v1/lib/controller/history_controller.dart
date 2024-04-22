import 'dart:developer';

import 'package:tucana/model/history_model.dart';
import 'package:tucana/response/history_response.dart';
import 'package:tucana/services/api.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var orderingHistory = <OrderingHistory>[].obs;
  var orderingProductHistory = <GuestOrderProduct>[].obs;
  var diningHistory = <HistoryDining>[].obs;
  var activityHistory = <HistoryActivity>[].obs;
  var orderingHistoryLoaded = false.obs;
  var diningHistoryLoaded = false.obs;
  var activityHistoryLoaded = false.obs;
  var orderProductLoaded = false.obs;

  Future<void> getOrderHistory({required String h_id}) async {
    orderingHistoryLoaded.value = false;

    var response = await Api.getOrderHistory(h_id: h_id);

    var orderResponse = HistoryOrderResponse.fromJson(response.data);

    orderingHistory.clear();

    orderingHistory.addAll(orderResponse.orderingHistory);

    orderingHistoryLoaded.value = true;
  }

  Future<void> getOrderProducts({required String order_id}) async {
    var response = await Api.getOrderProductHistory(order_id: order_id);

    var orderProductResponse =
        HistoryOrderProductResponse.fromJson(response.data);

    orderingProductHistory.clear();

    orderingProductHistory.addAll(orderProductResponse.guestOrderProduct);

    orderProductLoaded.value = true;
  }

  Future<void> getDiningHistory({required String h_id}) async {
    diningHistoryLoaded.value = false;

    var response = await Api.getDiningHistory(h_id: h_id);

    var diningResponse = HistoryDiningResponse.fromJson(response.data);

    diningHistory.clear();

    diningHistory.addAll(diningResponse.historyDining);

    diningHistoryLoaded.value = true;
  }

  Future<void> getActivityHistory({required String h_id}) async {
    activityHistoryLoaded.value = false;

    var response = await Api.getActivityHistory(h_id: h_id);

    var activityResponse = HistoryActivityResponse.fromJson(response.data);

    activityHistory.clear();

    activityHistory.addAll(activityResponse.historyActivity);

    activityHistoryLoaded.value = true;
  }
}
