import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/models/hotel_includes_model.dart';
import 'package:sunrise_app_v2/models/hotel_mapping_id.dart';
import 'package:sunrise_app_v2/models/hotel_model.dart';
import 'package:sunrise_app_v2/response/hotel_includes_response.dart';
import 'package:sunrise_app_v2/response/hotel_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class HotelController extends GetxController {
  var hotel_loaded = false.obs;
  var hotels = <Hotels>[].obs;
  var sliders = [].obs;
  var slider_loaded = false.obs;
  var single_hotel_load = false.obs;
  var hotel_ids_mapping = HotelIdsMapping().obs;
  var hotel_mapping_id_loaded = false.obs;
  var hotel = Hotels().obs;
  var hotel_includes = <HotelIncludes>[].obs;
  var hotel_includes_loaded = false.obs;
  var load_gallery = false.obs;
  var gallery = [].obs;

  Future<void> getHotels({int? destination_id}) async {
    if (destination_id == null) {
      await getAllHotels();
    } else {
      await getDestinationsHotels(destination_id: destination_id);
    }
  }

  Future<void> getDestinationsHotels({required int destination_id}) async {
    hotel_loaded.value = false;
    var response = await Api.hotel_destination(destination_id: destination_id);
    hotels.clear();
    var hotelResponse = HotelDestinationResponse.fromJson(response.data);
    hotels.addAll(hotelResponse.hotels);
    hotel_loaded.value = true;
  }

  Future<void> getAllHotels() async {
    hotel_loaded.value = false;
    var response = await Api.hotel_list();
    hotels.clear();
    var hotelResponse = HotelsResponse.fromJson(response.data);
    hotels.addAll(hotelResponse.hotels);
    hotel_loaded.value = true;
  }

  Future<void> hotel_view({required int hotel_id}) async {
    single_hotel_load.value = false;
    var response = await Api.hotel_view(hotel_id: hotel_id);
    hotel.value = Hotels.fromJson(response.data['hotels']);
    single_hotel_load.value = true;
  }

  Future<void> getSlider(
      {required String type_name, required int hotel_id}) async {
    slider_loaded.value = false;
    var response = await Api.get_sliders(
      hotel_id: hotel_id,
      type_name: type_name,
    );
    sliders.clear();
    response.data['sliders']
        .forEach((slid) => sliders.add(slid['image']['image']));
    slider_loaded.value = true;
  }

  Future<void> get_hotel_ids_mapping({required int hotel_id}) async {
    hotel_mapping_id_loaded.value = false;
    var response = await Api.get_hotel_ids_mapping(hotel_id: hotel_id);
    hotel_ids_mapping.value = HotelIdsMapping.fromJson(
      response.data['hotel_ids_mapping'],
    );
    hotel_mapping_id_loaded.value = true;
  }

  Future<void> get_hotel_includes({required int hotel_id}) async {
    hotel_includes_loaded.value = false;
    var response = await Api.get_hotel_includes(hotel_id: hotel_id);
    hotel_includes.clear();
    var includesResponse = HotelIncludesResponse.fromJson(response.data);
    hotel_includes.addAll(includesResponse.hotel_includes);
    hotel_includes_loaded.value = true;
  }

  Future<void> get_gallery({required int hotel_id}) async {
    load_gallery.value = false;
    var response = await Api.get_hotel_gallery(hotel_id: hotel_id);
    response.data['gallery'].forEach(
      (element) => gallery.add(
        "${AppUrl.main_domain}uploads/hotel_gallery/${element['image']}",
      ),
    );
    load_gallery.value = true;
  }
}
