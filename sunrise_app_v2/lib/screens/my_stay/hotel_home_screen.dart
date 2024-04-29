import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';

class HotelHomeScreen extends StatefulWidget {
  const HotelHomeScreen({super.key});

  @override
  State<HotelHomeScreen> createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            // width: double.infinity,
            // height: double.infinity,
          ),
          SliderWidget(),
          Positioned(
            // top: 5,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 232, 232),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: CustomStayHeader(
                hotel_name: 'White Hills Resorts',
              ),
            ),
          ),
          Positioned(
            top: 400,
            child: Container(
              height: 5000,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 232, 232),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'resorts Carts.....',
                    style: AppFont.boldBlack,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Color.fromARGB(255, 240, 232, 232),
    //               borderRadius: BorderRadius.all(Radius.circular(8)),
    //             ),
    //           ),
    //           CustomStayHeader(),
    //           CustomCarouselSlider()
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
