import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/onboarding_controller.dart';
import 'package:sunrise_app_v2/constant/onboarding_model.dart';
import 'package:sunrise_app_v2/screens/Auth/check_in.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImplement> {
  const CustomSliderOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      physics: const BouncingScrollPhysics(),
      itemCount: onBoardingList.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Container(
            // color: Colors.white,
            child: Column(
              children: [
                if (onBoardingList[index].title != '') ...[
                  headerBtn(),
                  SizedBox(
                    height: 35,
                  ),
                  Image.network(
                    onBoardingList[index].image!,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.9,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    onBoardingList[index].title.toString(),
                    style: AppFont.boldBlack,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    onBoardingList[index].body.toString(),
                    style: AppFont.smallBlack,
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  headerBtn(),
                  SizedBox(
                    height: 35,
                  ),
                  lastSlide()
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget headerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        // (controller.currentPage > 0)
        //     ? Text(
        //         'Previous',
        //         style: AppFont.smallBlack,
        //       )
        //     : Container(),
        TextButton(
          onPressed: () => Get.to(
            () => LoginScreen(),
          ),
          child: Text(
            'Skip',
            style: TextStyle(color: AppColor.primary),
          ),
        )
      ],
    );
  }

  Widget lastSlide() {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Text(
              'Do you have a reservation?',
              style: AppFont.boldBlack,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Text(
              'A met minim non deserunt ullamco est sti aliqua dolor do amet slint. velit officia consequat duls enim velit molit',
              style: AppFont.smallBlack,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: MaterialButton(
                      height: 50,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Get.to(page)
                        Get.to(CheckInScreen());
                      },
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text(
                        'Yes',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 150,
                    child: MaterialButton(
                      height: 50,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // controller.next();
                        Get.to(LoginScreen());
                      },
                      textColor: Colors.white,
                      color: AppColor.primary,
                      child: Text(
                        'No',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
