import 'package:badges/badges.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/screens/category_screen.dart';
import 'package:tucana/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:get/get.dart';
import 'package:tucana/controller/card_controller.dart';
import 'package:tucana/screens/my_order.dart';
import 'package:tucana/screens/welcome_screen.dart';
import 'package:tucana/utilites/language_widget.dart';
import 'package:tucana/utilites/profile_header.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/app_constant.dart';
import '../controller/hotel_controller.dart';
import '../controller/interface_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:html' as htmls;

import 'hotel_name.dart';
import 'news_slider.dart';

class AppBarWidget extends StatelessWidget with BaseController {
  var screen;
  var notback;
  var h_id;
  AppBarWidget({this.h_id, this.screen, this.notback, super.key});
  final cardController = Get.put(CardController());
  final interfaceController = Get.put(InterfaceController());
  final hotelsController = Get.put(HotelsController());
  TextStyle menuStyle = TextStyle(color: Colors.white);

  Future<void> _launchUrl() async {
    showLoading();
    if (await canLaunchUrl(Uri.parse(interfaceController.interfaceVal.value))) {
      await launchUrl(Uri.parse(interfaceController.interfaceVal.value),
          mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available Now PLease Try Again Later',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    void updateLang(lang) {
      context.locale = lang;
      GetStorage().write(
        'lang',
        context.locale.toString(),
      );
      htmls.window.location.reload();
    }

    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Container(
            height: kToolbarHeight,
            child: AppBar(
                // leading: BackButton(
                //   onPressed: () {
                //     if (notback) {
                //       Get.to(screen);
                //     } else {
                //       Get.back();
                //     }
                //   },
                // ),
                // automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
                elevation: 0,
                actions: <Widget>[
                  // InkWell(
                  //   onTap: (() {
                  //     Get.to(WelcomeScreen());
                  //   }),
                  //   child: Image.asset(
                  //     'assets/icons/Home.png',
                  //     width: 40,
                  //     height: 40,
                  //   ),
                  // ),
                  LanguageWidget(),
                  SizedBox(width: 10),
                  Badge.Badge(
                    badgeContent: Obx((() =>
                        Text(cardController.my_order.length.toString()))),
                    // Text(cardController.my_order.length.toString()),
                    position: BadgePosition.topEnd(top: 10),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Get.to(MyOrderScreen());
                        Navigator.pushNamed(context, '/my-orders/${h_id}');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  (GetStorage().read("room_num") != null &&
                          GetStorage().read("room_num") != '')
                      ? ProfileWidget()
                      : Container(),

                  // InkWell(
                  //   onTap: (() async {
                  //     await interfaceController.getInterface(
                  //       hotel_id: int.parse(hotelsController
                  //           .hotels[hotelsController.selectHotel.value].id),
                  //       interfaceType: 'CHAT',
                  //     );
                  //     _launchUrl();
                  //   }),
                  //   child: Image.asset(
                  //     'assets/icons/Chatting.png',
                  //     width: 40,
                  //     height: 40,
                  //   ),
                  // ),
                ]),
          ),
        ),
        SizedBox(height: 15),
        if (h_id != null) ...[
          Center(
            child: HotelNameWidget(hid: h_id),
          ),
        ],
        // Center(child: SizedBox(width: 750, child: NewsSliderWidget())),
      ],
    );
  }
}
