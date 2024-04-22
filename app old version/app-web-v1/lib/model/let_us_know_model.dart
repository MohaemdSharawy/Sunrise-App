class LetUsKnowHotels {
  late int id;

  late String hotel_name;

  late String hotel_code;

  late String back_ground;
  // late String asset_folder;

  LetUsKnowHotels();

  LetUsKnowHotels.fromJson(json) {
    id = json['id'];

    hotel_name = json['hotel_name'];

    hotel_code = json['code'];

    back_ground = json['back_ground'];
    // asset_folder = json['asset_folder'];
  }
}

class CountryCodes {
  late int id;

  late String code;

  late String name;

  CountryCodes.fromJson(json) {
    id = json['id'];

    code = json['name'];

    name = json['nick_name'];
  }
}

class Priorities {
  late int id;

  late String name;

  late String image;

  Priorities.fromJson(json) {
    id = json["id"];

    name = json['name'];

    image = json['image'];
  }
}

class LetUsKnowDepartment {
  late int id;

  late String dep_name;

  late String dep_code;

  LetUsKnowDepartment.fromJson(json) {
    id = json['id'];

    dep_name = json['dep_name'];

    dep_code = json['dep_code'];
  }
}
