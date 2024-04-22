import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';

class SliderWidget extends StatefulWidget {
  SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final hotel_guide_controller = Get.put(HotelGuideController());
  // List images = ['slider1.jpg', 'slider2.jpg', 'slider3.jpg'];

  @override
  int _sliderIndex = 0;
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: double.maxFinite,
        child: AspectRatio(
          aspectRatio: 1.5 / 1,
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
                    print(index);
                    return Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.network(
                            'https://hotelguide.sunrise-resorts.com/attach/' +
                                hotel_guide_controller
                                    .posh_club_slider[_sliderIndex].logo,
                            fit: BoxFit.cover,
                          ),
                        ));
                  },
                  itemCount: 3),
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
                          border: Border.all(color: Colors.black54),
                          shape: BoxShape.circle,
                          color: _sliderIndex == index
                              ? Colors.white54
                              : Colors.transparent,
                        ),
                      );
                    },
                    itemCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
