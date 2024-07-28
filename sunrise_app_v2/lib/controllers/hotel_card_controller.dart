import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/hotel_cards_model.dart';
import 'package:sunrise_app_v2/response/hotel_card_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class HotelCardController extends GetxController {
  var card = <HotelCard>[].obs;
  var card_loaded = false.obs;
  var sub_cards = <HotelCard>[].obs;
  var sub_card_loaded = false.obs;

  Future<void> getCards({required int hotel_id, required int type_id}) async {
    var response =
        await Api.get_hotel_card(hotel_id: hotel_id, type_id: type_id);
    card.clear();
    var cardResponse = HotelCardResponse.fromJson(response.data);
    card.addAll(cardResponse.cards);
    card_loaded.value = true;
  }

  Future<void> getSubCard({
    required int hotel_id,
    required int type_id,
    int? master_id,
  }) async {
    sub_card_loaded.value = false;

    var response = await Api.get_hotel_card(
      hotel_id: hotel_id,
      type_id: type_id,
      master_id: master_id,
    );
    sub_cards.clear();
    var cardResponse = HotelCardResponse.fromJson(response.data);
    sub_cards.addAll(cardResponse.cards);
    sub_card_loaded.value = true;
  }
}
