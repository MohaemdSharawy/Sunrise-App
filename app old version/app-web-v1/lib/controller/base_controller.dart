import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/survey_controller.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

mixin BaseController {
  void showLoading() {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 150),
        backgroundColor: Colors.white.withOpacity(.9),
        child: Container(
          height: 100,
          width: 5,
          child: Center(
            //   child: Column(
            // children: [
            // SizedBox(
            //   height: 8,
            // ),
            child: CircularProgressIndicator(),
            // SizedBox(
            //   height: 8,
            // ),
            // ElevatedButton(
            //   // style: ElevatedButton.styleFrom(
            //   //     primary: Colors.white.withOpacity(0.6), elevation: 0),
            //   child: Text(
            //     "Close ",
            //   ),
            //   onPressed: () {
            //     hideLoading();
            //   },
            // ),
            //   ],
            // )
          ),
        ),
      ),
      barrierDismissible: false,
    );
  } //end of showLoading

  void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  } //end of closeLoading

  void end_session() {
    if (GetStorage().read('room_num') != '' &&
        GetStorage().read('room_num') != null) {
      var departure =
          DateFormat('yyyy-MM-dd').parse(GetStorage().read('departure'));
      var current_date = DateTime.now();
      var diff = current_date.difference(departure).inDays;
      if (diff > 1) {
        clearData();
      } else {
        // print(diff);
        // print(departure);
      }
    }
  }

  isNotDeparture() {
    if (GetStorage().read('room_num') != '' &&
        GetStorage().read('room_num') != null) {
      var departure =
          DateFormat('yyyy-MM-dd').parse(GetStorage().read('departure'));
      var current_date = DateTime.now();
      var diff = current_date.difference(departure).inDays;
      if (diff > 1) {
        return false;
      } else {
        return true;
      }
    }
  }

  hotelAuth(String h_id, BuildContext context) {
    if (GetStorage().read('room_num') != '' &&
        GetStorage().read('room_num') != null) {
      // if (!isNotDeparture()) {
      //   clearData();
      //   Navigator.pushNamed(context, 'hotels');
      // }

      if (h_id != GetStorage().read('h_id').toString()) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          dialogBackgroundColor: Colors.black,
          body: Center(
            child: Text(
              tr('You Are Login in Another Hotel!!'),
              style: TextStyle(color: Colors.white),
            ),
          ),
          btnOkOnPress: () {},
          btnOkText: tr('ok'),
        ).show();
        Future.delayed(Duration(seconds: 2)).then((value) {
          clearData();
          Navigator.pushNamed(context, 'hotels');
        }).catchError((error) {
          print('Some Thing Wrong');
        });
      }
    }
    // return AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.warning,
    //   animType: AnimType.rightSlide,
    //   dialogBackgroundColor: Colors.black,
    //   body: Center(
    //     child: Text(
    //       tr('You Are Login in Another Hotel!!'),
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    //   btnCancelOnPress: () {
    //     var h_id = GetStorage().read('h_id');
    //     clearData();
    //     Navigator.pushNamed(context, 'hotels');
    //     // Navigator.pushNamed(context, '/login/${h_id}');
    //   },
    //   btnOkOnPress: () {
    //     var h_id = GetStorage().read('h_id');
    //     Navigator.pushNamed(context, 'home/${h_id}');
    //   },
    //   btnCancelText: tr('Logout'),
    //   btnOkText: tr('cancel'),
    // ).show();
  }

  void clearData() {
    GetStorage().remove('room_num');
    GetStorage().remove('departure');
    GetStorage().remove('birthday');
    GetStorage().remove('h_id');
    GetStorage().remove('full_name');
    GetStorage().remove('title');
  }

  login_dialog(context, h_id) async {
    String room = GetStorage().read('room_num');
    return AwesomeDialog(
      width: 900,
      context: context,
      // autoDismiss: false,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'You Need To Login To See Full options',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pushNamed(context, '/login/${h_id}');
      },
      btnCancelText: tr('cancel'),
      btnOkText: tr('login'),
    ).show();
  }

  npsQuestion(context) async {
    // print(GetStorage().read('see_time_msg'));
    // if (GetStorage().read('see_time_msg') != 'showed' &&
    //     GetStorage().read('h_id').toString() != '19') {
    //   return AwesomeDialog(
    //     context: context,
    //     width: 1050,
    //     dialogType: DialogType.warning,
    //     animType: AnimType.rightSlide,
    //     dialogBackgroundColor: Colors.black,
    //     body: Container(
    //       padding: EdgeInsets.all(15),
    //       child: Text(
    //         'Dear guest Kindly note that Summer time will start as of Thursday 25-04-2024 midnight therefore we kindly ask you to adjust your watch one hour ahead to be 01:00 am instead of 00:00 midnight.  The Sunrise team wishes you a pleasant holiday',
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //       ).tr(),
    //     ),
    //     btnCancelOnPress: () {
    //       GetStorage().write('see_time_msg', 'showed');
    //     },
    //     btnCancelText: tr('cancel'),
    //   ).show();
    // }
    // // print(GetStorage().read('arrival'));
    // final surveyController = Get.put(SurveyController());
    // final hotelController = Get.put(HotelsController());
    // final TextEditingController reason = TextEditingController();

    // String room = GetStorage().read('room_num');
    // if (room != '' && room != null) {
    //   DateTime arrival =
    //       DateFormat('yyyy-MM-dd').parse(GetStorage().read('arrival'));
    //   var current_date = DateTime.now();
    //   var diff = current_date.difference(arrival).inDays;
    //   if (diff > 2) {
    //     await hotelController.getHotel(hid: GetStorage().read('h_id'));
    //     await surveyController.getNps(
    //       survey_token: hotelController.hotel.value.survey_token,
    //     );
    //     print('diff ---${diff}');
    //     print('status ---${surveyController.nps_check.value}');
    //     if (surveyController.nps_check.value == false) {
    //       AwesomeDialog(
    //         context: context,
    //         width: 1050,
    //         dialogType: DialogType.warning,
    //         animType: AnimType.rightSlide,
    //         dialogBackgroundColor: Colors.black,
    //         body: Obx(() {
    //           return Center(
    //             child: Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     surveyController.nps.value.question_trans,
    //                     style: TextStyle(color: Colors.white, fontSize: 15),
    //                   ),
    //                 ),
    //                 Card(
    //                   color: Colors.white.withOpacity(0.7),
    //                   child: SmoothStarRating(
    //                       allowHalfRating: false,
    //                       onRatingChanged: (rating) {
    //                         surveyController.nps_rate.value = rating;
    //                         if (rating < 5) {
    //                           surveyController.rate_color.value = Colors.red;
    //                         }
    //                         if (rating > 4 && rating < 9) {
    //                           surveyController.rate_color.value = Colors.amber;
    //                         }
    //                         if (rating == 9 || rating > 9) {
    //                           surveyController.rate_color.value = Colors.green;
    //                         }
    //                         surveyController.select_answer.value =
    //                             rating.toInt() - 1;
    //                       },
    //                       starCount: surveyController.answers.length,
    //                       rating: surveyController.nps_rate.value,
    //                       size: 40.0,
    //                       borderColor: Colors.black,
    //                       color: surveyController.rate_color.value,
    //                       spacing: 0.0),
    //                   // child: RatingBar.builder(
    //                   //   initialRating: 0,
    //                   //   minRating: 1,
    //                   //   direction: Axis.horizontal,
    //                   //   // allowHalfRating: true,
    //                   //   itemCount: surveyController.answers.length,
    //                   //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    //                   //   itemBuilder: (context, i) => Icon(
    //                   //     Icons.star,
    //                   //     color: surveyController.rate_color.value,
    //                   //   ),
    //                   //   onRatingUpdate: (rating) async {
    //                   //     if (rating < 5) {
    //                   //       surveyController.rate_color.value = Colors.red;
    //                   //     }
    //                   //     if (rating > 4 && rating < 9) {
    //                   //       surveyController.rate_color.value = Colors.amber;
    //                   //     }
    //                   //     if (rating == 9 || rating > 9) {
    //                   //       surveyController.rate_color.value = Colors.green;
    //                   //     }
    //                   //     surveyController.select_answer.value =
    //                   //         rating.toInt() - 1;
    //                   //   },
    //                   // ),
    //                 ),
    //                 Center(
    //                   child: SizedBox(
    //                     width: 550,
    //                     child: Container(
    //                       padding: EdgeInsets.all(8),
    //                       child: TextFormField(
    //                         controller: reason,
    //                         keyboardType: TextInputType.text,
    //                         style: TextStyle(color: Colors.white),
    //                         decoration: InputDecoration(
    //                           labelText: tr("Comment"),
    //                           labelStyle: TextStyle(color: Colors.white),
    //                           enabledBorder: UnderlineInputBorder(
    //                             borderSide:
    //                                 BorderSide(color: Colors.white, width: 1),
    //                           ),
    //                           focusedBorder: UnderlineInputBorder(
    //                             borderSide:
    //                                 BorderSide(color: Colors.white, width: 2),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         }),
    //         btnOkOnPress: () async {
    //           await surveyController.saveNps(
    //             hotel_token: hotelController.hotel.value.survey_token,
    //             answers: surveyController
    //                 .answers[surveyController.select_answer.value],
    //             reason: reason.text,
    //           );
    //         },
    //         btnOkText: tr('Submit'),
    //         btnCancelOnPress: () {},
    //         btnCancelText: tr('cancel'),
    //       ).show();
    //     }
    //   }
    // }
  }
} //end of controller
