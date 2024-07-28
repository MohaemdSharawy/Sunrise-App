import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_icons.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_card_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/controllers/mystay_navgation_contoller.dart';
import 'package:sunrise_app_v2/models/hotel_cards_model.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_facilities_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/city_guide_scrren.dart';
import 'package:sunrise_app_v2/screens/my_stay/entertainment_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/hotel_info_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/interact_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class HotelHomeScreen extends StatefulWidget {
  int hotel_id;
  HotelHomeScreen({required this.hotel_id, super.key});

  @override
  State<HotelHomeScreen> createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen> {
  final hotelController = Get.put(HotelController());
  final cardController = Get.put(HotelCardController());
  final myStayController = Get.put(MyStayNavNController());

  HotelCard? split_item;

  @override
  void check_view({required int count}) {
    int e = count % 2;
    if (e != 0) {
      split_item = cardController.card.last;

      cardController.card.removeLast();
    }
  }

  Future<void> _getData() async {
    await hotelController.getSlider(
      type_name: 'Hotel Info Screen',
      hotel_id: widget.hotel_id,
    );
    await cardController.getCards(hotel_id: widget.hotel_id, type_id: 1);
    check_view(count: cardController.card.length);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardController.card_loaded.value = false;
      _getData();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    Map links = {
      'Hotel Info': HotelInfoScreen(hotel_id: widget.hotel_id),
      'Entertainment': EntertainmentScreen(hotel_id: widget.hotel_id),
      'Facilities': HotelFacilitiesScreen(hotel_id: widget.hotel_id),
      'About City': HotelCityGuide(hotel_id: widget.hotel_id),
      'Interact': InteractScreen(
        hotel_id: widget.hotel_id,
        master_card_id: 5,
      ),
    };
    return Scaffold(
      body: Obx(
        () => (cardController.card_loaded.value)
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
                                    myStayController.hotel.value.hotel_name,
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
                                color: AppColor.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2.3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cardController.card.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () => Get.to(links[
                                          cardController.card[index].link]),
                                      child: Container(
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Stack(
                                            // alignment: Alignment.center,
                                            children: [
                                              Image.network(
                                                '${AppUrl.main_domain}uploads/hotel_cards_image/${cardController.card[index].image}',
                                                height: 190,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                height: 190,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                              ),
                                              Positioned(
                                                // right: 150,
                                                // bottom: 100,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  color: AppColor
                                                      .card_label_back_ground,
                                                  child: AppIcons.icons[
                                                      cardController
                                                          .card[index].icon],
                                                  // child: Icon(
                                                  //   Icons.abc,
                                                  //   color: Colors.white,
                                                  // ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4.5),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    cardController
                                                        .card[index].name,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (split_item != null) ...[
                                    InkWell(
                                      onTap: () {
                                        Get.to(links[split_item?.link]);
                                      },
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              '${AppUrl.main_domain}uploads/hotel_cards_image/${split_item!.image}',
                                              height: 130,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              height: 130,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                            ),
                                            Positioned(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color: AppColor
                                                    .card_label_back_ground,
                                                child: AppIcons
                                                    .icons[split_item!.icon],
                                              ),
                                            ),
                                            Positioned(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.8,
                                              top: 100,
                                              child: Text(
                                                split_item!.name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
