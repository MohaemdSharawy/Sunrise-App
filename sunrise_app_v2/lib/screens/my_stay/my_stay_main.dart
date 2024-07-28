import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
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
    Size size = MediaQuery.of(context).size;
    @override
    void initState() {
      print(myStayNavController.screens_name);
      super.initState();
    }

    return Obx(
      () => Scaffold(
        body: myStayNavController
            .screens[myStayNavController.current_index.value],
        bottomNavigationBar: Container(
          // margin: EdgeInsets.all(20),
          height: size.width * .190,
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
            itemCount: myStayNavController.screens.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * .024),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                update_select(index);
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
                      bottom: index == myStayNavController.current_index.value
                          ? 0
                          : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: index == myStayNavController.current_index.value
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
                        myStayNavController.screens_icon[index],
                        size: size.width * .076,
                        color: index == myStayNavController.current_index.value
                            ? AppColor.primary
                            : AppColor.second,
                      ),
                      Text(
                        myStayNavController.screens_name[index],
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
        // bottomNavigationBar: BottomNavyBar(
        //   selectedIndex: myStayNavController.current_index.value,
        //   showElevation: true,
        //   itemCornerRadius: 8,
        //   curve: Curves.easeInBack,
        //   onItemSelected: (index) => update_select(index),
        //   items: [
        //     for (var i = 0; i < myStayNavController.screens_name.length; i++)
        //       BottomNavyBarItem(
        //         icon: myStayNavController.screens_icon[i],
        //         title: Text(myStayNavController.screens_name[i]),
        //         activeColor: AppColor.primary,
        //         textAlign: TextAlign.center,
        //       ),
        //   ],
        // ),
      ),
    );
  }
}
