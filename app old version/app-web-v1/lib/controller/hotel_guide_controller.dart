import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tucana/model/hotel_guide/city_guide_model.dart';
import 'package:tucana/model/hotel_guide/entertainment_model.dart';
import 'package:tucana/model/hotel_guide/hotel_info_model.dart';
import 'package:tucana/model/hotel_guide/hotel_map_model.dart';
import 'package:tucana/model/hotel_guide/tv_guide_model.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/response/hotel_guide_response.dart';
import 'package:tucana/response/hotel_response.dart';
import 'package:tucana/services/api.dart';
import 'package:tucana/services/hotel_guide_api.dart';

import '../model/hotel_guide/posh_club_model.dart';

class HotelGuideController extends GetxController {
  var hotel_info = <HotelInfo>[].obs;
  var info_loaded = false.obs;
  var hotel_map = <HotelMap>[].obs;
  var map_loaded = false.obs;
  var city_guide = <CityGuide>[].obs;
  var city_loaded = false.obs;
  var tv_guide = <TvGuide>[].obs;
  var tv_loaded = false.obs;
  var entertainment = <Entertainment>[].obs;
  var entertainment_load = false.obs;
  var city_guide_pdf = ''.obs;
  var posh_club_slider = <PoshClubSlider>[].obs;
  var posh_club = <PoshClub>[].obs;
  var posh_club_logo = PoshClubLogo().obs;
  var posh_club_loaded = false.obs;
  var hotel_service = <HotelService>[].obs;

  Future<void> getHotelInfo({required int h_id}) async {
    hotel_info.clear();
    try {
      var response = await HotelGuideApi.getHotelInfo(h_id: h_id);
      var service_response = await HotelGuideApi.get_hotel_services(h_id: h_id);
      var infoResponse = HotelInfoResponse.fromJson(response.data);
      var hotelServiceResponse =
          HotelServiceResponse.fromJson(service_response.data);
      hotel_info.addAll(infoResponse.hotel_info);
      hotel_service.addAll(hotelServiceResponse.hotel_service);
    } on DioError catch (e) {
      //
    }
    // info_loaded.value = true;
  }

  Future<void> getHotelMap({required int h_id}) async {
    hotel_map.clear();
    try {
      var response = await HotelGuideApi.getHotelMap(h_id: h_id);
      var mapResponse = HotelMapResponse.fromJson(response.data);
      hotel_map.addAll(mapResponse.hotel_map);
    } on DioError catch (e) {
      //
    }
    map_loaded.value = true;
  }

  Future<void> getCityGuid({required int h_id}) async {
    city_guide.clear();
    try {
      var response = await HotelGuideApi.getCityGuid(h_id: h_id);
      var cityResponse = CityGuideResponse.fromJson(response.data);
      city_guide.addAll(cityResponse.city_guide);
    } on DioError catch (e) {
//
    }

    city_loaded.value = true;
  }

  Future<void> getTvGuid({required int h_id}) async {
    tv_guide.clear();
    try {
      var response = await HotelGuideApi.getTvGuide(h_id: h_id);
      var tv_response = TvGuideResponse.fromJson(response.data);
      tv_guide.addAll(tv_response.tv_guide);
    } on DioError catch (e) {
//
    }

    tv_loaded.value = true;
  }

  Future<void> getEntertainment({
    required int h_id,
    required int day_id,
  }) async {
    entertainment.clear();
    try {
      var response = await HotelGuideApi.getEntertainment(
        h_id: h_id,
        day_id: day_id,
      );
      var entertainment_response =
          EntertainmentResponse.fromJson(response.data);
      entertainment.addAll(entertainment_response.entertainment);
    } on DioError catch (e) {
      //
    }
    entertainment_load.value = true;
  }

  Future<void> getCityGuidePdf({required int h_id}) async {
    city_guide_pdf.value = '';
    try {
      var response = await HotelGuideApi.getCityGuidePdf(h_id: h_id);
      print(response.data['name_pdf']);
      city_guide_pdf.value = response.data['name_pdf'];
    } on DioError catch (e) {
      //
    }
    // info_loaded.value = true;
  }

  Future<void> getPoshClub({required int hotel_id}) async {
    posh_club_loaded.value = false;
    posh_club.clear();
    posh_club_slider.clear();
    try {
      var response = await HotelGuideApi.getPoshClub(h_id: hotel_id);
      posh_club_logo.value = PoshClubLogo.fromJson(response.data['logo']);
      var sliders = PoshClubSliderResponse.fromJson(response.data);
      var infos = PoshClubResponse.fromJson(response.data);
      posh_club.addAll(infos.posh_club);
      posh_club_slider.addAll(sliders.posh_club_slider);
    } on DioError catch (e) {
//
    }

    posh_club_loaded.value = true;
  }
}
