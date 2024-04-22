import 'package:tucana/model/history_model.dart';

class HistoryOrderResponse {
  List<OrderingHistory> orderingHistory = [];

  HistoryOrderResponse.fromJson(json) {
    // print(json);
    if (json != null) {
      json['orders'].forEach(
          (data) => orderingHistory.add(OrderingHistory.fromJson(data)));
    }
  }
}

class HistoryOrderProductResponse {
  List<GuestOrderProduct> guestOrderProduct = [];

  HistoryOrderProductResponse.fromJson(json) {
    if (json != null) {
      json['order_products'].forEach(
          (data) => guestOrderProduct.add(GuestOrderProduct.fromJson(data)));
    }
  }
}

class HistoryDiningResponse {
  List<HistoryDining> historyDining = [];

  HistoryDiningResponse.fromJson(json) {
    // print(json);
    if (json != null) {
      json['restaurant_booking']
          .forEach((data) => historyDining.add(HistoryDining.fromJson(data)));
    }
  }
}

class HistoryActivityResponse {
  List<HistoryActivity> historyActivity = [];

  HistoryActivityResponse.fromJson(json) {
    // print(json);
    if (json != null) {
      json['restaurant_booking'].forEach(
          (data) => historyActivity.add(HistoryActivity.fromJson(data)));
    }
  }
}
