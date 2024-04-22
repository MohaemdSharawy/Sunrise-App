class Allergies {
  late String id;

  late String allergies_name;

  late String logo;

  Allergies.fromJson(json) {
    id = json['id'];

    allergies_name =
        (json['allergies_name'] != null) ? json['allergies_name'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';
  }
}
