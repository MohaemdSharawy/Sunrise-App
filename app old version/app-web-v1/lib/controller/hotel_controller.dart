import 'dart:convert';

import 'package:get/get.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/model/posh_club_general.dart';
import 'package:tucana/response/posh_club_general_response.dart';
import 'package:tucana/response/hotel_response.dart';
import 'package:tucana/services/api.dart';

class HotelsController extends GetxController {
  var hotels = <Hotels>[].obs;
  var cruises = <Hotels>[].obs;
  var resorts = <Hotels>[].obs;
  var hotel = Hotels().obs;
  var hotel_loaded = false.obs;
  var isloaded = false.obs;
  // var selectHotel = 0.obs;
  var back_ground = <BackGroundImg>[].obs;
  var backGroundLoaded = false.obs;
  var screen_img = ''.obs;

  //General PoshClub
  var posh_club_general = <PoshClubGeneralModel>[].obs;
  var posh_club_hotels = <PoshClubHotels>[].obs;
  var posh_club_general_loaded = false.obs;
  // var posh_club_general_logo = PoshClubGeneralLogo().obs;
  // var posh_club_general_slider = <PoshClubGeneralSliderModel>[].obs;
  Future<void> guestHotel() async {
    var response = await Api.getHotels();
    var hotelsResponse = HotelsResponse.guestFromJson(response.data);
    hotels.clear();
    resorts.clear();
    cruises.clear();
    hotels.addAll(hotelsResponse.hotels);
    resorts.addAll(hotelsResponse.resorts);
    cruises.addAll(hotelsResponse.cruises);
    isloaded.value = true;
  }

  Future<void> getBackGround({
    required search_key,
    String? api_type,
    String? screen_type,
  }) async {
    var response = await Api.getBackGround(
      search_key: search_key,
      api_type: api_type,
    );
    var backGroundResponse = BackGroundResponse.fromJson(response.data);
    back_ground.clear();
    back_ground.addAll(backGroundResponse.backgroundImg);
    // print(back_ground[0].dining_screen);
    // var body  = jsonDecode(response.data);

    switch (screen_type) {
      case "login_screen":
        screen_img.value = back_ground[0].login_screen;
        break;
      case "home_screen":
        screen_img.value = back_ground[0].home_screen;
        break;
      case "weather_screen":
        screen_img.value = back_ground[0].weather_screen;
        break;
      case "dining_screen":
        screen_img.value = back_ground[0].dining_screen;
        break;
      case "wellness_screen":
        screen_img.value = back_ground[0].wellness_screen;
        break;
      case "rate_screen":
        screen_img.value = back_ground[0].rate_screen;
        break;
      default:
        screen_img.value = back_ground[0].home_screen;
    }

    // print(back_ground);
    backGroundLoaded.value = true;
  }

  Future<void> getHotel({required hid}) async {
    hotel_loaded.value = false;
    var response = await Api.getHotel(key: hid);
    hotel.value = Hotels.fromJson(response.data['hotel']);
    hotel_loaded.value = true;
  }

  Future<void> getPoshClubGeneral() async {
    posh_club_general_loaded.value = false;
    var response = await Api.get_general_posh_club();
    var posh_club_general_response =
        PoshClubGeneralResponse.fromJson(response.data);

    var posh_club_hotels_response =
        PoshClubHotelsResponse.fromJson(response.data);
    posh_club_general.clear();
    posh_club_general.addAll(posh_club_general_response.posh_club);
    posh_club_hotels.clear();
    posh_club_hotels.addAll(posh_club_hotels_response.posh_club_hotels);
    posh_club_general_loaded.value = true;
  }
}
