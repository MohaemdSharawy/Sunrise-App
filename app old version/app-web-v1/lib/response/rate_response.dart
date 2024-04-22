import 'dart:convert';

import 'package:tucana/model/rate_model.dart';

class QuestionRateResponse {
  List<QuestionRate> questionRate = [];

  QuestionRateResponse.fromJson(json) {
    // final data_type = jsonDecode(json);
    // print(json['restaurants']);
    json['questions']
        .forEach((data) => questionRate.add(QuestionRate.fromJson(data)));
  }
}
