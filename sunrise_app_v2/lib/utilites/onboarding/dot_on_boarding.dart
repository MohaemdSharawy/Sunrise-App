import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/onboarding_model.dart';
import 'package:sunrise_app_v2/controllers/onboarding_controller.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImplement>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            onBoardingList.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 5),
              duration: const Duration(milliseconds: 900),
              width: controller.currentPage == index ? 20.0 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
