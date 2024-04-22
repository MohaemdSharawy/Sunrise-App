import 'package:tucana/model/hotel_guide/city_guide_model.dart';
import 'package:tucana/model/hotel_guide/entertainment_model.dart';
import 'package:tucana/model/hotel_guide/hotel_info_model.dart';
import 'package:tucana/model/hotel_guide/hotel_map_model.dart';
import 'package:tucana/model/hotel_guide/posh_club_model.dart';
import 'package:tucana/model/hotel_guide/tv_guide_model.dart';

class HotelInfoResponse {
  List<HotelInfo> hotel_info = [];
  HotelInfoResponse.fromJson(json) {
    json.forEach((data) => hotel_info.add(HotelInfo.fromJson(data)));
  }
}

class HotelMapResponse {
  List<HotelMap> hotel_map = [];
  HotelMapResponse.fromJson(json) {
    json.forEach((data) => hotel_map.add(HotelMap.fromJson(data)));
  }
}

class CityGuideResponse {
  List<CityGuide> city_guide = [];
  CityGuideResponse.fromJson(json) {
    json.forEach((data) => city_guide.add(CityGuide.fromJson(data)));
  }
}

class TvGuideResponse {
  List<TvGuide> tv_guide = [];
  TvGuideResponse.fromJson(json) {
    json.forEach((data) => tv_guide.add(TvGuide.fromJson(data)));
  }
}

class EntertainmentResponse {
  List<Entertainment> entertainment = [];
  EntertainmentResponse.fromJson(json) {
    json.forEach((data) => entertainment.add(Entertainment.fromJson(data)));
  }
}

class PoshClubResponse {
  List<PoshClub> posh_club = [];

  PoshClubResponse.fromJson(json) {
    json['info'].forEach((data) => posh_club.add(PoshClub.fromJson(data)));
  }
}

class PoshClubSliderResponse {
  List<PoshClubSlider> posh_club_slider = [];

  PoshClubSliderResponse.fromJson(json) {
    json['sliders']
        .forEach((data) => posh_club_slider.add(PoshClubSlider.fromJson(data)));
  }
}

class HotelServiceResponse {
  List<HotelService> hotel_service = [];

  HotelServiceResponse.fromJson(json) {
    json.forEach((data) => hotel_service.add(HotelService.fromJson(data)));
  }
}
