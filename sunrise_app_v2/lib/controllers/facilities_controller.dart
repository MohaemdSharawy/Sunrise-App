import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/facilities_model.dart';
import 'package:sunrise_app_v2/response/facilities_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class Facilities_controller extends GetxController {
  var facilities_load = false.obs;
  var facility_load = false.obs;
  var facilities = <HotelFacilities>[].obs;
  var facility = HotelFacilities().obs;

  Future<void> getHotelFacilities({required int hotel_id}) async {
    facilities_load.value = true;
    var response = await Api.get_hotel_facilities(hotel_id: hotel_id);
    facilities.clear();
    var facilities_response = FacilityResponse.fromJson(response.data);
    facilities.addAll(facilities_response.facilities);
    facilities_load.value = true;
  }

  Future<void> viewFacility({required int facility_id}) async {
    facility_load.value = false;
    var response = await Api.get_facility(facility_id: facility_id);
    facility.value = HotelFacilities.fromJson(response.data['facility']);
    facility_load.value = true;
  }
}
