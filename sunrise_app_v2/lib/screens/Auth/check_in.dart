import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/auth_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_select.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final hotelController = Get.put(HotelController());
  final _roomController = TextEditingController();
  final _hotelController = SingleValueDropDownController();

  final _departureController = TextEditingController();

  Future<Null> selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(2050),
    );
    if (_datePicker != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePicker);
      setState(() {
        _departureController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  _getData() async {
    await hotelController.getHotels();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.hotel_loaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (hotelController.hotel_loaded.value)
            ? Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Icon(Icons.arrow_back),
                                  onTap: () => Get.back(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            'Check in, unlock your room, and control your space',
                            style: AppFont.boldBlack,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: CustomTextInput(
                              controller: _roomController,
                              hintText: 'Enter Your Room Number',
                              icon: Icons.roofing_sharp,
                              only_number: true,
                              valid: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Room Number is required');
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomDropdownSelect(
                            controller: _hotelController,
                            option: hotelController.hotels
                                .map(
                                  (element) => DropDownValueModel(
                                      name: element.hotel_name,
                                      value: element.id),
                                )
                                .toList(),
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return ('Please Select Your Resort or Cruises');
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: CustomTextInput(
                              read_only: true,
                              controller: _departureController,
                              hintText: 'Enter Your Phone Number',
                              icon: Icons.date_range_outlined,
                              valid: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Departure Date is required');
                                }
                              },
                              onTap: () async {
                                print('ss');
                                setState(() {
                                  selectDate(context);
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Obx(
                            () => (authController.checkInLoading.value)
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: MaterialButton(
                                      height: 60,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await authController.check_in(
                                            departure_date:
                                                _departureController.text,
                                            room_number: _roomController.text,
                                            hotel_id: _hotelController
                                                .dropDownValue!.value,
                                          );
                                        }
                                        // Get.to(page)
                                        // Get.to(CheckInScreen());
                                      },
                                      textColor: Colors.white,
                                      color: AppColor.second,
                                      child: Text(
                                        'Check In',
                                        style: AppFont.midThird,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CustomBtn(
                                      color: AppColor.second,
                                      action: () => print('s'),
                                      title: CircularProgressIndicator(
                                        color: AppColor.background_card,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : WidgetDotFade(
                color: AppColor.primary,
              ),
      ),
    );
  }
}
