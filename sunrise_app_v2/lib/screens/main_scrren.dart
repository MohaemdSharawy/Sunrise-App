import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/custom_btn_navgation_controller.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/screens/check_reservation_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/my_stay_main.dart';

class MainScree extends StatefulWidget {
  const MainScree({super.key});

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {
  final navigationController = Get.put(CustomNavigationNController());
  // int currentIndex = 0;

  @override
  void initState() {
    if (GetStorage().read('user_token') == null) {
      navigationController.selected_type.value = 'outsider';
    } else {
      navigationController.selected_type.value = 'auth';
    }
    super.initState();
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
  update_select(index) {
    print(navigationController
        .screen_names[navigationController.selected_type.value]![index]);
    if (navigationController
            .screen_names[navigationController.selected_type.value]![index]
            .toString() ==
        "My Stay") {
      if (GetStorage().read('user_token') != null) {
        if (GetStorage().read('check_id_data') != null) {
          Get.to(
            () => MyStayMain(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 400),
          );
        } else {
          Get.snackbar('message', "You need Check In First");
          Get.to(CheckHaveReservation());
        }
      } else {
        Get.snackbar('message', "You need Login First");

        Get.to(LoginScreen());
      }
    } else {
      setState(
        () {
          navigationController.current_index.value = index;
        },
      );
      // navigationController.current_index.value = index;
    }
  }

  @override
  List<String> brand_list = [
    'Sunrise',
    'Grand Select',
    'Lavish',
    'Meraki',
    'Cruise'
  ];
  // var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:
          navigationController.screens[navigationController.selected_type.value]
              ?[navigationController.current_index.value],
      bottomNavigationBar: Container(
        // margin: EdgeInsets.all(20),
        height: size.width * .180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          // borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: navigationController
              .screens[navigationController.selected_type.value]?.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              update_select(index);
              // setState(
              //   () {
              //     navigationController.current_index.value = index;
              //   },
              // );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == navigationController.current_index.value
                        ? 0
                        : size.width * .029,
                    right:
                        (navigationController.selected_type.value == 'outsider')
                            ? size.width * .0922
                            : size.width * .0322,
                    left:
                        (navigationController.selected_type.value == 'outsider')
                            ? size.width * .0922
                            : size.width * .0322, //.0722
                  ),
                  width: size.width * .128,
                  height: index == navigationController.current_index.value
                      ? size.width * .014
                      : 0,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      navigationController.screen_icons[
                          navigationController.selected_type.value]![index],
                      size: size.width * .076,
                      color: index == navigationController.current_index.value
                          ? AppColor.primary
                          : Colors.black,
                    ),
                    Text(
                      navigationController.screen_names[
                          navigationController.selected_type.value]![index],
                      style: AppFont.tinyBlack,
                    )
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      // body: navigationController
      //         .screens[navigationController.selected_type.value]
      //     ?[navigationController.current_index.value],
      // bottomNavigationBar: BottomNavyBar(
      //   selectedIndex: navigationController.current_index.value,
      //   showElevation: true,
      //   itemCornerRadius: 8,
      //   curve: Curves.easeInBack,
      //   onItemSelected: (index) => update_select(index),
      //   items: [
      //     for (var i = 0;
      //         i <
      //             navigationController
      //                 .screen_names[navigationController.selected_type.value]!
      //                 .length;
      //         i++)
      //       BottomNavyBarItem(
      //         icon: navigationController
      //             .screen_icons[navigationController.selected_type.value]![i],
      //         title: Text(navigationController.screen_names[
      //             navigationController.selected_type.value]![i]),
      //         activeColor: AppColor.primary,
      //         textAlign: TextAlign.center,
      //       ),
      //   ],
      // ),
    );
  }
}
