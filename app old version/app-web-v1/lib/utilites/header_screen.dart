import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/utilites/hotel_name.dart';
import 'package:tucana/utilites/language_widget.dart';
import 'package:tucana/utilites/profile_header.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/app_constant.dart';
import '../controller/base_controller.dart';
import '../controller/hotel_controller.dart';
import '../controller/interface_controller.dart';
import 'dart:html' as htmls;
import 'package:easy_localization/easy_localization.dart';

import 'news_slider.dart';

class HeaderScreen extends StatelessWidget with BaseController {
  var h_id;
  HeaderScreen({this.h_id, super.key});

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

  getLink(type) async {
    showLoading();

    await interfaceController.getInterface(
      hotel_id: h_id,
      interfaceType: type,
    );

    _launchUrl();
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    void updateLang(lang) {
      // ignore: deprecated_member_use
      context.locale = lang;
      print(context.locale);
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
              backgroundColor: Colors.transparent,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
              elevation: 0,
              actions: <Widget>[
                LanguageWidget(),
                (h_id != null && h_id != '')
                    ? PopupMenuButton(
                        color: Colors.black,
                        icon: Icon(Icons.library_books_sharp),
                        // // Callback that sets the selected popup menu item.
                        onSelected: (item) {
                          // print(item);
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('Hotel Info'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/Hotel Info.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href =
                                  '#/hotel_info/${h_id}';
                              // Navigator.pushNamed(context, '/hotel_info/${h_id}');
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('Hotel Map'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/Hotel Map.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href =
                                  '#/hotel_map/${h_id}';

                              // Navigator.pushNamed(context, '/hotel_map/${h_id}');
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('Entertainment'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/Entertainment.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href =
                                  '#/entertainment/${h_id}';

                              // Navigator.pushNamed(
                              //     context, '/entertainment/${h_id}');
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('Let Us Know'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/Let Us Know.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href =
                                  '#/let_us_know/${h_id}';
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('Rate Us'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/FAQS.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href = '#/rate/${h_id}';
                              // Navigator.pushNamed(context, '/rate/${h_id}');
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('TV Programs'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/TV.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href = '#/tv_guide/${h_id}';

                              // Navigator.pushNamed(context, '/tv_guide/${h_id}');
                            },
                          ),
                          PopupMenuItem(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('City Guide'),
                                  style: menuStyle,
                                ),
                                Image.asset(
                                  'assets/icons/Hotel Map.png',
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            onTap: () {
                              htmls.window.location.href =
                                  '#/city_guide/${h_id}';
                              // Navigator.pushNamed(context, '/city_guide/${h_id}');
                            },
                          ),
                        ],
                      )
                    : Container(),

                //
                //
                //
                ///Profile Guest
                //
                //

                (GetStorage().read("room_num") != null &&
                        GetStorage().read("room_num") != '')
                    ? ProfileWidget()
                    : Container(),
              ],
            ),
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
