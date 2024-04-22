import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/rate_controller.dart';
import 'package:tucana/controller/survey_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tucana/utilites/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../controller/hotel_controller.dart';

class RatingScreen extends StatefulWidget {
  var h_id;
  RatingScreen({this.h_id, super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> with BaseController {
  final rateController = Get.put(RatingController());
  final hotelsController = Get.put(HotelsController());
  final surveyController = Get.put(SurveyController());
  final TextEditingController reason = TextEditingController();
  List<Map<String, dynamic>> emoji = [
    {
      "start": 1,
      "end": 6,
      "color": Colors.red,
      "status": "Not Likely",
      "img": "assets/icons/bad.png"
    },
    // {
    //   "start": 3,
    //   "end": 4,
    //   "color": Colors.red,
    //   "status": "Not ok",
    //   "img": "assets/icons/notok.png"
    // },
    // {
    //   "start": 5,
    //   "end": 6,
    //   "color": Colors.amber,
    //   "status": "Ok",
    //   "img": "assets/icons/ok.png"
    // },
    {
      "start": 7,
      "end": 8,
      "color": Colors.amber,
      "status": "Likely",
      "img": "assets/icons/ok.png"
    },
    {
      "start": 9,
      "end": 10,
      "color": Colors.green,
      "status": "Extremely Likely",
      "img": "assets/icons/good.png"
    }
  ];

  Map? selected_emoji;

  getStatus(int number, List<Map<String, dynamic>> emoji) {
    for (var item in emoji) {
      if (number >= item['start'] && number <= item['end']) {
        print(item);
        setState(() {
          selected_emoji = item;
        });
        return item['status'];
      }
    }
  }

  _getData() async {
    hotelsController.getBackGround(search_key: widget.h_id);
    if (GetStorage().read('room_num') != null &&
        GetStorage().read('room_num') != '') {
      await hotelsController.getHotel(hid: GetStorage().read('h_id'));
      await surveyController.getNps(
        survey_token: hotelsController.hotel.value.survey_token,
      );
    }
    rateController.isLoaded.value = false;
    rateController.getQuestions();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    super.initState();
  }

  Map<String, dynamic> rates = {};
  updateRate(id, score, name, index) {
    setState(() {
      rates[index] = score;
    });
    rateController.changeRate({'id': id, 'score': score, 'name': name});
  }

  checkRate() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Please Continue Rate to Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (rateController.isLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelsController.back_ground[0].rate_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.only(left: 11, right: 11, top: 105),
            child: Column(
              children: [
                HeaderScreen(),
                Center(
                  child: (GetStorage().read('room_num') != '')
                      ? (surveyController.nps_check.value == false)
                          ? Column(
                              children: [
                                // Container(
                                //   margin: EdgeInsets.all(15),
                                //   child: Text(
                                //       'How many stars do you give to the services & facilities below?',
                                //       style: TextStyle(
                                //           color: Colors.white, fontSize: 25)),
                                // ),
                                SizedBox(
                                  height: 20,
                                ),

                                nps(),
                                SizedBox(
                                  height: 30.0,
                                  // child: buildRate(rateController.question),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white.withOpacity(0.6),
                                      elevation: 0),
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    await surveyController.saveNps(
                                      hotel_token: hotelsController
                                          .hotel.value.survey_token,
                                      answers: surveyController.answers[
                                          surveyController.select_answer.value],
                                      reason: reason.text,
                                    );
                                    // showLoading();
                                    // if (rateController.question.length ==
                                    //     rateController.postData.length) {
                                    //   await rateController.postRate(
                                    //     hotel_id: widget.h_id,
                                    //     room_num: GetStorage().read('room_num'),
                                    //   );
                                    //   Get.snackbar(
                                    //     'Message',
                                    //     'Rate Done Successfully',
                                    //     snackPosition: SnackPosition.TOP,
                                    //     backgroundColor: Colors.green,
                                    //     colorText: Colors.white,
                                    //   );
                                    // } else {
                                    //   checkRate();
                                    // }
                                    // hideLoading();
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                )
                              ],
                            )
                          : Center(
                              child: Text(
                                'You Made This Survey Before',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            )
                      : Center(
                          child: Text(
                            'You Need To Login To Rate',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRate(questions) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(
              questions[index].type_name,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Card(
              color: Colors.white.withOpacity(0.7),
              child: SmoothStarRating(
                  rating: rates[index] ?? 0,
                  allowHalfRating: false,
                  onRatingChanged: (value) async {
                    updateRate(questions[index].id, value,
                        questions[index].type_name, index);
                  },
                  starCount: 5,
                  size: 40.0,
                  borderColor: Colors.black,
                  color: Colors.amber,
                  spacing: 0.0),
              // child: RatingBar.builder(
              //   initialRating: 0,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   // allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //   itemBuilder: (context, _) => Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (rating) {
              //     // print(rating);
              //     rateController.changeRate({
              //       'id': questions[index].id,
              //       'score': rating,
              //       'name': questions[index].type_name
              //     });
              //   },
              // ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  Widget nps() {
    return Obx(
      () {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  surveyController.nps.value.question_trans,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              if (selected_emoji != null) ...[
                Column(
                  children: [
                    Image.asset(
                      selected_emoji!['img'],
                      width: 150,
                      height: 150,
                      color: selected_emoji!['color'],
                    ),
                    Text(
                      selected_emoji!['status'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                )
              ],
              Card(
                color: Colors.white.withOpacity(0.7),
                child: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (rating) {
                      // if (rating < 5) {
                      //   surveyController.rate_color.value = Colors.red;
                      // }
                      // if (rating > 4 && rating < 9) {
                      //   surveyController.rate_color.value = Colors.amber;
                      // }
                      // if (rating == 9 || rating > 9) {
                      //   surveyController.rate_color.value = Colors.green;
                      // }
                      surveyController.select_answer.value = rating.toInt() - 1;
                      getStatus(
                          surveyController.select_answer.value + 1, emoji);
                      surveyController.nps_rate.value = rating;
                      surveyController.rate_color.value =
                          selected_emoji!['color'];
                    },
                    starCount: surveyController.answers.length,
                    rating: surveyController.nps_rate.value,
                    size: 40.0,
                    borderColor: Colors.black,
                    color: surveyController.rate_color.value,
                    spacing: 0.0),
              ),
              Center(
                child: SizedBox(
                  width: 550,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: reason,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: tr("Comment"),
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Wrap(
                  children: [
                    for (var item in emoji)
                      Column(
                        children: [
                          Image.asset(
                            item['img'],
                            width: 70,
                            height: 70,
                            color: Colors.white,
                          ),
                          Text(
                            item['status'],
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Text(
                            "${item['start']} -  ${item['end']}",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
