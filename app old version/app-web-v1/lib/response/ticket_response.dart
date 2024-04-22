import 'package:tucana/model/ticket/department_service_model.dart';
import 'package:tucana/model/ticket/service_model.dart';
import 'package:tucana/model/ticket/ticket_model.dart';

class DepartmentServiceResponse {
  List<DepartmentService> department_service = [];

  DepartmentServiceResponse.fromJson(json) {
    json['department_service'].forEach(
        (data) => department_service.add(DepartmentService.fromJson(data)));
  }
}

class ServiceResponse {
  List<Services> services = [];
  ServiceResponse.fromJson(json) {
    json['services'].forEach((data) => services.add(Services.fromJson(data)));
  }
}

class TicketResponse {
  List<Ticket> tickets = [];
  TicketResponse.fromJson(json) {
    json['tickets'].forEach((data) => tickets.add(Ticket.fromJson(data)));
  }
}
