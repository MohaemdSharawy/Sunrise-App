class PoshClubSlider {
  late String id;

  late String logo;

  late String hotel_id;

  PoshClubSlider.fromJson(json) {
    id = json['id'].toString();

    logo = json['logo'];

    hotel_id = json['hotel_id'];
  }
}

class PoshClub {
  late String id;

  late String header;

  late String description;

  PoshClub.fromJson(json) {
    id = json['id'].toString();

    header = json['header'];

    description = json['description'];
  }
}

class PoshClubLogo {
  PoshClubLogo();

  late String id;

  late String logo;

  late String hotel_id;

  PoshClubLogo.fromJson(json) {
    id = json['id'].toString();

    logo = json['logo'];

    hotel_id = json['hotel_id'];
  }
}
