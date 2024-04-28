import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/onboarding_controller.dart';
import 'package:sunrise_app_v2/utilites/onboarding/btn_on_boarding.dart';
import 'package:sunrise_app_v2/utilites/onboarding/dot_on_boarding.dart';
import 'package:sunrise_app_v2/utilites/onboarding/slide_on_boarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  int current_page = 0;

  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImplement());

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 20, top: 25),
          child: Column(children: [
            // headerBtn(),
            Expanded(
              flex: 3,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  CustomDotControllerOnBoarding(),
                  Spacer(
                    flex: 2,
                  ),
                  CustomButtonOnBoarding(),
                ],
              ),
            ),
            // imageSection(),
            // infoSection(),
            // steps(),
          ]),
        ),
      ),
      // appBar: AppBar(title: T), ),
    );
  }

////
  // Widget headerBtn() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       (current_page > 0)
  //           ? Text(
  //               'Previous',
  //               style: AppFont.smallBlack,
  //             )
  //           : Container(),
  //       Text(
  //         'Skip',
  //         style: AppFont.smallBlack,
  //       ),
  //     ],
  //   );
  // }

  // Widget imageSection() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 55),
  //     child: Image.network(
  //       'https://d1wo7kaelp5eck.cloudfront.net/sunrise-resorts.com-1611976553/cms/cache/v2/6492d5df438c7.jpg/1920x1080/fit;c:0,178,4000,2427;fp:0,45/80/a5dc371c6a95931a49296396e224ccb7.jpg',
  //     ),
  //   );
  // }

  // Widget infoSection() {
  //   return Container(
  //     padding: EdgeInsets.only(left: 15, right: 7, top: 20),
  //     // margin: EdgeInsets.only(top: 20),
  //     child: Column(
  //       children: [
  //         Text(
  //           pageInfo[current_page]['title']!,
  //           style: AppFont.boldBlack,
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(
  //           height: 15,
  //         ),
  //         Text(
  //           pageInfo[current_page]['desorption']!,
  //           style: AppFont.smallBlack,
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget steps() {
  //   return Container();
  //   // return GetBuilder(
  //   //   builder: (controller) => Row(
  //   //     mainAxisAlignment: MainAxisAlignment.center,
  //   //     children: [
  //   //       ...List.generate(
  //   //         3,
  //   //         (index) => AnimatedContainer(
  //   //           margin: const EdgeInsets.only(right: 5),
  //   //           duration: const Duration(milliseconds: 900),
  //   //           width: current_page == index ? 20.0 : 6,
  //   //           height: 6,
  //   //           decoration: BoxDecoration(
  //   //             color: Colors.teal,
  //   //             borderRadius: BorderRadius.circular(10),
  //   //           ),
  //   //         ),
  //   //       ),
  //   //     ],
  //   //   ),
  //   // );
  // }

  // Widget nextBtn() {
  //   return InkWell();
  // }
}
