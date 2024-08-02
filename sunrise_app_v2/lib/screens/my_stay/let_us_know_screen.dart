import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/let_us_know_controller.dart';
import 'package:sunrise_app_v2/models/let_us_know_model.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/custom_select.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class LetUsKnowScreen extends StatefulWidget {
  int hotel_id;
  LetUsKnowScreen({required this.hotel_id, super.key});

  @override
  State<LetUsKnowScreen> createState() => _LetUsKnowScreenState();
}

class _LetUsKnowScreenState extends State<LetUsKnowScreen> {
  final hotelController = Get.put(HotelController());
  final _countryCode = SingleValueDropDownController();
  final letUsKnowController = Get.put(LetUsKnowController());
  final TextEditingController notes = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _getData() async {
    await hotelController.get_hotel_ids_mapping(hotel_id: widget.hotel_id);
    await hotelController.hotel_view(hotel_id: widget.hotel_id);
    await letUsKnowController.get_hotel(
      let_us_know_hotel_id:
          hotelController.hotel_ids_mapping.value.let_us_know_hid,
    );
    await letUsKnowController.getData(
      hotel_code: letUsKnowController.hotel_code.value,
    );
  }

  int? current_dep;
  int? current_dep_index;
  int? current_rete;

  setDep(value, index) async {
    setState(() {
      current_dep = value;
      current_dep_index = index;
    });
  }

  setRate(value) async {
    setState(() {
      current_rete = value;
    });
  }

  var user_data;
  var check_in_data;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      letUsKnowController.isLoaded.value = false;
      user_data = jsonDecode(GetStorage().read('user_data'));
      check_in_data = jsonDecode(GetStorage().read('check_id_data'));
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width - 10,
        padding: EdgeInsets.only(bottom: 15),
        height: 60,
        child: CustomBtn(
          action: () {
            if (_formKey.currentState!.validate()) {
              if (current_rete == null || current_dep == null) {
                Get.snackbar('Error', "User Created Successfully");
              } else {
                letUsKnowController.postData(
                  name: user_data['name'],
                  phone:
                      "${_countryCode.dropDownValue!.value.toString()}  ${phone.text}",
                  email: user_data['email'],
                  priority_id: current_rete.toString(),
                  room_num: check_in_data['room_number'].toString(),
                  dep_id: current_dep.toString(),
                  hotel_code: letUsKnowController.hotel_code.value,
                  description: notes.text,
                );
              }
            }
          },
          title: Obx(() => (letUsKnowController.submitting.value)
              ? Text('Save', style: AppFont.thirdSecond)
              : CircularProgressIndicator(color: AppColor.third)),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (letUsKnowController.isLoaded.value)
            ? SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.background_card,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: CustomStayHeader(
                            title: Text(
                              hotelController.hotel.value.hotel_name,
                              style: AppFont.boldBlack,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height /
                                3, //minimum height
                          ),
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Let Us Know",
                                style: AppFont.boldBlack,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              row_data(
                                title: 'Full Name',
                                description: user_data['name'],
                              ),
                              row_data(
                                title: 'Room Number',
                                description:
                                    check_in_data['room_number'].toString(),
                              ),
                              row_data(
                                title: 'Email Address',
                                description: user_data['email'].toString(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    // height: 60,
                                    width: 80,
                                    child: CustomDropdownSelect(
                                      hint: ' + ',
                                      enable_search: false,
                                      controller: _countryCode,
                                      option: letUsKnowController.country_codes
                                          .map(
                                            (element) => DropDownValueModel(
                                                name: element.code,
                                                value: element.code),
                                          )
                                          .toList(),
                                      valid: (value) {
                                        if (value == null || value.isEmpty) {
                                          return ('Please Select Your Resort or Cruises');
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    // height: 60,
                                    width: MediaQuery.of(context).size.width /
                                        1.75,
                                    child: CustomTextInput(
                                      controller: phone,
                                      hintText: 'Phone Number',
                                      icon: Icons.phone,
                                      only_number: true,
                                      valid: (value) {
                                        if (value == null || value.isEmpty) {
                                          return ('Phone Number is Required');
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: CustomTextInput(
                                  controller: notes,
                                  hintText: 'Notes',
                                  icon: Icons.phone,
                                  valid: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ('NOte Number is Required');
                                    }
                                  },
                                ),
                              ),
                              department(),
                              SizedBox(
                                height: 15,
                              ),
                              rate(),
                              SizedBox(
                                height: 70,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }

  Widget row_data({required String title, required String description}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFont.midSecond,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                  textAlign: TextAlign.end,
                  description,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.primarySecond,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.3),
        )
      ],
    );
  }

  Widget department() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Departments',
            style: AppFont.smallBoldBlack,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        letUsKnowController.let_us_know_departments.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          child: Card(
                            color: (current_dep_index == index)
                                ? AppColor.primary
                                : AppColor.background_card,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  letUsKnowController
                                      .let_us_know_departments[index].dep_name
                                      .toUpperCase(),
                                  style: (current_dep_index != index)
                                      ? AppFont.tinyGrey
                                      : AppFont.tinyBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () => setDep(
                            letUsKnowController
                                .let_us_know_departments[index].id,
                            index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rate() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var element in letUsKnowController.priorities)
            rate_image(element: element),
          // rate_image(image: 'good.png'),
          // rate_image(image: 'ok.png'),
          // rate_image(image: 'bad.png')
        ],
      ),
    );
  }

  Widget rate_image({required Priorities element}) {
    return InkWell(
      onTap: () => setRate(element.id),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: (current_rete == element.id)
                  ? AppColor.primary
                  : AppColor.background_card,
              // AppColor.background_card,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              '${AppUrl.letUsKnow}/public/geust/${element.image}',
              height: 60,
              width: 60,
              color: (current_rete == element.id)
                  ? AppColor.background_card
                  : AppColor.primary,
            ),
          ),
          Text(
            element.name.toUpperCase(),
            style: AppFont.midTinSecond,
          )
        ],
      ),
    );
  }
}
