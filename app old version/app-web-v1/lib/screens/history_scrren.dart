// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/pages/history/guest_activity_order.dart';
import 'package:tucana/screens/pages/history/guest_maintenance.dart';
import 'package:tucana/screens/pages/history/guest_order.dart';
import 'package:tucana/screens/pages/history/guest_rasturant_order.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';

class HistoryScreen extends StatefulWidget {
  var h_id;
  HistoryScreen({this.h_id, super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final hotelsController = Get.put(HotelsController());
  final hotelController = Get.put(HotelsController());
  TabController? _tabController;
  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.h_id,
      // screen_type: 'home_screen',
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.backGroundLoaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((() {
        return (hotelController.backGroundLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      })),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            "https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelsController.back_ground[0].dining_screen}",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: SizedBox(
            width: 750,
            child: Container(
              child: Column(
                children: [
                  HeaderScreen(),
                  TabBar(
                    isScrollable: true,
                    indicatorWeight: 2,
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Booking',
                      ),
                      Tab(
                        text: 'My Orders',
                      ),
                      Tab(
                        text: 'Wellness',
                      ),
                      Tab(
                        text: 'Maintenance',
                      ),
                      // Tab(
                      //   text: 'w Booking',
                      // ),
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GuestRestaurantOrder(),
                        GuestOrder(),
                        GuestActivityOrder(),
                        GuestMaintenance()
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
