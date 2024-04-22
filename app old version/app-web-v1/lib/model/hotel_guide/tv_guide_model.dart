class TvGuide {
  late String id;

  late String name_channel;

  late String type;

  late String logo;

  TvGuide.fromJson(json) {
    id = json['id'];

    name_channel = (json['name_channel'] != null) ? json['name_channel'] : '';

    type = (json['type'] != null) ? json['type'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';
  }
}
