class PoshClubGeneralModel {
  late String id;
  late String header;
  late String description;

  PoshClubGeneralModel.fromJson(json) {
    id = json['id'];
    header = json['header'];
    description = json['description'];
  }
}

class PoshClubHotels {
  late String id;

  late String logo_white;

  PoshClubHotels.fromJson(json) {
    id = json['id'];

    logo_white = (json['logo_white'] != null) ? json['logo_white'] : '';
  }
}


// class PoshClubGeneralLogo {
//   PoshClubGeneralLogo();
//   late String id;

//   late String logo;

//   PoshClubGeneralLogo.fromJson(json) {
//     id = json['id'];
//     logo = json['logo'];
//   }
// }

// class PoshClubGeneralSliderModel {
//   late String id;

//   late String image;
//   PoshClubGeneralSliderModel.fromJson(json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }
