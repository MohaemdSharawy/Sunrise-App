import 'package:sunrise_app_v2/models/hotel_info_model.dart';

class PoshClubResponse {
  List<HotelInfo> posh_club = [];
  PoshClubResponse.fromJson(json) {
    json['data'].forEach((data) => posh_club.add(HotelInfo.fromJson(data)));
  }
}
