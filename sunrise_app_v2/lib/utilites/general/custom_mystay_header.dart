import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class CustomStayHeader extends StatefulWidget {
  String search_hint;
  Widget title;
  CustomStayHeader({
    this.search_hint = 'Search Facilities',
    required this.title,
    super.key,
  });

  @override
  State<CustomStayHeader> createState() => _CustomStayHeaderState();
}

class _CustomStayHeaderState extends State<CustomStayHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 53,
                    padding: EdgeInsets.only(right: 8),
                    child: CustomBtn(
                      color: AppColor.second,
                      title: Text('Home'),
                      action: () => {Get.to(() => MainScree())},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 57,
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: CustomTextInput(
                      hintText: widget.search_hint,
                      icon: Icons.search_rounded,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Container(
                  //   height: 53,
                  //   padding: EdgeInsets.only(right: 8),
                  //   child: CustomBtn(
                  //       title: Text('Check In'),
                  //       action: () => {print('Chick in Clicked')}),
                  // ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  // InkWell(
                  //   onTap: () => Get.back(),
                  //   child: Icon(Icons.arrow_back_ios_new),
                  // ),
                  // Text(
                  //   widget.hotel_name,
                  //   style: AppFont.boldBlack,
                  // ),
                  widget.title,
                  Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
