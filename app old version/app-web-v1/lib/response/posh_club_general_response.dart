import 'package:tucana/model/posh_club_general.dart';

class PoshClubGeneralResponse {
  List<PoshClubGeneralModel> posh_club = [];

  PoshClubGeneralResponse.fromJson(json) {
    json['posh_club']
        .forEach((data) => posh_club.add(PoshClubGeneralModel.fromJson(data)));
  }
}

class PoshClubHotelsResponse {
  List<PoshClubHotels> posh_club_hotels = [];
  PoshClubHotelsResponse.fromJson(json) {
    json['posh_club_hotels']
        .forEach((data) => posh_club_hotels.add(PoshClubHotels.fromJson(data)));
  }
}
