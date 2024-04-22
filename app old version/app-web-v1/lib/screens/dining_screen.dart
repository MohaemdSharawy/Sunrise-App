import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/interface_controller.dart';
import 'package:tucana/screens/pages/dining/bar_screen.dart';
import 'package:tucana/screens/pages/dining/booking_screen.dart';
import 'package:tucana/screens/pages/dining/restaurant_screen.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/navigationButtom.dart';
import 'package:url_launcher/url_launcher.dart';

class DiningScreen extends StatefulWidget {
  var hotel_id;
  DiningScreen({this.hotel_id, super.key});

  @override
  State<DiningScreen> createState() => _DiningScreenState();
}

class _DiningScreenState extends State<DiningScreen> with BaseController {
  final hotelController = Get.put(HotelsController());
  final restaurantController = Get.put(RestaurantController());

  final interfaceController = Get.put(InterfaceController());

  List tap_name = [
    'Restaurants',
    'Bars',
    // 'Shisha',
    // 'Mini Bar'
    // 'Book Your Restaurants'
  ];
  List tapIcon = [
    'assets/icons/Romantic Dinner.png',
    'assets/icons/View All Bars.png',
    // 'assets/icons/shisha.png',
    // 'assets/icons/minibar.png',
    // 'assets/icons/Book your Restaurant.png'
  ];

  _getData() async {
    restaurantController.diningLoading.value = false;
    hotelController.backGroundLoaded.value = false;
    await hotelController.getHotel(hid: widget.hotel_id);
    await hotelController.getBackGround(
      search_key: widget.hotel_id,
    );
    hotelAuth(widget.hotel_id, context);
    await restaurantController.getShisha(hotel_id: widget.hotel_id);
    if (restaurantController.shisha.length > 0) {
      tap_name.add('Shisha');
      tapIcon.add('assets/icons/shisha.png');
    }
    await restaurantController.getMineBar(hotel_id: widget.hotel_id);
    if (restaurantController.mine_bar.length > 0) {
      tap_name.add('Mini Bar');
      tapIcon.add('assets/icons/minibar.png');
    }

    restaurantController.diningLoading.value = true;
    _getInterface();
  }

  _getInterface() async {
    await interfaceController.getInterface(
      hotel_id: widget.hotel_id,
      interfaceType: 'RSR',
    );
  }

  getLink(type) async {
    showLoading();
    _launchUrl();
    hideLoading();
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(interfaceController.interfaceVal.value))) {
      await launchUrl(Uri.parse(interfaceController.interfaceVal.value),
          mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
      npsQuestion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((() {
        return (restaurantController.diningLoading.value == true)
            ? mainBody()
            : BackGroundWidget();
      })),
      bottomNavigationBar: (hotelController.hotel.value.out_side == "0")
          ? CustomBottomBar(h_id: widget.hotel_id)
          : null,
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
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
              padding: const EdgeInsets.only(left: 11, right: 11, top: 270),
              child: GridView.builder(
                itemCount: tap_name.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
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
                        if (index == 0) {
                          Navigator.pushNamed(
                              context, '/restaurant/${widget.hotel_id}');
                        } else if (index == 1) {
                          Navigator.pushNamed(
                              context, '/bars/${widget.hotel_id}');
                        } else if (tap_name[index] == 'Shisha') {
                          if (GetStorage().read('room_num') != '' &&
                              GetStorage().read('room_num') != null) {
                            await restaurantController.getShisha(
                                hotel_id: widget.hotel_id);
                            if (restaurantController.shisha.length > 0) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context,
                                  'categories/${restaurantController.shisha[0].code}');
                            } else {
                              Get.snackbar(
                                'Message',
                                // '${error}',
                                'Shisha  Not Available',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            login_dialog(context, widget.hotel_id);
                          }
                        } else if (tap_name[index] == 'Mini Bar') {
                          if (GetStorage().read('room_num') != '' &&
                              GetStorage().read('room_num') != null) {
                            await restaurantController.getMineBar(
                                hotel_id: widget.hotel_id);
                            if (restaurantController.mine_bar.length > 0) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context,
                                  'categories/${restaurantController.mine_bar[0].code}');
                            } else {
                              Get.snackbar(
                                'Message',
                                // '${error}',
                                'Mini Bar Not Available',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            login_dialog(context, widget.hotel_id);
                          }
                        }
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Text('test', style: TextStyle(fontSize: 19)),
                            Image.asset(
                              tapIcon[index],
                              width: 80,
                              height: 80,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(tap_name[index],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white))
                                .tr(),
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
              if (interfaceController.interfaceVal.value != null &&
                  interfaceController.interfaceVal.value != '') ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.6)),
                  child: Text('Book Now').tr(),
                  onPressed: () {
                    getLink('RSR');
                  },
                ),
              ],
              SizedBox(
                width: 25,
              ),
              Image.asset(
                'assets/icons/Dining.png',
                width: 40,
                height: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Dining',
                style: TextStyle(color: Colors.white),
              ).tr(),
            ],
          ),
        ),

        //
        HeaderScreen(
          h_id: widget.hotel_id,
        )
      ],
    );
  }
}
