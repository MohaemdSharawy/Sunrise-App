class Services {
  late String id;

  late String service_name;

  late String dep_id;

  Services.fromJson(json) {
    id = json['id'];

    service_name = (json['Service_name'] != null) ? json['Service_name'] : ' ';

    dep_id = (json['dep_id'] != null) ? json['dep_id'] : ' ';
  }
}
