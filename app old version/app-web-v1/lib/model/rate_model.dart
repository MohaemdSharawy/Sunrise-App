class QuestionRate {
  late String id;

  late String type_name;

  QuestionRate.fromJson(json) {
    id = json['id'];

    type_name = json['type_name'];
  }
}
