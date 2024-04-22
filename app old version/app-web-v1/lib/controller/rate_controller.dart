import 'dart:convert';
// import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/model/rate_model.dart';
import 'package:tucana/response/rate_response.dart';
import 'package:tucana/services/api.dart';

class RatingController extends GetxController {
  var isLoaded = false.obs;
  var question = <QuestionRate>[].obs;

  var postData = [];

  void changeRate(rateData) {
    var item = postData.where((e) => e['id'] == rateData['id']);

    if (item.length == 0) {
      addRateItem(rateData);
    } else {
      updateRate(rateData);
    }
  }

  void addRateItem(rateData) {
    Map myRate = {
      'id': rateData['id'],
      'score': rateData['score'],
      'name': rateData['name']
    };
    postData.add(myRate);
  }

  void updateRate(rateData) {
    int key = postData.indexWhere((element) => element['id'] == rateData['id']);
    postData[key]['score'] == rateData['score'];
  }

  Map postQuestion = {};

  Future<void> getQuestions() async {
    var response = await Api.questionsRate();

    var questionRateResponse = QuestionRateResponse.fromJson(response.data);

    question.clear();

    question.addAll(questionRateResponse.questionRate);

    isLoaded.value = true;
  }

  Future<void> postRate(
      {required int hotel_id, required String room_num}) async {
    // print('done');

    var response = await Api.postRate(
      room_num: room_num,
      hotel_id: hotel_id,
      answers: postData,
    );
    print(response);
  }
}











  // var overAllStay = 0.0.obs;
  // var values = 0.0.obs;
  // var cleanliness = 0.0.obs;
  // var sleepQuality = 0.0.obs;
  // var location = 0.0.obs;
  // var checkInProcess = 0.0.obs;
  // var rooms = 0.0.obs;
  // var foodQuality = 0.0.obs;
  // var drinksquality = 0.0.obs;
  // var staffService = 0.0.obs;
