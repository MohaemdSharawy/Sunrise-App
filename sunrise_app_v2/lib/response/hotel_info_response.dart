import 'package:sunrise_app_v2/models/hotel_info_model.dart';

class HotelInfoResponse {
  List<HotelInfo> hotel_infos = [];
  HotelInfoResponse.fromJson(json) {
    json['infos'].forEach((data) => hotel_infos.add(HotelInfo.fromJson(data)));
  }
}
