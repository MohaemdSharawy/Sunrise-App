import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/models/hotel_room_model.dart';
import 'package:sunrise_app_v2/response/hotel_rooms_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class HotelRoomController extends GetxController {
  var rooms = <HotelRoom>[].obs;
  var room_loaded = false.obs;
  var room = HotelRoom().obs;
  var single_room_load = false.obs;

  Future<void> getHotelRooms({required int hotel_id}) async {
    room_loaded.value = false;
    var response = await Api.get_rooms(hotel_id: hotel_id);
    print(response.data);
    rooms.clear();
    var roomsResponse = HotelRoomsResponse.fromJson(response.data);
    rooms.addAll(roomsResponse.rooms);
    room_loaded.value = true;
  }

  Future<void> getRoomByType(
      {required int hotel_id, required String type}) async {
    room_loaded.value = false;
    var response = await Api.get_rooms_by_type(hotel_id: hotel_id, type: type);
  }

  Future<void> getRoom({required int room_id}) async {
    single_room_load.value = false;
    var response = await Api.get_room(room_id: room_id);
    room.value = HotelRoom.fromJson(response.data['room']);
    single_room_load.value = true;
  }

  List roomGalleryHandel() {
    List room_galley = [];
    room.value.gallery.map(
      (element) => room_galley
          .add('${AppUrl.main_domain}/uploads/hotel_gallery/${element}'),
    );
    return room_galley;
  }
}
