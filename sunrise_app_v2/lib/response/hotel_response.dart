import 'package:sunrise_app_v2/models/hotel_model.dart';

class HotelsResponse {
  List<Hotels> hotels = [];
  HotelsResponse.fromJson(json) {
    json['hotels'].forEach((data) => hotels.add(Hotels.fromJson(data)));
  }
}

class HotelDestinationResponse {
  List<Hotels> hotels = [];
  HotelDestinationResponse.fromJson(json) {
    json['destination']['hotels']
        .forEach((data) => hotels.add(Hotels.fromJson(data)));
  }
}
