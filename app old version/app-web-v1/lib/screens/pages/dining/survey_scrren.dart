import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/pms_controller.dart';
import 'package:tucana/controller/survey_controller.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'dart:html' as htmls;

class SurveyScreen extends StatefulWidget {
  var rest_code;
  SurveyScreen({this.rest_code, super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> with BaseController {
  final surveyController = Get.put(SurveyController());
  final hotelController = Get.put(HotelsController());
  final restaurantController = Get.put(RestaurantController());
  late SingleValueDropDownController _cnt;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _birthdayController = TextEditingController();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController room_no = TextEditingController();
  final pmsController = Get.put(PmsController());

  Map<String, dynamic> rates = {};
  updateRate(
      question_id, answer_id, score, res_id, meal_id, answer_score, index) {
    setState(() {
      rates[index] = score;
    });
    surveyController.changeRate({
      'quest_id': question_id,
      'answer': answer_id,
      'score': answer_score,
      'res_id': res_id,
      'meal_id': meal_id,
      'nationalites': GetStorage().read('country')
    });
  }

  _getData() async {
    await restaurantController.restaurantByCode(
        restaurant_code: widget.rest_code);

    await hotelController.getBackGround(
      search_key: hotelController.hotel.value.id,
    );
    surveyController.getQuestions(
        restaurant_id: restaurantController.single_restaurant.value.id,
        survey_token: hotelController.hotel.value.survey_token);
  }

  @override
  void initState() {
    _getData();
    _cnt = SingleValueDropDownController();
    if (GetStorage().read('room_num') == null ||
        GetStorage().read('room_num') == '') {
      login_Dialog();
    }
    super.initState();
  }

  Future<Null> selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(2050),
      // initialDatePickerMode: DatePickerMode.day,
      // selectableDayPredicate: (DateTime val) =>
      //     restaurant_day_off.contains(val.weekday.toString()) ? false : true,
    );
    if (_datePicker != null) {
      print(_datePicker); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePicker);

      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        _birthdayController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  TextStyle style = TextStyle(color: Colors.white, fontSize: 25);
  login_Dialog() {
    return AwesomeDialog(
      context: context,
      autoDismiss: false,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.black,
      body: Center(
        child: login(),
      ),
      // btnCancelOnPress: () {
      //   // htmls.window.location.reload();
      // },
      btnOkOnPress: () async {
        if (_formKeyLogin.currentState!.validate()) {
          // print(room_no.text);
          // print(cardController.my_order[0]['hid']);
          // print(_birthdayController.text);
          await pmsController
              .login(
                room_no: room_no.text,
                hotel_id: hotelController.hotel.value.id,
                context: context,
                birthday: _birthdayController.text,
                login_type: 'restaurant_survey',
              )
              .then(
                (value) => htmls.window.location.reload(),
              );
        }
      },
      // btnCancelText: tr('cancel'),
      btnOkText: tr('login'),
    ).show();
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
        return (surveyController.questionsLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        (GetStorage().read('room_num') != null &&
                GetStorage().read('room_num') != '')
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    AppBarWidget(h_id: hotelController.hotel.value.id),
                    SizedBox(
                      height: 40,
                    ),
                    (restaurantController.single_restaurant.value.white_logo !=
                            '')
                        ? Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.single_restaurant.value.white_logo}',
                            height: 150,
                          )
                        : Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.single_restaurant.value.logo}',
                            height: 150,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Center(
                        child: SizedBox(
                          width: 750,
                          child: Container(
                            // margin: EdgeInsets.only(left: 25, right: 25),
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Card(
                              color: Colors.white.withOpacity(0.7),
                              child: DropDownTextField(
                                textFieldDecoration: const InputDecoration(
                                    hintText: "Select Your Meal"),

                                clearOption: true,
                                controller: _cnt,
                                enableSearch: false,
                                listTextStyle: TextStyle(color: Colors.black),
                                clearIconProperty:
                                    IconProperty(color: Colors.green),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Meal is required';
                                  }
                                },
                                dropDownItemCount: 3,
                                dropDownList: [
                                  DropDownValueModel(
                                      name: "BreakFast", value: "1"),
                                  DropDownValueModel(name: "Lunch", value: "2"),
                                  DropDownValueModel(
                                      name: "Dinner", value: "3"),
                                ],
                                // .map((e) =>
                                //     DropDownValueModel(value: e.id, name: e.table_name))
                                // .toList(),
                                onChanged: (val) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: buildQuestion()),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.6), elevation: 0),
                      child: Text('Submit'),
                      onPressed: () async {
                        if (surveyController.questions.length ==
                            surveyController.postData.length) {
                          showLoading();
                          if (_formKey.currentState!.validate()) {
                            await surveyController
                                .saveRestaurant(
                                  hotel_token:
                                      hotelController.hotel.value.survey_token,
                                  // restaurant_id: restaurantController
                                  //     .single_restaurant.value.id,
                                  restaurant_id: widget.rest_code,

                                  meal: _cnt.dropDownValue?.value,
                                )
                                .then(
                                  (value) => setState(() {
                                    rates = {};
                                    surveyController.postData.clear();
                                  }),
                                );
                          }

                          // htmls.window.location.reload();

                          // Get.snackbar(
                          //   'Message',
                          //   'Rate Done Successfully',
                          //   snackPosition: SnackPosition.TOP,
                          //   backgroundColor: Colors.green,
                          //   colorText: Colors.white,
                          // );
                          hideLoading();
                        } else {
                          checkRate();
                        }
                        // hideLoading();
                      },
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  AppBarWidget(h_id: hotelController.hotel.value.id),
                  Center(
                      child: Text(
                    'You Need Login To Rate Restaurant',
                    style: style,
                  )),
                ],
              ),
        // restaurantItem(),
      ],
    );
  }

  Widget buildQuestion() {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: surveyController.questions.length,
        itemBuilder: (context, index) {
          return Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                surveyController.questions[index].question,
                style: style,
              ),
            ),
            Card(
              color: Colors.white.withOpacity(0.7),

              child: SmoothStarRating(
                  rating: rates[index] ?? 0,
                  allowHalfRating: false,
                  onRatingChanged: (value) async {
                    // updateRate(surveyController.questions[index].id, value,
                    //     surveyController.questions[index].id, index);

                    int answer_index = value.toInt() - 1;
                    var questions = surveyController.questions[index];

                    var answer =
                        surveyController.questions[index].answers[answer_index];

                    print('answer Index ${answer_index}');
                    print(answer);
                    print(questions.id);
                    updateRate(
                      answer['ques_id'],
                      answer['id'],
                      value,
                      restaurantController.single_restaurant.value.id,
                      _cnt.dropDownValue?.value,
                      answer['score'],
                      index,
                    );
                  },
                  starCount: surveyController.questions[index].answers.length,
                  size: 40.0,
                  borderColor: Colors.black,
                  color: Colors.amber,
                  spacing: 0.0),

              // child: RatingBar.builder(
              //   initialRating: 0,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   // allowHalfRating: true,
              //   itemCount: 3,
              //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //   itemBuilder: (context, _) => Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (rating) {
              //     // print(rating);
              //     // rateController.changeRate({
              //     //   'id': questions[index].id,
              //     //   'score': rating,
              //     //   'name': questions[index].type_name
              //     // });
              //   },
              // ),
            ),
            if (surveyController
                .check_rated(surveyController.questions[index].quesid)) ...[
              SizedBox(
                width: 750,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    // marg,
                    child: TextFormField(
                      onChanged: ((value) {
                        setState(() {
                          surveyController.add_notes(
                              surveyController.questions[index].quesid, value);
                        });
                      }),

                      // initialValue: cardController.my_order[index]['notes'],
                      // controller: cardController.my_order[index]['notes'],
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: tr("Note"),
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
            ]
          ]);
        });
  }

  Widget login() {
    return Form(
      key: _formKeyLogin,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              controller: room_no,
              style: TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('Room Number is required');
                }
              },
              decoration: InputDecoration(
                labelText: tr('Room Number'),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            Container(height: 20),
            TextFormField(
              controller: _birthdayController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date is required';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: tr("Departure Day"),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              readOnly: true,
              onTap: () async {
                setState(() {
                  selectDate(context);
                });
              },
            ),
            // TextFormField(
            //   keyboardType: TextInputType.text,
            //   controller: _birthdayController,
            //   style: TextStyle(color: Colors.white),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return tr('Birth day is required');
            //     }
            //   },
            //   decoration: InputDecoration(
            //     labelText: tr("Last Name"),
            //     labelStyle: TextStyle(color: Colors.white),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white, width: 2),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 35,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 150,
            //       height: 45,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Colors.white.withOpacity(0.6), elevation: 0),
            //         child: Text(
            //           "Confirm",
            //         ).tr(),
            //         onPressed: () async {
            //           if (_formKey.currentState!.validate()) {
            //             await pmsController.login(
            //               room_no: _roomNumberController.text,
            //               hotel_id: 0,
            //               context: context,
            //               birthday: _birthdayController.text,
            //             );
            //           }
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
