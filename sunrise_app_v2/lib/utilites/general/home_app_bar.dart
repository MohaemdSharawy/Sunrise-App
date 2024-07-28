import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';

class HomeAppBar extends StatelessWidget {
  var scaffoldKey;
  HomeAppBar({this.scaffoldKey, super.key});

  final hotelController = Get.find<HotelController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
            speace: 20.0,
            back_icon: true,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                    scaffoldKey.currentState?.openDrawer();
                  },
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'posh club',
                      style: AppFont.tinyBlack,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        overflow: TextOverflow.visible,
                        hotelController.hotel.value.hotel_name,
                        style: AppFont.tinyBlack,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColor.primary,
                          size: 20,
                        ),
                        Text('${hotelController.hotel.value.group.name}, '),
                        Text('${hotelController.hotel.value.group.country}')
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 7,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mail_outlined),
                        Icon(Icons.phone_outlined),
                        Icon(Icons.favorite_outline)
                      ],
                    ),
                    Row(
                      children: [
                        Text('(4.9)'),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
