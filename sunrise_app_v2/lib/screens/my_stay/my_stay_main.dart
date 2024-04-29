import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/mystay_navgation_contoller.dart';

class MyStayMain extends StatefulWidget {
  const MyStayMain({super.key});

  @override
  State<MyStayMain> createState() => _MyStayMainState();
}

class _MyStayMainState extends State<MyStayMain> {
  final myStayNavController = Get.put(MyStayNavNController());

  void update_select(index) {
    myStayNavController.current_index.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: myStayNavController
            .screens[myStayNavController.current_index.value],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: myStayNavController.current_index.value,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => update_select(index),
          items: [
            for (var i = 0; i < myStayNavController.screens_name.length; i++)
              BottomNavyBarItem(
                icon: myStayNavController.screens_icon[i],
                title: Text(myStayNavController.screens_name[i]),
                activeColor: AppColor.primary,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
