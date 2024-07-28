import 'package:sunrise_app_v2/models/offer_model.dart';

class OffersResponse {
  List<Offers> offers = [];
  OffersResponse.fromJson(json) {
    json['offers'].forEach((data) => offers.add(Offers.fromJson(data)));
  }
}
