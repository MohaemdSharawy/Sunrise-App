import 'package:sunrise_app_v2/models/facilities_model.dart';

class FacilityResponse {
  List<HotelFacilities> facilities = [];
  FacilityResponse.fromJson(json) {
    json['facilities']
        .forEach((data) => facilities.add(HotelFacilities.fromJson(data)));
  }
}
