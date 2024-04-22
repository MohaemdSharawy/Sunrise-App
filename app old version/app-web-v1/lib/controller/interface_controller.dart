import 'package:get/get.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/response/hotel_response.dart';
import 'package:tucana/services/api.dart';

class InterfaceController extends GetxController {
  var booking = ''.obs;
  var bookingLoaded = false.obs;
  var interfaceVal = ''.obs;
  var hotel = <Hotels>[].obs;
  var hotelLoaded = false.obs;
  var isbookingLoaded = false.obs;
  var have_video = false.obs;
  Future<void> bookingInterface({
    required int hotel_id,
  }) async {
    var response =
        await Api.interfaces(hotel_id: hotel_id, interface_type: 'BOOK');
    booking.value = response.data['interface'];

    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();

    hotel.addAll(hotelResponse.hotel);

    isbookingLoaded.value = true;
  }

  Future<void> getInterface({
    required int hotel_id,
    required String interfaceType,
  }) async {
    var response =
        await Api.interfaces(hotel_id: hotel_id, interface_type: interfaceType);
    interfaceVal.value = response.data['interface'];

    bookingLoaded.value = true;
  }

  Future<void> getHotel({required hotel_id}) async {
    var hotel_api = await Api.hotelResturan(hotel_id: hotel_id);

    var hotelResponse = HotelResponse.fromJson(hotel_api.data);

    hotel.clear();

    hotel.addAll(hotelResponse.hotel);

    hotelLoaded.value = true;
  }
}
