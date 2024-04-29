import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/custom_btn_navgation_controller.dart';
import 'package:sunrise_app_v2/screens/my_stay/my_stay_main.dart';

class MainScree extends StatefulWidget {
  const MainScree({super.key});

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {
  final navigationController = Get.put(CustomNavigationNController());
  // int currentIndex = 0;

  update_select(index) {
    print(navigationController
        .screen_names[navigationController.selected_type.value]![index]);
    if (navigationController
            .screen_names[navigationController.selected_type.value]![index]
            .toString() ==
        "My Stay") {
      Get.to(
        () => MyStayMain(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 400),
      );
    } else {
      navigationController.current_index.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: navigationController
                .screens[navigationController.selected_type.value]
            ?[navigationController.current_index.value],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: navigationController.current_index.value,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => update_select(index),
          items: [
            for (var i = 0;
                i <
                    navigationController
                        .screen_names[navigationController.selected_type.value]!
                        .length;
                i++)
              BottomNavyBarItem(
                icon: navigationController
                    .screen_icons[navigationController.selected_type.value]![i],
                title: Text(navigationController.screen_names[
                    navigationController.selected_type.value]![i]),
                activeColor: AppColor.primary,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
