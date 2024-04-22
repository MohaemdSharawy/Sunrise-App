import 'package:tucana/model/allergies_model.dart';

class AllergiesResponse {
  List<Allergies> allergies = [];

  AllergiesResponse.fromJson(json) {
    json['allergies']
        .forEach((data) => allergies.add(Allergies.fromJson(data)));
  }
}
