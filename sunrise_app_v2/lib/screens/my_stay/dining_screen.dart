import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/mystay_navgation_contoller.dart';
import 'package:sunrise_app_v2/screens/yourcart_screens/restaurant_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class DinningScreen extends StatefulWidget {
  int hotel_id;
  DinningScreen({required this.hotel_id, super.key});

  @override
  State<DinningScreen> createState() => _DinningScreenState();
}

class _DinningScreenState extends State<DinningScreen> {
  final hotelController = Get.put(HotelController());
  final myStayController = Get.put(MyStayNavNController());

  List items = [];
  Future<void> _getData() async {
    await hotelController.get_hotel_ids_mapping(hotel_id: widget.hotel_id);
    items.addAll(
      [
        {
          'name': 'Restaurant',
          'icon': 'assets/Romantic Dinner.png',
          'action': () => Get.to(
                () => RestaurantScreen(
                  restaurant_hotel_id:
                      hotelController.hotel_ids_mapping.value.your_cart_hid,
                ),
              )
        },
        {
          'name': 'Bar',
          'icon': 'assets/View All Bars.png',
          'action': () => Get.to(
                () => RestaurantScreen(
                  type: 'Bar',
                  restaurant_hotel_id:
                      hotelController.hotel_ids_mapping.value.your_cart_hid,
                ),
              )
        },
        {
          'name': 'Shisha',
          'icon': 'assets/shisha.png',
          'action': () => print('shisha')
        },
        {
          'name': 'MiniBar',
          'icon': 'assets/minibar.png',
          'action': () => print('Mini bar')
        },
      ],
    );
    await hotelController.hotel_view(hotel_id: widget.hotel_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.single_hotel_load.value = false;
      _getData();
    });
    super.initState();
  }

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
                            title: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                hotelController.hotel.value.hotel_name,
                                style: AppFont.boldBlack,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 8, bottom: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '0 Restaurant',
                                style: AppFont.smallBoldBlack,
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                child: Icon(Icons.display_settings_sharp),
                              )
                            ],
                          ),
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: items.map((item) {
                            return RestaurantCard1(
                              name: item['name'],
                              image: item['icon'],
                              action: item['action'],
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              : AnimatedLoader(),
        ));
  }
}

class RestaurantCard1 extends StatelessWidget {
  String name;
  String image;
  void Function() action;

  RestaurantCard1({
    required this.name,
    required this.image,
    required this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.1,
        child: Card(
          color: AppColor.background_card,
          elevation: 0.5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Image.asset(
                image,
                // fit: BoxFit,
                height: 110,
                width: MediaQuery.of(context).size.width / 3.5,
                color: AppColor.primary,
              ),
              Text(
                name,
                style: AppFont.smallBoldBlack,
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
