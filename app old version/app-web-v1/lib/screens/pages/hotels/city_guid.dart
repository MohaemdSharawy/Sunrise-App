import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/utilites/list_expand.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/hotel_controller.dart';
import '../../../utilites/background.dart';
import '../../../utilites/header_screen.dart';
import 'package:photo_view/photo_view.dart';

class CityGuideScreen extends StatefulWidget {
  var h_id;
  CityGuideScreen({this.h_id, super.key});

  @override
  State<CityGuideScreen> createState() => _CityGuideScreenState();
}

class _CityGuideScreenState extends State<CityGuideScreen> {
  final hotelController = Get.put(HotelsController());
  final hotelGuide = Get.put(HotelGuideController());

  _getData() async {
    hotelGuide.city_loaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await hotelGuide.getCityGuid(h_id: int.parse(widget.h_id));
    await hotelGuide.getCityGuidePdf(h_id: int.parse(widget.h_id));
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(
        'https://hotelguide.sunrise-resorts.com/attach/${hotelGuide.city_guide_pdf.value}'))) {
      await launchUrl(
          Uri.parse(
              'https://hotelguide.sunrise-resorts.com/attach/${hotelGuide.city_guide_pdf.value}'),
          mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
          return (hotelGuide.city_loaded.value == true)
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'City Guide',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 75,
                        fontFamily: 'Northwell'),
                  ).tr(),
                ],
              ),
              if (hotelGuide.city_guide_pdf != '') ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.6), elevation: 0),
                  child: Text(
                    "PDF",
                  ).tr(),
                  onPressed: () {
                    _launchUrl();
                  },
                ),
              ]
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 150, bottom: 100),
          child: Center(
            child: SizedBox(
              width: 750,
              child: ListExpandAdapter(hotelGuide.city_guide, []).getView(),
            ),
          ),
        ),
        // (hotelGuide.city_guide.length > 0)
        //     ? Container(
        //         margin: EdgeInsets.only(bottom: 100, top: 100),
        //         child: Center(
        //           child: SizedBox(
        //             width: 750,
        //             child: InteractiveViewer(
        //               child: Image.network(
        //                 'https://hotelguide.sunrise-resorts.com/attach/${hotelGuide.city_guide[0].name}',
        //                 height: 800,
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     : Container(
        //         child: Center(
        //           child: Text(
        //             'Sorry Not Available!',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 50,
        //               fontFamily: 'Sans-bold',
        //             ),
        //           ),
        //         ),
        //       ),

        HeaderScreen()
      ],
    );
  }
}
