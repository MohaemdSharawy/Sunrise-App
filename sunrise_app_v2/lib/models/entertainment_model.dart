class EntertainmentModel {
  late int id;

  late String day;

  late String event;

  late String from;

  late String to;

  late String location;

  EntertainmentModel.fromJson(json) {
    id = json['id'];

    day = json['day'];

    event = json['event'];

    from = json['from'];

    to = json['to'];

    location = json['location'];
  }
}
