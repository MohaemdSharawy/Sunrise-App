import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/facilities_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_gallery_view.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class FacilityViewScreen extends StatefulWidget {
  int facility_id;
  FacilityViewScreen({required this.facility_id, super.key});

  @override
  State<FacilityViewScreen> createState() => _FacilityViewScreenState();
}

class _FacilityViewScreenState extends State<FacilityViewScreen> {
  final facilityController = Get.put(Facilities_controller());
  final hotel_controller = Get.put(HotelController());

  _getData() async {
    //     await hotel_controller.getSlider(
    //   type_name: 'Entertainment Screen',
    //   hotel_id: widget.hotel_id,
    // );
    await facilityController.viewFacility(facility_id: widget.facility_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      facilityController.facility_load.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (facilityController.facility_load.value)
            ? SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            // width: double.infinity,
                            // height: double.infinity,
                          ),
                          SliderWidget(
                            height: 350,
                          ),
                          Positioned(
                            // top: 5,
                            child: Container(
                              // height: 180,
                              decoration: BoxDecoration(
                                color: AppColor.background_card,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: CustomStayHeader(
                                title: Column(
                                  children: [
                                    Text(hotel_controller
                                        .hotel.value.hotel_name),
                                    Text(
                                      facilityController.facility.value.name,
                                      style: AppFont.boldBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height /
                                  3, //minimum height
                            ),
                            margin: EdgeInsets.only(top: 330),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.background_card,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Description',
                                            style: AppFont.smallBoldBlack,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text(facilityController
                                                .facility.value.description),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: facilityController
                                      .facility.value.cards.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Number of columns
                                    crossAxisSpacing: 5.0,
                                    // mainAxisSpacing: 0.999999,
                                    childAspectRatio: 2.5,
                                    // mainAxisExtent: 1,
                                  ),
                                  itemBuilder: (context, index) => Container(
                                    child: Card(
                                      color: AppColor.background_card,
                                      elevation: 0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(facilityController
                                                .facility
                                                .value
                                                .cards[index]
                                                .title),
                                          ),
                                          Text(
                                            facilityController.facility.value
                                                .cards[index].desorption,
                                            style: TextStyle(
                                                color: AppColor.primary),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    'Gallery',
                                    style: AppFont.smallBlack,
                                  ),
                                ),
                                CustomGalleryView(
                                  images:
                                      facilityController.facility.value.gallery,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: WidgetDotFade(
                  color: AppColor.primary,
                ),
              ),
      ),
    );
  }
}
