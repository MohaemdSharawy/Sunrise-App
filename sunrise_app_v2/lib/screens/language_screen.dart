import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  var selectedOption = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              // width: double.infinity,
              // height: double.infinity,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              // color: AppColor.primary,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back_ios_new_sharp),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Chose Your Language',
                        style: AppFont.midBlack,
                      ),
                      Container()
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CustomTextInput(
                      hintText: 'Find Language',
                      icon: Icons.language,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height, //minimum height
              ),
              margin: EdgeInsets.only(top: 150),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.background_card,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Container(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('English'),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/flags/en.jpeg',
                          height: 50.0,
                          width: 50.0,
                        ),
                      )
                    ],
                  ),
                  leading: Radio(
                    value: 'en',
                    groupValue: selectedOption,
                    splashRadius: 20, // Change the splash radius when clicked
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
