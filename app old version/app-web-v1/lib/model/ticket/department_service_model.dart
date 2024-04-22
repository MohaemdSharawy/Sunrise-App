class DepartmentService {
  late String id;

  late String department_name;

  DepartmentService.fromJson(json) {
    id = json['id'];

    department_name =
        (json['department_name'] != null) ? json['department_name'] : ' ';
  }
}
