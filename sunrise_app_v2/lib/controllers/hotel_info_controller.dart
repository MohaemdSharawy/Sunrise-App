import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/hotel_info_model.dart';
import 'package:sunrise_app_v2/response/hotel_info_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class HotelInfoController extends GetxController {
  var hotel_info_loaded = false.obs;
  var info = <HotelInfo>[].obs;
  var city_guide_loaded = false.obs;
  var city = <HotelInfo>[].obs;

  Future<void> getHotelInfo({required int hotel_id}) async {
    hotel_info_loaded.value = false;
    var response = await Api.get_hotel_info(hotel_id: hotel_id);
    info.clear();
    var offerResponse = HotelInfoResponse.fromJson(response.data);
    info.addAll(offerResponse.hotel_infos);
    hotel_info_loaded.value = true;
  }

  Future<void> getHotelCityGuide({required int hotel_id}) async {
    city_guide_loaded.value = false;
    var response = await Api.get_hotel_city_guide(hotel_id: hotel_id);
    city.clear();
    var offerResponse = HotelInfoResponse.fromJson(response.data);
    city.addAll(offerResponse.hotel_infos);
    city_guide_loaded.value = true;
  }
}
