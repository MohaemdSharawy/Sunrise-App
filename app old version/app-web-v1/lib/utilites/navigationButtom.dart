import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/utilites/img.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import '../controller/interface_controller.dart';

class CustomBottomBar extends StatefulWidget {
  var h_id;
  CustomBottomBar({this.h_id, super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> with BaseController {
  final homeController = Get.put(HomeController());
  final interfaceController = Get.put(InterfaceController());
  final restaurantController = Get.put(RestaurantController());

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
  void initState() {
    // homeController.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 58,
              child: Image.asset(
                Img.get(
                    homeController.cover[homeController.currentIndex.value]),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                width: double.infinity,
                height: 58,
                color: Colors.black.withOpacity(0.7)),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Color.fromARGB(92, 150, 130, 130),
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                elevation: 40.5,
                type: BottomNavigationBarType.fixed,
                currentIndex: homeController.currentIndex.value,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/Home.png',
                      width: 30,
                      height: 30,
                    ),
                    label: tr('Home'),
                  ),
                  if (GetStorage().read('room_num') != null &&
                      GetStorage().read('room_num') != '') ...[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/RoomService.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      label: tr('In Room Dining'),
                    ),
                  ],

                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/Dining.png',
                      width: 30,
                      height: 30,
                    ),
                    label: tr('Dining'),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/Wellness.png',
                      width: 30,
                      height: 30,
                    ),
                    label: tr('Wellness'),
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Image.asset(
                  //     // 'assets/icons/Chatting.png',
                  //     'assets/icons/Let Us Know.png',
                  //     width: 30,
                  //     height: 30,
                  //   ),
                  //   // label: tr('Chat'),
                  //   label: tr('Let Us Know'),
                  // ),
                  //
                  if (GetStorage().read('room_num') != null &&
                      GetStorage().read('room_num') != '') ...[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/Room.png',
                        width: 30,
                        height: 30,
                      ),
                      label: tr('Maintenance'),
                    ),
                  ]
                ],
                onTap: (index) async {
                  if (GetStorage().read('room_num') != null &&
                      GetStorage().read('room_num') != '') {
                    if (index == 1) {
                      // print('test');
                      await restaurantController.getRoomService(
                          hotel_id: widget.h_id);
                      if (restaurantController.room_service.isNotEmpty) {
                        // print(restaurantController.room_service[0].code);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context,
                            'categories/${restaurantController.room_service[0].code}');
                      } else {
                        Get.snackbar(
                          'Message',
                          // '${error}',
                          'Room Service Not Available',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    } else {
                      homeController.currentIndex.value = index;
                      print(homeController
                          .links[homeController.currentIndex.value]);
                      Navigator.pushNamed(context,
                          '/${homeController.links[homeController.currentIndex.value]}/${widget.h_id}');
                    }
                  } else {
                    homeController.currentIndex.value = index;
                    print(homeController
                        .links[homeController.currentIndex.value]);
                    Navigator.pushNamed(context,
                        '/${homeController.guest_links[homeController.currentIndex.value]}/${widget.h_id}');
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
