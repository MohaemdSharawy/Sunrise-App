// class CityGuide {
//   late String id;

//   late String name;

//   CityGuide.fromJson(json) {
//     id = json['id'];

//     name = (json['name'] != null) ? json['name'] : '';
//   }
// }
class CityGuide {
  late String id;

  late String hid;

  late String info;

  late String description;

  CityGuide.fromJson(json) {
    id = json['id'];

    hid = json['hid'];

    info = (json['info'] != null) ? json['info'] : '';

    description = (json['description'] != null) ? json['description'] : '';
  }
}
