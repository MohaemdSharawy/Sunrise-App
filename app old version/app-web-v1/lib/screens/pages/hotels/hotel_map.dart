import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';

import '../../../controller/hotel_controller.dart';
import '../../../utilites/background.dart';
import '../../../utilites/header_screen.dart';
import 'package:photo_view/photo_view.dart';

class HotelMapScreen extends StatefulWidget {
  var h_id;
  HotelMapScreen({this.h_id, super.key});

  @override
  State<HotelMapScreen> createState() => _HotelMapScreenState();
}

class _HotelMapScreenState extends State<HotelMapScreen> {
  final hotelController = Get.put(HotelsController());
  final hotelGuide = Get.put(HotelGuideController());

  _getData() async {
    hotelGuide.map_loaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await hotelGuide.getHotelMap(h_id: int.parse(widget.h_id));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (hotelGuide.map_loaded.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        // BackGroundWidget(),
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        Container(
          // margin: EdgeInsets.only(top: 35, bottom: 25),
          // padding: EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hotel Map',
                style: TextStyle(
                    color: Colors.white, fontSize: 75, fontFamily: 'Northwell'),
              ).tr(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 150, top: 160),
          child: Center(
            child: SizedBox(
              width: 750,
              child: InteractiveViewer(
                child: (hotelGuide.hotel_map.length > 0)
                    ? Image.network(
                        'https://hotelguide.sunrise-resorts.com/attach/${hotelGuide.hotel_map[0].name}',
                        height: 800,
                      )
                    : Text(
                        'Sorry Not Available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Sans-bold',
                        ),
                      ),
              ),
            ),
          ),
        ),

        Container(margin: EdgeInsets.only(top: 50), child: HeaderScreen())
      ],
    );
  }
}
