import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/onboarding_model.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/screens/Auth/register.dart';

abstract class OnBoardingController extends GetxController {
  next();

  onPageChanged(int index);
}

class OnBoardingControllerImplement extends OnBoardingController {
  int currentPage = 0;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  next() {
    currentPage++;

    if (currentPage > onBoardingList.length - 1) {
      Get.off(LoginScreen());

      /// Get.offAll(() => HotelScreen());
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }
}
