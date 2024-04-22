class OrderingHistory {
  late String id;

  late String serial;

  late String restaurant_name;

  late String room_no;

  late String pax;

  late String guest_name;

  late String total_price;

  late String tax;

  late String extra_charge;

  late String discount;

  late String timestamp;

  OrderingHistory.fromJson(json) {
    id = json['id'];

    serial = json['serial'];

    restaurant_name = json['restaurant_name'];

    room_no = json['room_no'] ?? json['room_no'];

    pax = json['pax'] ?? json['pax'];

    guest_name = json['guest_name'] ?? json['guest_name'];

    total_price = json['total_price'] ?? json['total_price'];

    tax = json['tax'] ?? json['tax'];

    extra_charge = json['extra_charge'] ?? json['extra_charge'];

    discount = json['discount'] ?? json['discount'];

    timestamp = json['timestamp'] ?? json['timestamp'];
  }
}

class GuestOrderProduct {
  late String id;

  late String product_name;

  late String actual_price;

  late String logo;

  late String price;

  late String qty;

  late String notes;

  late String currency;

  GuestOrderProduct.fromJson(json) {
    id = json['id'] ?? json['id'];

    product_name = json['product_name'] ?? json['product_name'];

    actual_price = json['actual_price'] ?? json['actual_price'];

    logo = json['logo'] ?? json['logo'];

    price = json['price'] ?? json['price'];

    qty = json['qty'] ?? json['qty'];

    notes = json['notes'] ?? json['notes'];

    currency = json['currency'] ?? json['currency'];
  }
}

class HistoryDining {
  late String id;

  late String code;

  late String date;

  late String time;

  late String restaurant_name;

  late String pax;

  HistoryDining.fromJson(json) {
    id = json['id'];

    code = json['code'] ?? json['code'];

    date = json['date'] ?? json['date'];

    time = json['time'] ?? json['time'];

    restaurant_name = json['restaurant_name'] ?? json['restaurant_name'];

    pax = json['pax'] ?? json['pax'];
  }
}

class HistoryActivity {
  late String id;

  late String code;

  late String date;

  late String time;

  late String restaurant_name;

  late String pax;

  late String product_name;

  HistoryActivity.fromJson(json) {
    id = json['id'];

    code = json['code'] ?? json['code'];

    date = json['date'] ?? json['date'];

    time = json['time'] ?? json['time'];

    restaurant_name =
        (json['restaurant_name'] != null) ? json['restaurant_name'] : '';

    pax = json['pax'] ?? json['pax'];

    product_name = (json['product_name'] != null) ? json['product_name'] : '';
  }
}
