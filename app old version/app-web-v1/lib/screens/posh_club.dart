import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/slider_widget.dart';

class PoshClubScreen extends StatefulWidget {
  var h_id;
  PoshClubScreen({this.h_id, super.key});

  @override
  State<PoshClubScreen> createState() => _PoshClubScreenState();
}

class _PoshClubScreenState extends State<PoshClubScreen> with BaseController {
  final hotelController = Get.put(HotelsController());
  final hotel_guide_controller = Get.put(HotelGuideController());
  TextStyle header = TextStyle(color: Colors.white, fontSize: 25);
  TextStyle sub_text = TextStyle(color: Colors.white, fontSize: 15);

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.h_id,
    );
    await hotel_guide_controller.getPoshClub(hotel_id: widget.h_id);
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.backGroundLoaded.value = false;
      _getData();
      npsQuestion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (hotel_guide_controller.posh_club_loaded.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
    );
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderScreen(
                h_id: widget.h_id,
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       'assets/icons/posh_club.png',
              //       width: 150,
              //       height: 150,
              //       color: Colors.white,
              //     ),
              //     SizedBox(
              //       width: 8.0,
              //     ),
              //     Text(
              //       'Posh Club',
              //       style: header,
              //     ),
              //   ],
              // ),
              Image.network(
                'https://hotelguide.sunrise-resorts.com/attach/${hotel_guide_controller.posh_club_logo.value.logo}',
                width: 150,
                height: 150,
                color: Colors.white,
              ),
              SizedBox(
                height: 300,
                width: 750,
                child: SliderWidget(),
              ),

              for (var elemnet in hotel_guide_controller.posh_club)
                SizedBox(
                  width: 750,
                  child: Center(
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        elemnet.header,
                        style: header,
                      ),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45))),
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          color: Colors.black,
                          child: Html(
                            data: elemnet.description,
                            style: {
                              "body": Style(color: Colors.white),
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              // SizedBox(
              //   width: 750,
              //   child: Center(
              //     child: ExpansionTile(
              //       iconColor: Colors.white,
              //       collapsedIconColor: Colors.white,
              //       title: Text(
              //         'PRIVILIGES',
              //         style: header,
              //       ),
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(45))),
              //           width: double.infinity,
              //           padding: EdgeInsets.all(15),
              //           color: Colors.black,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Text(
              //                 '1- Posh Club Lounge with private Fine-Dining Restaurant, Bar and Pool.',
              //                 style: sub_text,
              //               ),
              //               Text(
              //                   '2- Exclusive discounts on services such as Laundry, Spa, and Wellness.',
              //                   style: sub_text),
              //               Text('Complimentary Limousine Service.',
              //                   style: sub_text),
              //               Text('3- Royal Breakfast with daily replenishment',
              //                   style: sub_text),
              //               Text(
              //                   '4- Priority in A la Carte Restaurants Reservation',
              //                   style: sub_text),
              //               Text('5- Access to a Private Beach Cabana',
              //                   style: sub_text),
              //               Text('6- Daily mini-bar refill', style: sub_text),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
