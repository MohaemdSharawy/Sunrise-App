// ignore: file_names
class Spa {
  late String id;

  late String code;

  late String uid;

  late String hid;

  late String restaurant_name;

  late String description;

  late String address;

  late String lat_long;

  late String phone;

  late String average_prepare_time;

  late String currency;

  late String extra_charge;

  late String tax;

  late String payment_info;

  late String logo;

  late String image;

  late String pdf_menu;

  late String type;

  late String active;

  late String room_service;

  late String booking;

  late String enable_course;

  late String mobile_theme;

  // late String deleted;

  late String timestamp;

  late String hotel_code;

  Spa.fromJson(json) {
    id = json['id'];

    code = (json['code'] != null) ? json['code'] : '';

    uid = (json['uid'] != null) ? json['uid'] : '';

    hid = (json['hid'] != null) ? json['hid'] : '';

    restaurant_name =
        (json['restaurant_name'] != null) ? json['restaurant_name'] : '';

    description = (json['description'] != null) ? json['description'] : '';

    address = (json['address'] != null) ? json['address'] : '';

    lat_long = (json['lat_long'] != null) ? json['lat_long'] : '';

    phone = (json['phone'] != null) ? json['phone'] : '';

    average_prepare_time = (json['average_prepare_time'] != null)
        ? json['average_prepare_time']
        : '';

    currency = (json['currency'] != null) ? json['currency'] : '';

    extra_charge = (json['extra_charge'] != null) ? json['extra_charge'] : '';

    tax = (json['tax'] != null) ? json['tax'] : '';

    payment_info = (json['payment_info'] != null) ? json['payment_info'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';

    image = (json['image'] != null) ? json['image'] : '';

    pdf_menu = (json['pdf_menu'] != null) ? json['pdf_menu'] : '';

    type = (json['type'] != null) ? json['type'] : '';

    active = (json['active'] != null) ? json['active'] : '';

    room_service = (json['room_service'] != null) ? json['room_service'] : '';

    booking = (json['booking'] != null) ? json['booking'] : '';

    enable_course =
        (json['enable_course'] != null) ? json['enable_course'] : '';

    mobile_theme = (json['mobile_theme'] != null) ? json['mobile_theme'] : '';

    timestamp = (json['timestamp'] != null) ? json['timestamp'] : '';

    hotel_code = (json['hotel_code'] != null) ? json['hotel_code'] : '';
  }
}

class SpaCategories {
  late String id;

  late String category_name;

  late String code;

  late String printer_id;

  late String rank;

  late String logo;

  late String image;

  late String description;

  late String active;

  SpaCategories.fromJson(json) {
    id = json['id'];

    category_name =
        (json['category_name'] != null) ? json['category_name'] : '';

    code = (json['code'] != null) ? json['code'] : '';

    printer_id = (json['printer_id'] != null) ? json['printer_id'] : '';

    rank = (json['rank'] != null) ? json['rank'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';

    image = (json['image'] != null) ? json['image'] : '';

    description = (json['description'] != null) ? json['description'] : '';

    active = (json['active'] != null) ? json['active'] : '';
  }
}

class SpaProduct {
  late String id;

  late String restaurant_id;

  late String category_id;

  late String product_name;

  late String description;

  late String size;

  late String time;

  late String price;

  late String brand_id;

  late String unit_id;

  late String barcode;

  late String q_limit;

  late String min_price;

  late String hot;

  late String logo;

  late String enable_working_days;

  late String active;

  SpaProduct.fromJson(json) {
    id = json['id'];

    restaurant_id =
        (json['restaurant_id'] != null) ? json['restaurant_id'] : '';

    category_id = (json['category_id'] != null) ? json['category_id'] : '';

    product_name = (json['product_name'] != null) ? json['product_name'] : '';

    description = (json['description'] != null) ? json['description'] : '';

    size = (json['size'] != null) ? json['size'] : '';

    time = (json['time'] != null) ? json['time'] : '';

    price = (json['price'] != null) ? json['price'] : '';

    brand_id = (json['brand_id'] != null) ? json['brand_id'] : '';

    unit_id = (json['unit_id'] != null) ? json['unit_id'] : '';

    barcode = (json['barcode'] != null) ? json['barcode'] : '';

    q_limit = (json['q_limit'] != null) ? json['q_limit'] : '';

    min_price = (json['min_price'] != null) ? json['min_price'] : '';

    hot = (json['hot'] != null) ? json['hot'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';

    enable_working_days = (json['enable_working_days'] != null)
        ? json['enable_working_days']
        : '';

    active = (json['active'] != null) ? json['active'] : '';
  }
}
