import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/onboarding_controller.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImplement> {
  const CustomButtonOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 30),
      height: 55.0,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
        onPressed: () {
          controller.next();
        },
        textColor: Colors.white,
        color: AppColor.primary,
        child: Text(
          'Next',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
