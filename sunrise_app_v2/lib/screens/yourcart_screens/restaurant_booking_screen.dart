import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/working_day_controller.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';
import 'package:sunrise_app_v2/utilites/general/expanded_text.dart';

class BookingRestaurantScreen extends StatefulWidget {
  String restaurant_code;
  BookingRestaurantScreen({required this.restaurant_code, super.key});

  @override
  State<BookingRestaurantScreen> createState() =>
      _BookingRestaurantScreenState();
}

class _BookingRestaurantScreenState extends State<BookingRestaurantScreen> {
  final restaurantController = Get.put(RestaurantController());
  final _selectedDate = TextEditingController();
  final workingDayController = Get.put(WorkingDayController());

  var check_in_data;
  _getData() async {
    await restaurantController.get_restaurant_by_code(
        restaurant_code: widget.restaurant_code);
    await workingDayController.getWorkingDays(
        restaurant_id: restaurantController.restaurant.value.id);
    if (GetStorage().read('check_id_data') != null) {
      check_in_data = jsonDecode(GetStorage().read('check_id_data'));
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  final List<String> allowedDates = [
    '2024-07-31',
    '2024-08-01',
    '2024-08-02',
    '2024-08-05',
    '2024-08-07',
  ];

  Future<Null> selectDate(BuildContext context) async {
    String dateString = '2024-07-31';
    DateTime initialDate = DateTime.parse(dateString);

    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: (workingDayController.allow_dates.length > 0)
          ? DateTime.parse(workingDayController.allow_dates[0])
          : null,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      selectableDayPredicate: (DateTime date) {
        String formattedDate =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        return workingDayController.allow_dates.contains(formattedDate);
      },
    );
    if (_datePicker != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePicker);
      setState(() {
        _selectedDate.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (restaurantController.info_loaded.value)
            ? SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            // width: double.infinity,
                            // height: double.infinity,
                          ),
                          SliderWidget(
                            height: 350,
                          ),
                          Positioned(
                            // top: 5,
                            child: Container(
                              // height: 180,
                              decoration: BoxDecoration(
                                color: AppColor.background_card,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: CustomStayHeader(
                                title: Column(
                                  children: [
                                    // Text(restaurantController.restaurant.value.h),
                                    Text(
                                      restaurantController
                                          .restaurant.value.restaurant_name,
                                      style: AppFont.boldBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height /
                                  3, //minimum height
                            ),
                            margin: EdgeInsets.only(top: 330),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.background_card,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Description',
                                            style: AppFont.smallBoldBlack,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: ExpandableText(
                                              restaurantController
                                                  .restaurant.value.description,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.9,
                                      child: CustomTextInput(
                                        controller: _selectedDate,
                                        hintText: 'Select Date',
                                        icon: Icons.date_range,
                                        read_only: true,
                                        onTap: () async {
                                          setState(() {
                                            selectDate(context);
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: CustomTextInput(
                                        hintText: 'Pax',
                                        icon: Icons.person,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextInput(
                                  hintText: 'Select Time',
                                  icon: Icons.timer_outlined,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextInput(
                                  hintText: 'Special Event',
                                  icon: Icons.event_outlined,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextInput(
                                  hintText: 'Allergies',
                                  icon: Icons.restaurant_outlined,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  padding: EdgeInsets.only(bottom: 15),
                                  height: 60,
                                  child: CustomBtn(
                                    action: () {},
                                    title: Text('Book Now'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }
}
