class HotelMap {
  late String id;

  late String name;

  HotelMap.fromJson(json) {
    id = json['id'];

    name = (json['name'] != null) ? json['name'] : '';
  }
}
