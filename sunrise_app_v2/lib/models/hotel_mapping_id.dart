class HotelIdsMapping {
  late int id;

  late int hotel_id;

  late int your_cart_hid;

  late int survey_hid;

  late int let_us_know_hid;

  late int ticket_hid;

  late int pms_hotel_id;

  HotelIdsMapping();

  HotelIdsMapping.fromJson(json) {
    id = json['id'];

    your_cart_hid = json['your_cart_hid'] ?? 0;

    survey_hid = json['survey_hid'] ?? 0;

    let_us_know_hid = json['let_us_know_hid'] ?? 0;

    ticket_hid = json['ticket_hid'] ?? 0;

    pms_hotel_id = json['pms_hotel_id'] ?? 0;
  }
}
