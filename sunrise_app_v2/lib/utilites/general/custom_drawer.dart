import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_facilities_screen.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_gallery.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_offers.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_rooms_screen.dart';
import 'package:sunrise_app_v2/screens/hotel_book_home.dart';
import 'package:sunrise_app_v2/screens/my_stay/dining_screen.dart';

class CustomDrawer extends StatelessWidget {
  var scaffoldKey;
  CustomDrawer({
    required this.scaffoldKey,
    super.key,
  });
  final hotel_controller = Get.find<HotelController>();

  @override
  Widget build(BuildContext context) {
    List<Map> drawer_item = [
      {
        'name': 'Home',
        'icon': Icon(Icons.home_outlined),
        'link': 'hotel_home_booking'
      },
      {
        'name': 'Rooms',
        'icon': Icon(Icons.bed_outlined),
        'link': 'hotel_rooms'
      },
      {
        'name': 'Restaurants',
        'icon': Icon(Icons.fastfood_outlined),
        'link': 'restaurant'
      },
      {
        'name': 'Facilities',
        'icon': Icon(Icons.food_bank_outlined),
        'link': 'hotel_facilities'
      },
      // {
      //   'name': 'Location',
      //   'icon': Icon(Icons.add_location_alt_rounded),
      //   'link': 'hotel_location'
      // },
      // {
      //   'name': 'Reviews',
      //   'icon': Icon(Icons.rate_review),
      //   'link': 'hotel_reviews'
      // },
      {
        'name': 'offer',
        'icon': Icon(Icons.percent_outlined),
        'link': 'hotel_offers',
      },
      {
        'name': 'Gallery',
        'icon': Icon(Icons.image_outlined),
        'link': 'hotel_gallery',
      },
    ];
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.only(top: 100, bottom: 100),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'posh club',
                        style: AppFont.tinyBlack,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                              overflow: TextOverflow.visible,
                              hotel_controller.hotel.value.hotel_name,
                              style: AppFont.smallBlack,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.primary,
                            size: 20,
                          ),
                          Text("${hotel_controller.hotel.value.group.name}, "),
                          Text(hotel_controller.hotel.value.group.country)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => scaffoldKey.currentState?.closeDrawer(),
                    icon: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            for (var elemet in drawer_item)
              DrawerList(
                  name: elemet['name'],
                  icon: elemet['icon'],
                  link: elemet['link'],
                  hotel_id: hotel_controller.hotel.value.id,
                  scaffoldKey: scaffoldKey)
          ],
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  String name;
  Icon icon;
  String link;
  int hotel_id;
  var scaffoldKey;
  DrawerList({
    required this.name,
    required this.icon,
    required this.link,
    this.scaffoldKey,
    required this.hotel_id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map links = {
      'hotel_home_booking': () => HotelHomeBookingScreen(hotel_id: hotel_id),
      'hotel_gallery': HotelGallery(hotel_id: hotel_id),
      'hotel_facilities': HotelFacilitiesScreen(hotel_id: hotel_id),
      'hotel_offers': HotelOffersScreen(hotel_id: hotel_id),
      'restaurant': DinningScreen(hotel_id: hotel_id),
      'hotel_rooms': HotelRoomsScreen(hotel_id: hotel_id)
    };
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 4),
      child: Column(
        children: [
          InkWell(
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    icon,
                    // Icon(Icons.home_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      name,
                      style: AppFont.midTinSecond,
                    ),
                  ],
                ),
              ),
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                Get.off(links[link]);
              }),
          Divider(),
        ],
      ),
    );
  }
}
