import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/interface_controller.dart';
import 'package:tucana/controller/pms_controller.dart';
import 'package:tucana/screens/home_screen.dart';
import 'package:tucana/screens/pages/letusKnow.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/hotel_name.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';
import 'package:tucana/utilites/navigationButtom.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import 'dart:html' as htmls;

class MainScreen extends StatefulWidget with BaseController {
  // var hotel;
  var h_id;
  MainScreen({this.h_id, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with BaseController {
  // final interfaceController = Get.find<InterfaceController>();
  // final hotelsController = Get.find<HotelsController>();
  final interfaceController = Get.put(InterfaceController());
  final homeController = Get.put(HomeController());
  final hotelController = Get.put(HotelsController());
  final pmsController = Get.put(PmsController());

  @override
  List posh_club = ["3", "6", "7", "8", "14", "15", "16"];
  // List tap_name = [
  //   'Hotel Info',
  //   'Hotel Map',
  //   'Entertainment',
  //   // 'Let Us Know',
  //   'Chat (Let Us Know)',
  //   'Rate Us',
  //   'TV Programs',
  //   'weather',
  //   'City Guide'
  // ];

  // List tap_icon = [
  //   'Hotel Info.png',
  //   'Hotel Map.png',
  //   'Entertainment.png',
  //   // 'Let Us Know.png',
  //   'Chatting.png',
  //   'FAQS.png',
  //   'TV.png',
  //   'Air Conditioner Controls.png',
  //   'Hotel Map.png',
  // ];

  late List tap_name;
  late List tap_icon;
  late List tap_link;

  var tap_screen = [
    'LetUsKnowScreen',
    'LetUsKnowScreen',
    'LetUsKnowScreen',
    'LetUsKnowScreen',
  ];
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

  getLink(type) async {
    showLoading();

    await interfaceController.getInterface(
      hotel_id: widget.h_id,
      interfaceType: type,
    );

    _launchUrl();
    hideLoading();
  }

  checkVideo() async {
    interfaceController.have_video.value = false;
    await interfaceController.getInterface(
      hotel_id: widget.h_id,
      interfaceType: 'VIDEO',
    );
    if (interfaceController.interfaceVal.value != '') {
      interfaceController.have_video.value = true;
    }
  }

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.h_id,
      // screen_type: 'home_screen',
    );
    checkVideo();
    await hotelController.getHotel(hid: widget.h_id);
    if (hotelController.hotel.value.company_id == "2") {
      print('Company 2');
      tap_name = [
        'Boat Info',
        'Entertainment',
        'Chat (Let Us Know)',
        'Let Us Know',
        'Rate Us (NPS)',
        'TV Programs',
        'weather',
        'City Guide'
      ];

      tap_icon = [
        'Hotel Info.png',
        'Entertainment.png',
        'Chatting.png',
        'Let Us Know.png',
        'FAQS.png',
        'TV.png',
        'Air Conditioner Controls.png',
        'Hotel Map.png',
      ];

      tap_link = [
        'hotel_info',
        'entertainment',
        'CHAT',
        'let_us_know',
        'rate',
        'tv_guide',
        'weather',
        'city_guide'
      ];
    } else {
      print('Company 1');

      tap_name = [
        'Hotel Info',
        'Hotel Map',
        'Entertainment',
        'Chat (Let Us Know)',
        'Let Us Know',
        'Rate Us (NPS)',
        'TV Programs',
        'weather',
        'City Guide',
        'Book Restaurant'
      ];

      tap_icon = [
        'Hotel Info.png',
        'Hotel Map.png',
        'Entertainment.png',
        'Chatting.png',
        'Let Us Know.png',
        'FAQS.png',
        'TV.png',
        'Air Conditioner Controls.png',
        'Hotel Map.png',
        'Hotel Map.png',
      ];
      tap_link = [
        'hotel_info',
        'hotel_map',
        'entertainment',
        'CHAT',
        'let_us_know',
        'rate',
        'tv_guide',
        'weather',
        'city_guide',
        'book_restaurant_list',
      ];
    }
    interfaceController.bookingLoaded.value = false;
    await interfaceController.getHotel(hotel_id: widget.h_id);
  }

  // var loaded = false;

  reload() async {
    if (GetStorage().read('lang_loaded') == "false") {
      await GetStorage().write('lang_loaded', "true");
      print('-------- Lang loaded   -------- ');
      print(GetStorage().read('lang_loaded'));
      htmls.window.location.reload();
      // print(pmsController.isLogin.value);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GetStorage().write('h_id' , widget.h_id);
      hotelAuth(widget.h_id.toString(), context);
      reload();
      _getData();
      end_session();
      npsQuestion(context);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    // return Obx(() {
    return Scaffold(
      body: Obx(
        () {
          return (interfaceController.hotelLoaded.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        h_id: widget.h_id,
      ),
    );
    // });
  }

  Widget mainBody() {
    return Stack(
      children: [
        // BackGroundWidget(),
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].home_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              HeaderScreen(
                h_id: widget.h_id,
              ),
              if (interfaceController.have_video.value == true) ...[
                Container(
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Center(
                    // width: 750,
                    child: Container(
                      width: 750,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () async {
                          showLoading();
                          await interfaceController.getInterface(
                            hotel_id: widget.h_id,
                            interfaceType: 'VIDEO',
                          );
                          hideLoading();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context,
                              '/video/${interfaceController.interfaceVal.value}');
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text('test', style: TextStyle(fontSize: 19)),
                              Image.asset(
                                'assets/icons/video.png',
                                width: 40,
                                height: 40,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Video',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: 15,
              ),
              if (posh_club.contains(widget.h_id.toString())) ...[
                Container(
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Center(
                    // width: 750,
                    child: Container(
                      width: 750,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(
                              context, '/posh_club/${widget.h_id}');
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text('test', style: TextStyle(fontSize: 19)),
                              Image.asset(
                                'assets/icons/posh_club.png',
                                width: 90,
                                height: 90,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Posh Club',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 750,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: tap_name.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (tap_link[index] == 'CHAT') {
                                getLink(tap_link[index]);
                              } else if (tap_link[index] == 'weather') {
                                Navigator.pushNamed(context,
                                    '/weather/${widget.h_id}/${interfaceController.hotel[0].hotel_group}');
                              } else {
                                String link = tap_link[index];
                                Navigator.pushNamed(
                                    context, '/$link/${widget.h_id}');
                              }
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Text('test', style: TextStyle(fontSize: 19)),
                                  Image.asset(
                                    'assets/icons/${tap_icon[index]}',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    tap_name[index],
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ).tr(),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
