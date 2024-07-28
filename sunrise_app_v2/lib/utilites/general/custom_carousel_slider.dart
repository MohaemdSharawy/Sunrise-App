import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class SliderWidget extends StatefulWidget {
  double height;
  double radius;
  bool counter_on_image;
  SliderWidget({
    this.counter_on_image = true,
    this.height = 500.0,
    this.radius = 10.0,
    Key? key,
  }) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final hotel_controller = Get.put(HotelController());
  @override

  // List images = ['slider1.jpg', 'slider2.jpg', 'slider3.jpg'];
  // List<String> images = [
  //   'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
  //   'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
  //   'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
  // ];
  @override
  int _sliderIndex = 0;
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: Container(
              height: widget.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                      options: CarouselOptions(
                        height: double.maxFinite,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        autoPlayInterval: Duration(seconds: 5),
                        enlargeCenterPage: false,
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _sliderIndex = index;
                          });
                        },
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ImageCustom(
                                image: AppUrl.main_domain +
                                    'uploads/hotel_gallery/' +
                                    hotel_controller.sliders[_sliderIndex],
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                      itemCount: hotel_controller.sliders.length),
                  if (widget.counter_on_image) ...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 150),
                        height: 50.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black54),
                                shape: BoxShape.circle,
                                color: _sliderIndex == index
                                    ? AppColor.primary
                                    : AppColor.second,
                              ),
                            );
                          },
                          itemCount: hotel_controller.sliders.length,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          if (!widget.counter_on_image) ...[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black54),
                        shape: BoxShape.circle,
                        color: _sliderIndex == index
                            ? AppColor.primary
                            : AppColor.second,
                      ),
                    );
                  },
                  itemCount: hotel_controller.sliders.length,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
