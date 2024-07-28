import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/offer_controller.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/offer_card.dart';

class ViewAllOffersScreen extends StatefulWidget {
  const ViewAllOffersScreen({super.key});

  @override
  State<ViewAllOffersScreen> createState() => _ViewAllOffersScreenState();
}

class _ViewAllOffersScreenState extends State<ViewAllOffersScreen> {
  final offerController = Get.put(OffersController());

  Future<void> _getData() async {
    offerController.offers_loaded.value = false;
    await offerController.getAllOffers();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offerController.offers_loaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Obx(
          () => (offerController.offers_loaded.value)
              ? SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                              "OFFERS",
                              style: AppFont.boldBlack,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8, bottom: 8, right: 8, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deals & Offers',
                                style: AppFont.smallBoldBlack,
                              ),
                              // Container(
                              //   height: 35,
                              //   width: 35,
                              //   child: Icon(Icons.display_settings_sharp),
                              // )
                            ],
                          ),
                        ),
                        if (offerController.offers.length > 0) ...[
                          for (var offer in offerController.offers)
                            Center(child: OfferCard(offer: offer))
                        ] else ...[
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/search-result-not-found-2130355-1800920.webp',
                                  ),
                                  Text(
                                    'There Is No Offers ',
                                    style: AppFont.smallBoldBlack,
                                  )
                                ],
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                )
              : Center(
                  child: WidgetDotFade(
                    color: AppColor.primary,
                  ),
                ),
        ),
      ),
    );
  }
}
