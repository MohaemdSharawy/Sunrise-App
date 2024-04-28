import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/custom_btn_navgation_controller.dart';

class MainScree extends StatefulWidget {
  const MainScree({super.key});

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {
  final navigationController = Get.put(CustomNavigationNController());
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: navigationController.screens['auth']?[0],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: AppColor.primary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: AppColor.primary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text(
              'Notifications',
            ),
            activeColor: AppColor.primary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: AppColor.primary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
