import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/homeController.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/mycolors.dart';

class HomeScreen extends StatefulWidget {
  var hotel;
  var h_id;
  HomeScreen({this.hotel, this.h_id, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  _getData() async {
  
  }


  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: homeController.screens[homeController.currentIndex.value],
        bottomNavigationBar: Container(
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
                  color: Colors.white.withOpacity(0.4)),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: 
                BottomNavigationBar(
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
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/Air Conditioner Controls.png',
                        width: 30,
                        height: 30,
                      ),
                      label: 'Weather',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/Dining.png',
                        width: 30,
                        height: 30,
                      ),
                      label: 'Dining',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/Wellness.png',
                        width: 30,
                        height: 30,
                      ),
                      label: 'Wellness',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/FAQS.png',
                        width: 30,
                        height: 30,
                      ),
                      label: 'Rating',
                    ),
                  ],
                  onTap: (index) {
                    homeController.currentIndex.value = index;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
