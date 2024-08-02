import 'package:sunrise_app_v2/models/let_us_know_model.dart';

class LetUsKnowHotelsResponse {
  List<LetUsKnowHotels> hotel = [];
  LetUsKnowHotelsResponse.fromJson(json) {
    hotel.add(LetUsKnowHotels.fromJson(json['hotel']));
  }
}

class CountryCodesResponse {
  List<CountryCodes> countryCodes = [];

  CountryCodesResponse.fromJson(json) {
    json['codes']
        .forEach((data) => countryCodes.add(CountryCodes.fromJson(data)));
  }
}

class PrioritiesResponse {
  List<Priorities> priorities = [];

  PrioritiesResponse.fromJson(json) {
    json['priorities']
        .forEach((data) => priorities.add(Priorities.fromJson(data)));
  }
}

class LetUsKnowDepartmentResponse {
  List<LetUsKnowDepartment> departments = [];

  LetUsKnowDepartmentResponse.fromJson(json) {
    json['departments']
        .forEach((data) => departments.add(LetUsKnowDepartment.fromJson(data)));
  }
}
