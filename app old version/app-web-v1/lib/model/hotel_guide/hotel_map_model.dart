class HotelInfo {
  late String id;

  late String hid;

  late String info;

  late String description;

  HotelInfo.fromJson(json) {
    id = json['id'];

    hid = json['hid'];

    info = (json['info'] != null) ? json['info'] : '';

    description = (json['description'] != null) ? json['description'] : '';
  }
}

class HotelService {
  late int id;

  late int hid;

  late String name;

  late String icon;

  HotelService.fromJson(json) {
    id = json['id'];
    hid = json['hid'];
    name = (json['name'] != null) ? json['name'] : '';
    icon = (json['icon'] != null) ? json['icon'] : '';
  }
}
