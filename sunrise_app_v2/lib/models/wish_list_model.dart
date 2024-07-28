import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/screens/hotel_book_home.dart';

class WishListModel {
  late int id;

  late String type;

  late String code;

  Map wish_date = {};

  WishListModel.fromJson(json) {
    id = json['id'];

    type = json['type'];

    code = json['wished_code'];

    if (json['type'] == 'hotel') {
      wish_date.addAll(
        {
          'name': json['wish']['hotel_name'],
          'image':
              '${AppUrl.main_domain}/uploads/hotels/${json['wish']['hotel_image']}',
          'action': () {
            Get.to(HotelHomeBookingScreen(hotel_id: json['wish']['id']));
          }
        },
      );
    }
  }
}
