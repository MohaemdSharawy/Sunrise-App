import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/pages/wellness/gem_screen.dart';
import 'package:tucana/screens/pages/wellness/spa_screen.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';

import '../controller/Resturan_Controller.dart';
import '../utilites/navigationButtom.dart';

class WellnessScreen extends StatefulWidget {
  var h_id;
  WellnessScreen({this.h_id, super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> with BaseController {
  List tap_name = [];
  List tap_icon = [];
  final restaurantController = Get.put(RestaurantController());
  final hotelController = Get.put(HotelsController());

  _getData() async {
    hotelController.backGroundLoaded.value = false;
    restaurantController.wellnessLoading.value = false;
    await hotelController.getBackGround(
      search_key: widget.h_id,
      screen_type: 'wellness_screen',
    );
    hotelAuth(widget.h_id, context);
    await restaurantController.getRestaurant(hotel_id: widget.h_id);

    await restaurantController.getGym(
      hotel_code: restaurantController.hotel[0].code,
    );
    if (restaurantController.gym.length > 0) {
      tap_name.add('Gym');
      tap_icon.add('assets/icons/Gym.png');
    }

    await restaurantController.getSpas(
      hotel_code: restaurantController.hotel[0].code,
    );
    if (restaurantController.spa.length > 0) {
      tap_name.add('Spa');
      tap_icon.add('assets/icons/Spa.png');
    }
    restaurantController.wellnessLoading.value = true;
  }

  @override
  void initState() {
    restaurantController.isLoaded.value = false;
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() {
          return (restaurantController.wellnessLoading.value == true)
              ? Stack(
                  children: [
                    Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].wellness_screen}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover),
                    Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.7)),
                    Center(
                      child: SizedBox(
                        width: 750,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 11, right: 11, top: 270),
                          child: GridView.builder(
                            itemCount: tap_name.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 4,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 35,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    if (tap_name[index] == 'Gym') {
                                      print(restaurantController.hotel[0].code);
                                      Navigator.pushNamed(context,
                                          '/gym/${restaurantController.hotel[0].code}');
                                    } else if (tap_name[index] == 'Spa') {
                                      // Get.to(SpaScreen());
                                      Navigator.pushNamed(context,
                                          '/spa/${restaurantController.hotel[0].code}');
                                    }
                                    // print(tap_screen[index]);
                                    // Get.to(LetUsKnowScreen());
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Text('test', style: TextStyle(fontSize: 19)),
                                        Image.asset(
                                          tap_icon[index],
                                          width: 80,
                                          height: 80,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(tap_name[index],
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 220),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/Wellness.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'SPA & WELLNESS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    HeaderScreen(
                      h_id: widget.h_id,
                    )
                  ],
                )
              : BackGroundWidget();
        }),
      ),
      bottomNavigationBar: CustomBottomBar(
        h_id: widget.h_id,
      ),
    );
  }
}
