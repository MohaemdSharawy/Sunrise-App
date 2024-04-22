import 'dart:convert';

import '../model/hotel_model.dart';

class HotelsResponse {
  List<Hotels> hotels = [];
  List<Hotels> resorts = [];
  List<Hotels> cruises = [];

  HotelsResponse.guestFromJson(Map<String, dynamic> json) {
    json['hotels'].forEach((data) => (data['company_id'] != "2")
        ? resorts.add(Hotels.fromJson(data))
        : cruises.add(Hotels.fromJson(data)));
    json['hotels'].forEach((data) => hotels.add(Hotels.fromJson(data)));
  }
}

class HotelResponse {
  List<Hotels> hotel = [];
  HotelResponse.fromJson(json) {
    hotel.add(Hotels.fromJson(json['hotel']));
  }
}

class BackGroundResponse {
  List<BackGroundImg> backgroundImg = [];
  BackGroundResponse.fromJson(json) {
    json['images']
        .forEach((data) => backgroundImg.add(BackGroundImg.fromJson(data)));
  }
}
