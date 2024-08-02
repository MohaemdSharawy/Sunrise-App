import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/brand_controller.dart';
import 'package:sunrise_app_v2/controllers/destination_controller.dart';
import 'package:sunrise_app_v2/controllers/offer_controller.dart';
import 'package:sunrise_app_v2/controllers/wish_list_controller.dart';
import 'package:sunrise_app_v2/screens/all_offers_scrren.dart';
import 'package:sunrise_app_v2/screens/general_posh_club_screen.dart';
import 'package:sunrise_app_v2/screens/hotel_book_home.dart';
import 'package:sunrise_app_v2/screens/resorts_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/hotel_home_card_widget.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';
import 'package:sunrise_app_v2/utilites/general/offer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final destinationController = Get.put(DestinationController());
  final brandController = Get.put(BrandsController());
  final offerController = Get.put(OffersController());
  final wishListController = Get.put(WishListController());

  int? current_brand;

  _getData() async {
    destinationController.destination_loaded.value = false;
    await brandController.getBrands();
    current_brand = 0;
    await offerController.getHomeOffers();
    await brandController.hotelsBrand(brand_id: brandController.brand[0].id);
    await destinationController.getDestinations();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    super.initState();
  }

  getHotelBrand(value) async {
    setState(() {
      current_brand = value;
    });
    await brandController.hotelsBrand(
        brand_id: brandController.brand[value].id);
  }

  viewAllBrandsHotel() async {
    await brandController.viewAllBrandHotels();
    setState(() {
      current_brand = null;
    });
  }

  void wishListHandel(code) {
    if (wishListController.isCodeInWishList(code)) {
      print('Remove From wish List');
    } else {
      wishListController.add_wish_list(
        type: 'hotel',
        wish_code: code,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () {
          return (destinationController.destination_loaded.value)
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomHeader(),
                        destinations(),
                        brand(),
                        posh_club(),
                        offers()
                      ],
                    ),
                  ),
                )
              : AnimatedLoader();
        },
      ),
    );
  }

  Widget destinations() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Destinations',
            style: AppFont.smallBoldBlack,
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var element in destinationController.destinations)
                  InkWell(
                    child: Container(
                      height: 250,
                      width: 200,
                      child: Card(
                        color: AppColor.background_card,
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ImageCustom(
                              image:
                                  "${AppUrl.main_domain}uploads/hotel-groups/${element.image}",
                              height: 250,
                              width: 200,
                              fit: BoxFit.cover,
                              openImage: false,
                            ),
                            // Ink.image(
                            //   image: NetworkImage(
                            //     AppUrl.main_domain +
                            //         'uploads/hotel-groups/' +
                            //         element.image,
                            //   ),
                            //   fit: BoxFit.cover,
                            //   height: 250,
                            //   width: 200,
                            // ),
                            Container(
                              color: Colors.white.withOpacity(0.15),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                element.name,
                                style: AppFont.smallBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () => Get.to(
                      ResortsScreen(
                        destination_id: element.id,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget brand() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Brands',
                style: AppFont.smallBoldBlack,
              ),
              TextButton(
                onPressed: () {
                  viewAllBrandsHotel();
                  // Get.to(ViewAllOffersScreen());
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: AppColor.primary),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: brandController.brand.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          child: Card(
                            color: (current_brand == index)
                                ? AppColor.primary
                                : AppColor.background_card,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  brandController.brand[index].brand_name
                                      .toUpperCase(),
                                  style: (current_brand != index)
                                      ? AppFont.tinyGrey
                                      : AppFont.tinyBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () => getHotelBrand(index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (brandController.hotel_brand_loaded.value)
                ? Row(
                    children: [
                      for (var h_brand in brandController.hotel_brand)
                        HotelHomeCardWidget(
                          hotel: h_brand,
                        )
                    ],
                  )
                : Container(
                    // padding: EdgeInsets.only(left: 200),
                    alignment: Alignment.center,
                    child: Center(
                      child: WidgetDotFade(
                        color: AppColor.primary,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget offers() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Offers & Deals',
                style: AppFont.smallBoldBlack,
              ),
              TextButton(
                onPressed: () {
                  Get.to(ViewAllOffersScreen());
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: AppColor.primary),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              for (var offer in offerController.offers) OfferCard(offer: offer)
            ],
          ),
        ],
      ),
    );
  }

  Widget posh_club() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Posh Club',
            style: AppFont.smallBoldBlack,
          ),
          InkWell(
            onTap: () => Get.to(GeneralPoshClubScreen()),
            child: Image.asset(
              height: 100,
              width: MediaQuery.of(context).size.width,
              'assets/Posh-banenr.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
