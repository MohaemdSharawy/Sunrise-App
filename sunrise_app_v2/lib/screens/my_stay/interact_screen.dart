import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_icons.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_card_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/my_stay/let_us_know_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractScreen extends StatefulWidget {
  int hotel_id;
  int master_card_id;
  InteractScreen(
      {required this.hotel_id, required this.master_card_id, super.key});

  @override
  State<InteractScreen> createState() => _InteractScreenState();
}

class _InteractScreenState extends State<InteractScreen> {
  final hotelCardController = Get.put(HotelCardController());
  final hotelController = Get.put(HotelController());

  Future<void> _getData() async {
    await hotelController.hotel_view(hotel_id: widget.hotel_id);
    await hotelController.getSlider(
        type_name: 'Interact Screen', hotel_id: widget.hotel_id);
    await hotelCardController.getSubCard(
      hotel_id: widget.hotel_id,
      type_id: 1,
      master_id: widget.master_card_id,
    );
    print(hotelCardController.card);
  }

  // Future<void> _launchUrl() async {
  //   if (await canLaunchUrl(Uri.parse(interfaceController.interfaceVal.value))) {
  //     await launchUrl(Uri.parse(interfaceController.interfaceVal.value),
  //         mode: LaunchMode.externalApplication);
  //   } else {
  //     Get.snackbar(
  //       'Message',
  //       // '${error}',
  //       'Sorry This Not Available',
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: Colors.red,
  //       // colorText: Colors.white,
  //     );
  //   }
  // }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (hotelCardController.card_loaded.value)
            ? RefreshIndicator(
                onRefresh: _getData,
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              // width: double.infinity,
                              // height: double.infinity,
                            ),
                            SliderWidget(),
                            Positioned(
                              // top: 5,
                              child: Container(
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: AppColor.background_card,
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
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height /
                                    3, //minimum height
                              ),
                              margin: EdgeInsets.only(top: 350),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.background_card,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // if (split_item != null) ...[
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          hotelCardController.sub_cards.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () => Get.to(LetUsKnowScreen(
                                            hotel_id: widget.hotel_id,
                                          )),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    '${AppUrl.main_domain}uploads/hotel_cards_image/${hotelCardController.sub_cards[index].image}',
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                  Container(
                                                    height: 130,
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                  ),
                                                  Positioned(
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      color: AppColor
                                                          .card_label_back_ground,
                                                      child: AppIcons.icons[
                                                          hotelCardController
                                                              .sub_cards[index]
                                                              .icon],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      hotelCardController
                                                          .sub_cards[index]
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),

                                  // ],
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }
}
