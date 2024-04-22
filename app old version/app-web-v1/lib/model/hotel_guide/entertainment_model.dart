class Entertainment {
  late String id;

  late String event;

  late String location;

  late String from;

  late String to;

  late String day_id;

  Entertainment.fromJson(json) {
    id = json['id'];

    event = (json['event'] != null) ? json['event'] : '';

    location = (json['location'] != null) ? json['location'] : '';

    from = (json['from'] != null) ? json['from'] : '';

    to = (json['to'] != null) ? json['to'] : '';

    day_id = (json['day_id'] != null) ? json['day_id'] : '';
  }
}
