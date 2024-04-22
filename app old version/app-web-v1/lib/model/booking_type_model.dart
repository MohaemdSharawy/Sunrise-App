class BookingType {
  late String id;

  late String type_name;

  late String type_data;

  BookingType.fromJson(json) {
    id = json['id'];

    type_name = (json['type_name'] != null) ? json['type_name'] : '';

    type_data = (json['type_data'] != null) ? json['type_data'] : '';
  }
}
