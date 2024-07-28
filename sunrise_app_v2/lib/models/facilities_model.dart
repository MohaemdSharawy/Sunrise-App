import 'package:sunrise_app_v2/constant/app_urls.dart';

class HotelFacilities {
  late int id;

  late String name;

  late String image;

  late String description;

  List gallery = [];

  List<FacilityCard> cards = [];

  HotelFacilities();

  HotelFacilities.fromJson(json) {
    id = json['id'];

    name = json['name'];

    image = json['image'];

    description = json['description'];

    json['facility_image'].forEach(
      (e) => gallery.add(
        '${AppUrl.main_domain}/uploads/facilities/${e['image']}',
      ),
    );

    json['facility_card'].forEach((x) => cards.add(FacilityCard.fromJson(x)));
  }
}

class FacilityCard {
  late int id;

  late String title;

  late String desorption;

  FacilityCard.fromJson(json) {
    id = json['id'];

    title = json['title'];

    desorption = json['desorption'];
  }
}
