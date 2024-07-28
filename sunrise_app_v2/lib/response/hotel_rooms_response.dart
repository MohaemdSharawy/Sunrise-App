import 'package:sunrise_app_v2/models/hotel_room_model.dart';

class HotelRoomsResponse{
  List<HotelRoom>  rooms = [];
   HotelRoomsResponse.fromJson(json) {
    json['rooms'].forEach((data) => rooms.add(HotelRoom.fromJson(data)));
  }

}