import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/screens/yourcart_screens/category_screen.dart';
import 'package:sunrise_app_v2/screens/yourcart_screens/restaurant_booking_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/expanded_text.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';
import 'package:sunrise_app_v2/utilites/yourcard/outlet_card_info.dart';

class RestaurantInfoScreen extends StatefulWidget {
  String restaurant_code;
  RestaurantInfoScreen({required this.restaurant_code, super.key});

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  final restaurantController = Get.put(RestaurantController());

  String day_selected = DateFormat('EEEE').format(DateTime.now());

  _getData() async {
    await restaurantController.getRestaurantInfo(
      restaurant_code: widget.restaurant_code,
      day: day_selected,
    );
    await restaurantController.getMails(
        restaurant_code: widget.restaurant_code);
  }

  _updateWorkinDay() async {
    await restaurantController.updateRestaurantWorkingDays(
      restaurant_code: widget.restaurant_code,
      day: day_selected,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (restaurantController.info_loaded.value)
            ? SingleChildScrollView(
                child: Container(
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
                                    // Text(restaurantController.restaurant.value.h),
                                    Text(
                                      restaurantController
                                          .restaurant.value.restaurant_name,
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
                                            child: ExpandableText(
                                              restaurantController
                                                  .restaurant.value.description,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                if (restaurantController
                                    .singleWorkingDay.isNotEmpty) ...[
                                  for (var working_day
                                      in restaurantController.singleWorkingDay)
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: OutLetCardScreen(
                                            title: 'Open',
                                            description: working_day.from_time,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: OutLetCardScreen(
                                            title: 'Close',
                                            description: working_day.to_time,
                                          ),
                                        ),
                                      ],
                                    ),
                                ] else ...[
                                  OutLetCardScreen(
                                    title: 'Open',
                                    description: 'All Day',
                                  ),
                                ],
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        child: CustomBtn(
                                          color: AppColor.primary,
                                          title: Text('View Menu'),
                                          action: () => Get.to(
                                            CategoryScreen(
                                              code: widget.restaurant_code,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        child: CustomBtn(
                                          color: AppColor.second,
                                          title: Text('Book'),
                                          action: () => Get.to(
                                            BookingRestaurantScreen(
                                              restaurant_code:
                                                  restaurantController
                                                      .restaurant.value.code,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: restaurantController.meal.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          // Container()
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
                                            child: (restaurantController
                                                        .restaurant
                                                        .value
                                                        .image !=
                                                    '')
                                                ? ImageCustom(
                                                    image:
                                                        '${AppUrl.restaurant_domain}/assets/uploads/restaurants/${restaurantController.restaurant.value.image}',
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    'assets/no_image.png',
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
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
                                                  restaurantController
                                                      .meal[index]
                                                      .main_category_name,
                                                  style: AppFont.midBoldSecond,
                                                  overflow:
                                                      TextOverflow.visible,
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
