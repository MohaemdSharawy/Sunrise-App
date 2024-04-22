class Ticket {
  late int id;

  late String description;

  late String reopen;

  late String end_at;

  late String service_name;

  late String department_name;

  late String status;

  late int status_id;

  Ticket.fromJson(json) {
    id = json['id'];
    status_id = json['status_id'];

    description = (json['description'] != null) ? json['description'] : '';

    reopen = json['reopen'];

    end_at = (json['end_at'] != null) ? json['end_at'] : '';

    service_name = json['services']['Service_name'];

    department_name = json['to_department']['department_name'];

    status = json['status']['name'];
  }
}
