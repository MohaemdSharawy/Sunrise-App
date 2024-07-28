import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/destinations_model.dart';
import 'package:sunrise_app_v2/response/destinations_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class DestinationController extends GetxController {
  var destination_loaded = false.obs;
  var destinations = <Destinations>[].obs;

  Future<void> getDestinations() async {
    destination_loaded.value = false;
    var response = await Api.destinations();
    destinations.clear();
    var destinationsResponse = DestinationsResponse.fromJson(response.data);
    destinations.addAll(destinationsResponse.destinations);
    destination_loaded.value = true;
  }
}
