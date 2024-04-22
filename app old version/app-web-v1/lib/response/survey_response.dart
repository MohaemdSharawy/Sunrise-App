import 'package:tucana/model/survey_model.dart';

class SurveyQuestionsResponse {
  List<SurveyQuestions> surveyQuestions = [];

  SurveyQuestionsResponse.fromJson(json) {
    json['questions']
        .forEach((data) => surveyQuestions.add(SurveyQuestions.fromJson(data)));
  }
}

class AnswersResponse {
  List<Answers> answers = [];
  AnswersResponse.fromJson(json) {
    json['answers'].forEach((data) => answers.add(Answers.fromJson(data)));
  }
}
