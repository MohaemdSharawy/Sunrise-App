import 'package:sunrise_app_v2/models/hotel_cards_model.dart';

class HotelCardResponse {
  List<HotelCard> cards = [];
  HotelCardResponse.fromJson(json) {
    json['card'].forEach((data) => cards.add(HotelCard.fromJson(data)));
  }
}
