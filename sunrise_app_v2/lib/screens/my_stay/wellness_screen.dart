import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/wellness_controller.dart';
import 'package:sunrise_app_v2/screens/wellness/spa_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class WellnessScreen extends StatefulWidget {
  int hotel_id;
  WellnessScreen({required this.hotel_id, super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  final hotelController = Get.put(HotelController());
  final wellenssController = Get.put(WellnessController());
  // final hotelController = Get.put(HotelController());

  _getData() async {
    await hotelController.hotel_view(hotel_id: widget.hotel_id);
    print(hotelController.hotel.value.hotel_name);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  List<Map> menu = [
    {
      'name': 'SPA',
      'description':
          'Vestibulum auctor maximus leo, ac facilities est varuis  in .',
      'image':
          'https://res.cloudinary.com/simplotel/image/upload/x_0,y_4,w_916,h_515,r_0,c_crop,q_90,fl_progressive/w_1650,f_auto,c_fit/hablis-hotel-chennai/couple_spa_at_hablis',
      'link': SpaScreen(
        code: 's',
      )
    },
    {
      'name': 'Gym',
      'description':
          'Vestibulum auctor maximus leo, ac facilities est varuis  in .',
      'image':
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'link': SpaScreen(
        code: 's',
      )
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (hotelController.single_hotel_load.value)
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColor.background_card,
                          // color: Color.fromARGB(255, 240, 232, 232),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: CustomStayHeader(
                          title: Text(
                            hotelController.hotel.value.hotel_name,
                            style: AppFont.boldBlack,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemCount: menu.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.to(menu[index]['link']);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 15),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: AppColor.background_card,
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          child: Image.network(
                                            menu[index]['image'],
                                            height: 110,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        menu[index]['name'],
                                        style: AppFont.smallBoldBlack,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, bottom: 12),
                                      child: Text(
                                        menu[index]['description'],
                                        style: AppFont.midSecond,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }
}
