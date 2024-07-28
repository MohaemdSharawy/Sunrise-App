import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/facilities_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/hotel/facility_view_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class HotelFacilitiesScreen extends StatefulWidget {
  int hotel_id;
  HotelFacilitiesScreen({required this.hotel_id, super.key});

  @override
  State<HotelFacilitiesScreen> createState() => _HotelFacilitiesScreenState();
}

class _HotelFacilitiesScreenState extends State<HotelFacilitiesScreen> {
  final facilityController = Get.put(Facilities_controller());
  final hotelController = Get.find<HotelController>();

  _getData() async {
    await hotelController.getSlider(
        type_name: 'Facility Screen', hotel_id: widget.hotel_id);

    print(hotelController.sliders);

    await hotelController.hotel_view(hotel_id: widget.hotel_id);
    await facilityController.getHotelFacilities(hotel_id: widget.hotel_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      facilityController.facilities_load.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (facilityController.facilities_load.value)
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
                          SliderWidget(),
                          Positioned(
                            // top: 5,
                            child: Container(
                              // height: 150,
                              decoration: BoxDecoration(
                                color: AppColor.background_card,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: CustomStayHeader(
                                title: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    hotelController.hotel.value.hotel_name,
                                    style: AppFont.boldBlack,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                            margin: EdgeInsets.only(top: 350),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Facilities',
                                      style: AppFont.midBlack,
                                    ),
                                  ),
                                ),
                                // Text('share')
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      facilityController.facilities.length,
                                  itemBuilder: (context, index) => FacilityCard(
                                    name: facilityController
                                        .facilities[index].name,
                                    image: facilityController
                                        .facilities[index].image,
                                    id: facilityController.facilities[index].id,
                                  ),
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
            : AnimatedLoader(),
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  String name;
  String image;
  int id;
  FacilityCard({
    required this.name,
    required this.image,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => FacilityViewScreen(facility_id: id)),
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Image.network(
                AppUrl.main_domain + 'uploads/facilities/' + image,
                height: 130,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                height: 130,
                color: Colors.black.withOpacity(0.15),
              ),
              Positioned(
                child: Container(
                  height: 40,
                  width: 40,
                  color: AppColor.card_label_back_ground,
                  child: Icon(
                    Icons.pool,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3,
                top: 100,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
