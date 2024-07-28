class HotelIncludes {
  late int id;

  late int hotel_id;

  late String name;

  late String icon;

  HotelIncludes.fromJson(json) {
    id = json['id'];

    hotel_id = json['hotel_id'];

    name = json['includes']['name'];

    icon = json['includes']['icon'];
  }
}
