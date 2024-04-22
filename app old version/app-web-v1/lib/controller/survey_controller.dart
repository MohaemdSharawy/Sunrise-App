import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/model/survey_model.dart';
import 'package:tucana/response/survey_response.dart';
import 'package:tucana/services/survey_api.dart';
import 'dart:html' as htmls;
import 'package:http/http.dart' as http;

class SurveyController extends GetxController with BaseController {
  var questions = <SurveyQuestions>[].obs;
  var questionsLoaded = false.obs;
  var nps = Nps().obs;
  var rate_color = Colors.black.obs;
  var answers = <Answers>[].obs;
  var select_answer = 0.obs;
  var nps_check = false.obs;
  var nps_rate = 0.0.obs;

  var postData = [];

  void changeRate(rateData) {
    var item = postData.where((e) => e['quest_id'] == rateData['quest_id']);

    if (item.length == 0) {
      addRateItem(rateData);
    } else {
      updateRate(rateData);
    }
  }

  void addRateItem(rateData) {
    // Map myRate = {
    //   'id': rateData['id'],
    //   'score': rateData['score'],
    //   'name': rateData['name']
    // };
    postData.add(rateData);
  }

  void updateRate(rateData) {
    int key = postData
        .indexWhere((element) => element['quest_id'] == rateData['quest_id']);
    postData[key] = rateData;
  }

  void add_notes(question_id, reason) {
    var item = postData.where((e) => e['quest_id'] == question_id);
    if (item.length == 0) {
      // postData.add({'quest_id': question_id, 'reason': reason});
    } else {
      int key =
          postData.indexWhere((element) => element['quest_id'] == question_id);
      postData[key]['reason'] = reason;
    }

    print(postData);
  }

  bool check_rated(question_id) {
    var item = postData.where((e) => e['quest_id'] == question_id);
    if (item.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> check_nps({
    required String survey_token,
  }) async {
    var response = await SurveyApi.check_nps(survey_token: survey_token);
    nps_check.value = response.data['confirmation'];
  }

  Future<void> getQuestions({
    required String survey_token,
    required String restaurant_id,
  }) async {
    var response = await SurveyApi.get_questions(
      hotel_token: survey_token,
      restaurant_id: restaurant_id,
    );
    var surveyResponse = SurveyQuestionsResponse.fromJson(response.data);
    questions.clear();
    questions.addAll(surveyResponse.surveyQuestions);
    questionsLoaded.value = true;
  }

  Future<void> getNps({
    required String survey_token,
  }) async {
    await check_nps(survey_token: survey_token);
    var response = await SurveyApi.get_nps(hotel_token: survey_token);
    nps.value = Nps.fromJson(response.data['questions'][0]);
    var answerResponse =
        AnswersResponse.fromJson(response.data['questions'][0]);
    answers.clear();
    answers.addAll(answerResponse.answers);
  }

  Future<void> saveNps(
      {required String hotel_token,
      required Answers answers,
      String? reason}) async {
    // showLoading();

    Map<String, dynamic> postData = {
      'roomnum': GetStorage().read('room_num'),
      'idtkn': hotel_token,
      'firstname': GetStorage().read('firstname'),
      'lastname': GetStorage().read('lastname'),
      'email': GetStorage().read('email'),
      'confirmation': GetStorage().read('confirmation'),
      'phone':
          (GetStorage().read('phone') != null) ? GetStorage().read('phone') : 0,
      'nationalites': GetStorage().read('country'),
      'departure': GetStorage().read('departure'),
      'arrival': GetStorage().read('arrival'),
      'lang': GetStorage().read('lang'),
      'items': [
        {
          // 'id': answers.id,
          // 'answer': answers.swer,
          'answer': answers.id,
          'quest_id': answers.ques_id,
          'score': answers.score,
          'reason': reason
        }
      ]
    };

    print(postData);
    const Map<String, String> _JSON_HEADERS = {
      "content-type": "application/json",
      "authtoken":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiQ1JNIiwibmFtZSI6IkNSTSIsInBhc3N3b3JkIjpudWxsLCJBUElfVElNRSI6MTU5NDM4NTQ1OX0.AwiaqClDd8qVsddxLBQi_naM2bobOHFPjXDJRNY7S7U",

      // "Content-Type": "multipart/form-data,multipart/form-data",
      // "Access-Control-Allow-Origin": "*",
    };
    var url =
        Uri.parse("https://surveys.sunrise-resorts.com/api/restaurant/nps");

    await sendPost(postData, url);
  }

  Future<void> saveRestaurant(
      {required String hotel_token,
      required String restaurant_id,
      required String meal,
      String? reason}) async {
    // showLoading();

    Map<String, dynamic> data_post = {
      'roomnum': GetStorage().read('room_num'),
      'idtkn': hotel_token,
      'firstname': GetStorage().read('firstname'),
      'lastname': GetStorage().read('lastname'),
      'email': GetStorage().read('email'),
      'confirmation': GetStorage().read('confirmation'),
      'phone':
          (GetStorage().read('phone') != null) ? GetStorage().read('phone') : 0,
      'nationalites': GetStorage().read('country'),
      'departure': GetStorage().read('departure'),
      'arrival': GetStorage().read('arrival'),
      'lang': GetStorage().read('lang'),
      'restaurant_id': restaurant_id,
      'meal': meal,
      'items': postData
    };

    print(data_post);

    var url = Uri.parse(
        "https://surveys.sunrise-resorts.com/api/restaurant/restaurant");

    await sendPost(data_post, url);
  }

  Future sendPost(Map<String, dynamic> data, url) async {
    try {
      http.Client client = new http.Client();
      final String encodedData = json.encode(data);
      await client.post(
        url, //your address here
        body: encodedData,
        // headers: _JSON_HEADERS,
      );

      hideLoading();
      // String redirect_code = my_order[0]['res_code'];
      // Navigator.pushNamed(context, '/categories/${redirect_code}');
      Get.snackbar(
        'Message',
        'Done',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // htmls.window.location.reload();
    } catch (e) {
      hideLoading();
      Get.snackbar(
        'Message',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
