import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/hotel_info_model.dart';
import 'package:sunrise_app_v2/models/hotel_model.dart';
import 'package:sunrise_app_v2/response/hotel_response.dart';
import 'package:sunrise_app_v2/response/posh_club_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class PoshClubController extends GetxController {
  var posh_club = <HotelInfo>[];
  var posh_club_hotels = <Hotels>[];
  var isLoaded = false.obs;

  Future<void> get_general_posh_club() async {
    isLoaded.value = false;
    var response = await Api.get_general_posh_club();
    var poshClubResponse = PoshClubResponse.fromJson(response.data);
    var hotelResponse = HotelsResponse.fromJson(response.data);
    posh_club.clear();
    posh_club.addAll(poshClubResponse.posh_club);
    posh_club_hotels.clear();
    posh_club_hotels.addAll(hotelResponse.hotels);
    isLoaded.value = true;
  }

  Future<void> get_hotel_posh_club({required int hotel_id}) async {
    isLoaded.value = false;
    var response = await Api.get_hotel_posh_club(hotel_id: hotel_id);
    var poshClubResponse = PoshClubResponse.fromJson(response.data);
    posh_club.clear();
    posh_club.addAll(poshClubResponse.posh_club);
    isLoaded.value = true;
  }
}
