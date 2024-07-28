import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/offer_model.dart';
import 'package:sunrise_app_v2/response/offer_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class OffersController extends GetxController {
  var offers_loaded = false.obs;
  var offers = <Offers>[].obs;

  Future<void> getHomeOffers() async {
    offers_loaded.value = false;
    var response = await Api.get_home_offers();
    offers.clear();
    var offerResponse = OffersResponse.fromJson(response.data);
    offers.addAll(offerResponse.offers);
    offers_loaded.value = true;
  }

  Future<void> getHotelOffers({required int hotel_id}) async {
    offers_loaded.value = false;
    var response = await Api.get_hotel_offers(hotel_id: hotel_id);
    offers.clear();
    var offerResponse = OffersResponse.fromJson(response.data);
    offers.addAll(offerResponse.offers);
    offers_loaded.value = true;
  }

  Future<void> getAllOffers() async {
    offers_loaded.value = false;
    var response = await Api.get_all_offers();
    offers.clear();
    var offerResponse = OffersResponse.fromJson(response.data);
    offers.addAll(offerResponse.offers);
    offers_loaded.value = true;
  }
}
