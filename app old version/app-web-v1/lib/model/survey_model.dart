import 'package:flutter/rendering.dart';

class SurveyQuestions {
  late String id;

  late String surid;

  late String quesid;

  late String question;

  late List answers;

  SurveyQuestions.fromJson(json) {
    id = json['id'];

    surid = (json['surid'] != null) ? json['surid'] : '';

    quesid = (json['quesid'] != null) ? json['quesid'] : '';

    question = (json['question'] != null) ? json['question'] : '';

    answers = (json['answers'] != null) ? json['answers'] : [];
  }
}

class Nps {
  late String id;

  late String surid;

  late String quesid;

  late String question;

  late String typeid;

  late String question_trans;

  Nps();
  Nps.fromJson(json) {
    id = json['id'];

    surid = json['surid'];

    quesid = json['quesid'];

    question = json['question'];

    typeid = json['typeid'];

    question_trans = json['question_trans'];
  }
}

class Answers {
  late String id;

  late String ques_id;

  late String answer;

  late String score;

  Answers.fromJson(json) {
    id = json['id'];

    ques_id = json['ques_id'];

    answer = json['answer'];

    score = json['score'];
  }
}
