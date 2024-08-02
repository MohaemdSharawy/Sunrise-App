import 'package:sunrise_app_v2/models/brand_model.dart';
import 'package:sunrise_app_v2/models/destinations_model.dart';

class Hotels {
  late int id;

  late String hotel_name;

  late String hotel_code;

  late String hotel_image;

  late String hotel_logo;

  late String hotel_logo_white;

  late String about_hotel;

  // late int group_id;

  // late int brand_id;

  // late Brands brands;

  late Destinations group;

  late String? whatsapp;

  Hotels();

  Hotels.fromJson(json) {
    id = json['id'];

    hotel_name = json['hotel_name'];

    hotel_code = json['hotel_code'];

    hotel_image = json['hotel_image'];

    hotel_logo = json['hotel_logo'];

    hotel_logo_white = json['hotel_logo_white'];

    about_hotel = json['about_hotel'] ?? '';

    whatsapp = json['whats_app'];

    group = Destinations.fromJson(json['group']);
  }
}
