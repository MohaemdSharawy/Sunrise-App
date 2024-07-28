class Restaurant {
  late int id;

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

  late String dish_day_img;

  late String dish_day;

  late String white_logo;

  late String shisha;

  late String bar;
  late String ordering;
  late String survey;

  late String book_today;

  late String hide_price;

  Restaurant();

  Restaurant.fromJson(json) {
    id = int.parse(json['id']);

    code = json['code'] ?? '';

    hid = json['hid'] ?? '';

    restaurant_name = json['restaurant_name'] ?? '';

    description = json['description'] ?? '';

    address = json['address'] ?? '';

    lat_long = json['lat_long'] ?? '';

    phone = json['phone'] ?? '';

    average_prepare_time = json['average_prepare_time'] ?? '';

    currency = json['currency'] ?? '';

    extra_charge = json['extra_charge'] ?? '';

    tax = json['tax'] ?? '';

    payment_info = json['payment_info'] ?? '';

    logo = json['logo'] ?? '';

    image = json['image'] ?? '';

    pdf_menu = json['pdf_menu'] ?? '';

    type = json['type'] ?? '';

    active = json['active'] ?? '';

    room_service = json['room_service'] ?? '';

    booking = json['booking'] ?? '';

    enable_course = json['enable_course'] ?? '';

    mobile_theme = json['mobile_theme'] ?? '';

    timestamp = json['timestamp'] ?? '';

    hotel_code = json['hotel_code'] ?? '';

    dish_day_img = json['dish_day_img'] ?? '';

    dish_day = json['dish_day'] ?? '';

    white_logo = json['white_logo'] ?? '';

    bar = json['bar'] ?? '';

    shisha = json['shisha'] ?? '';

    ordering = json['ordering'] ?? '';
    survey = json['survey'] ?? '';
    book_today = json['book_today'] ?? '';

    hide_price = json['hide_price'] ?? '';
  }
}
