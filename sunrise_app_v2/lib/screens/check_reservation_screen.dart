import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/screens/Auth/check_in.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/screens/home_screen.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';

class CheckHaveReservation extends StatefulWidget {
  const CheckHaveReservation({super.key});

  @override
  State<CheckHaveReservation> createState() => _CheckHaveReservationState();
}

class _CheckHaveReservationState extends State<CheckHaveReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
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
                        textColor: AppColor.third,
                        color: AppColor.second,
                        child: Text(
                          'Yes',
                          style: AppFont.midThird,
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
                          Get.to(MainScree());
                        },
                        textColor: Colors.white,
                        color: AppColor.primary,
                        child: Text(
                          'No',
                          style: AppFont.midThird,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
