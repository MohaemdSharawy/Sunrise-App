import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/screens/yourcart_screens/category_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class RestaurantScreen extends StatefulWidget {
  // ! This Type to Detect Call Future Function That Get Restaurant Or Bar
  String type;
  int restaurant_hotel_id;
  RestaurantScreen(
      {this.type = 'Restaurant', required this.restaurant_hotel_id, super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final restaurantController = Get.put(RestaurantController());
  // final hotelController = Get.put(HotelController());

  _getData() async {
    // hotelController.hotel_view(hotel_id: widget.restaurant_hotel_id);
    if (widget.type == 'Bar') {
      await restaurantController.get_bars(hotel_id: widget.restaurant_hotel_id);
    } else {
      await restaurantController.get_restaurants(
        hotel_id: widget.restaurant_hotel_id,
      );
    }
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
      body: Obx(() => (restaurantController.loaded.value)
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColor.background_card,
                        // color: Color.fromARGB(255, 240, 232, 232),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: CustomStayHeader(
                        title: Text(
                          restaurantController.hotel_name.value,
                          style: AppFont.boldBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${restaurantController.restaurants.length} Restaurant',
                            style: AppFont.smallBoldBlack,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            child: Icon(Icons.display_settings_sharp),
                          )
                        ],
                      ),
                    ),

                    Wrap(
                      children: [
                        for (var restaurant in restaurantController.restaurants)
                          RestaurantCard(restaurant: restaurant)
                      ],
                    ),
                    // GridView.count(
                    //   crossAxisCount: 2,
                    //   shrinkWrap: true,
                    //   children:
                    //       restaurantController.restaurants.map((restaurant) {
                    //     return RestaurantCard(restaurant: restaurant);
                    //   }).toList(),
                    // ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            )
          : AnimatedLoader()),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;
  RestaurantCard({required this.restaurant, super.key});
  @override
  Widget build(BuildContext context) {
    double name_padding = MediaQuery.of(context).size.height / 5;
    return InkWell(
      onTap: () {
        Get.to(() => CategoryScreen(code: restaurant.code));
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 2.9,
        width: MediaQuery.of(context).size.width / 2.1,
        child: Card(
          color: AppColor.background_card,
          elevation: 0.5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              (restaurant.image != '')
                  ? Ink.image(
                      image: NetworkImage(
                        '${AppUrl.restaurant_domain}assets/uploads/restaurants/${restaurant.image}',
                      ),
                      fit: BoxFit.cover,
                      height: 130,
                    )
                  : Image.asset(
                      'assets/no_image.png',
                      fit: BoxFit.cover,
                      height: 130,
                      width: MediaQuery.of(context).size.width / 2.2,
                    ),
              Positioned(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: (restaurant.white_logo != '')
                      ? Padding(
                          padding: EdgeInsets.all(3),
                          child: Image.network(
                            '${AppUrl.restaurant_domain}assets/uploads/restaurants/${restaurant.white_logo}',
                            height: 50,
                            width: 50,
                          ),
                        )
                      : Image.asset('assets/no_image.png'),
                ),
                left: MediaQuery.of(context).size.width / 3.1,
                top: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: name_padding + 10,
                      left: 12,
                    ),
                    child: Text(
                      // textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      restaurant.restaurant_name,
                      style: AppFont.tinyBlack,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      maxLines: 2,
                      // textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      restaurant.description,
                      style: AppFont.tinyGrey,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
