import 'package:sunrise_app_v2/models/destinations_model.dart';

class DestinationsResponse {
  List<Destinations> destinations = [];
  DestinationsResponse.fromJson(json) {
    json['destinations']
        .forEach((data) => destinations.add(Destinations.fromJson(data)));
  }
}
