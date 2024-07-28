import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/wellness_controller.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class SpaScreen extends StatefulWidget {
  String code;
  SpaScreen({this.code = '', super.key});

  @override
  State<SpaScreen> createState() => _SpaScreenState();
}

class _SpaScreenState extends State<SpaScreen> {
  final hotelController = Get.put(HotelController());
  final wellnessController = Get.put(WellnessController());

  _getData() async {
    var check_in_data = jsonDecode(GetStorage().read('check_in_hotel'));
    await hotelController.get_hotel_ids_mapping(hotel_id: check_in_data['id']);
    await hotelController.getSlider(
        type_name: 'Spa Screen', hotel_id: check_in_data['id']);
    await wellnessController.getSpas(
      yourCart_hotel_id: hotelController.hotel_ids_mapping.value.your_cart_hid,
    );
    await wellnessController.getSpaCategories(
      spa_code: wellnessController.spa.value.code,
    );
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  List cards = [
    {'title': 'open', 'description': '15:00 AM'},
    {'title': 'close', 'description': '19:00 AM'},
    {'title': 'Dress Code', 'description': 'Casual'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (wellnessController.spaLoaded.value)
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
                                    Text(
                                        hotelController.hotel.value.hotel_name),
                                    Text(
                                      wellnessController
                                          .spa.value.restaurant_name,
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
                                            child: Text(
                                              wellnessController
                                                  .spa.value.description,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cards.length,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    childAspectRatio: 3 / 2.3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    // crossAxisCount: 2, // Number of columns
                                    // crossAxisSpacing: 2.0,
                                    // // mainAxisSpacing: 0.999999,
                                    // childAspectRatio: 2.5,
                                    // // mainAxisExtent: 1,
                                  ),
                                  itemBuilder: (context, index) => Container(
                                    child: Card(
                                      color: AppColor.background_card,
                                      elevation: 0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              cards[index]['title'],
                                              style: AppFont.midBoldSecond,
                                            ),
                                          ),
                                          Text(
                                            cards[index]['description'],
                                            style: TextStyle(
                                                color: AppColor.primary),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: CustomBtn(
                                    color: AppColor.second,
                                    title: Text('Book'),
                                    action: () => print(''),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                // !TODO
                                // !Show Product OF Spa
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      wellnessController.spaCategories.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Container(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Card(
                                      color: AppColor.background_card,
                                      elevation: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            child: ImageCustom(
                                              image: (wellnessController
                                                          .spaCategories[index]
                                                          .logo !=
                                                      '')
                                                  ? '${AppUrl.restaurant_domain}/assets/uploads/categories/${wellnessController.spaCategories[index].logo}'
                                                  : '${AppUrl.restaurant_domain}/assets/uploads/restaurants/${wellnessController.spa.value.logo}',
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 15,
                                              // bottom: 2,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  wellnessController
                                                      .spaCategories[index]
                                                      .category_name,
                                                  style: AppFont.midBoldSecond,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                                SizedBox(
                                                  height: 9,
                                                ),
                                                Text(
                                                  wellnessController
                                                      .spaCategories[index]
                                                      .description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: AppFont.midTinSecond,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
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
