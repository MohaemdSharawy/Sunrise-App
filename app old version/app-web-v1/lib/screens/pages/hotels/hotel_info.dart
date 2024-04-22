import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/model/hotel_guide/hotel_map_model.dart';

import '../../../utilites/background.dart';
import '../../../utilites/header_screen.dart';
import '../../../utilites/list_expand.dart';

class HotelInfoScreen extends StatefulWidget {
  var h_id;
  HotelInfoScreen({this.h_id, super.key});

  @override
  State<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends State<HotelInfoScreen> {
  final hotelController = Get.put(HotelsController());
  final hotelGuide = Get.put(HotelGuideController());

  HotelInfo add_info = HotelInfo.fromJson(
    {"id": "0", "info": "Hotel Services", "hid": "0", "description": ""},
  );

  late String title;

  List<HotelInfo> hotel_Service = [];

  _getData() async {
    hotelGuide.info_loaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await hotelController.getHotel(hid: widget.h_id);
    if (hotelController.hotel.value.company_id == "2") {
      title = 'Boat Info';
    } else {
      title = 'Hotel Info';
    }

    await hotelGuide.getHotelInfo(h_id: int.parse(widget.h_id));
    hotelGuide.hotel_info.insert(0, add_info);
    hotelGuide.info_loaded.value = true;
    // print(hotelGuide.hotel_info);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListExpandAdapter().getView(),
      body: Obx(
        () {
          return (hotelGuide.info_loaded.value == true)
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
          margin: EdgeInsets.only(top: 35, bottom: 105),
          // padding: EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontSize: 75, fontFamily: 'Northwell'),
              ).tr(),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 150, bottom: 100),
        //   child: Center(
        //     child: SizedBox(
        //       width: 750,
        //       child: ListExpandAdapter(hotel_Service).getView(),
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 200, bottom: 100),
          child: Center(
            child: SizedBox(
              width: 750,
              child: ListExpandAdapter(
                      hotelGuide.hotel_info, hotelGuide.hotel_service)
                  .getView(),
            ),
          ),
        ),

        Container(margin: EdgeInsets.only(top: 50), child: HeaderScreen())
      ],
    );
  }
}
