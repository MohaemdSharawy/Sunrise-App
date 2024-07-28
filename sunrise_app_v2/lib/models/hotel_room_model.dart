import 'package:sunrise_app_v2/models/hotel_includes_model.dart';

class HotelRoom {
  late int id;

  late String type;

  late String room_name;

  late String image;

  late int price;

  late int num_beds;

  late int num_adults;

  late String bed_type;

  late String room_view;

  late bool posh_club;

  late String desorption;

  List gallery = [];

  List<RoomIncludes> includes = [];

  HotelRoom();

  HotelRoom.fromJson(json) {
    id = json['id'];

    type = json['type'];

    room_name = json['room_name'];

    image = json['image'];

    price = json['price'];

    num_beds = json['num_beds'];

    num_adults = json['num_adults'];

    bed_type = json['bed']['bed_name'];

    room_view = json['room_view']['type_name'];

    desorption = json['desorption'] ?? '';

    json['includes']
        .forEach((data) => includes.add(RoomIncludes.fromJson(data)));

    posh_club = (json['posh_club'] == 1) ? true : false;

    json['gallery'].forEach((data) => gallery.add(data['image']['image']));
  }
}

class RoomIncludes {
  late int id;

  late int room_id;

  late String name;

  late String icon;

  RoomIncludes.fromJson(json) {
    id = json['id'];

    room_id = json['room_id'];

    name = json['includes']['name'];

    icon = json['includes']['icon'];
  }
}
