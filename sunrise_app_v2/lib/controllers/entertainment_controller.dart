import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/entertainment_model.dart';
import 'package:sunrise_app_v2/response/entertainment_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class EntertainmentController extends GetxController {
  var entertainment_loaded = false.obs;
  var entertainment = <EntertainmentModel>[].obs;

  Future<void> getEntertainment(
      {required int hotel_id, required String day}) async {
    entertainment_loaded.value = false;
    var response = await Api.get_entertainment(hotel_id: hotel_id, day: day);
    entertainment.clear();
    var entertainmentResponse = EntertainmentResponse.fromJson(response.data);
    entertainment.addAll(entertainmentResponse.entertainments);
    entertainment_loaded.value = true;
  }
}
