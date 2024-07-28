import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/hotel_book_home.dart';
import 'package:sunrise_app_v2/screens/my_stay/hotel_home_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ResortsScreen extends StatefulWidget {
  int? destination_id;
  ResortsScreen({this.destination_id, super.key});

  @override
  State<ResortsScreen> createState() => _ResortsScreenState();
}

class _ResortsScreenState extends State<ResortsScreen> {
  final hotelController = Get.put(HotelController());

  _getData() async {
    await hotelController.getHotels(destination_id: widget.destination_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.hotel_loaded.value = false;
      _getData();
      // print(hotelController.hotels);
    });
    // print(hotelController.hotels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (hotelController.hotel_loaded.value)
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${hotelController.hotels.length.toString()} Destination Found',
                              style: AppFont.smallBoldBlack,
                            ),
                            Container(
                              // padding: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              height: 35,
                              width: 35,
                              child: Icon(Icons.map),
                            )
                          ],
                        ),
                      ),
                      for (var hotel in hotelController.hotels)
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: InkWell(
                            onTap: () {
                              Get.to(HotelHomeBookingScreen(
                                hotel_id: hotel.id,
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              height: 255,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: AppColor.background_card,
                                elevation: 0,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          '${AppUrl.main_domain}uploads/hotels/${hotel.hotel_image}',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width /
                                          1.37,
                                      top: 20,
                                      child: Container(
                                        padding: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                            color: AppColor.background_card,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 20.0,
                                          color: Color.fromARGB(
                                              255, 201, 201, 201),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: MediaQuery.of(context).size.width /
                                          1.4,
                                      top: 18,
                                      child: Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              color: AppColor.background_card,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Text(
                                            '-40%',
                                            style: TextStyle(
                                              color: AppColor.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ),
                                    Positioned(
                                      top: 155,
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: 8, top: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, top: 7.0),
                                              child: Text(
                                                hotel.hotel_name,
                                                textAlign: TextAlign.start,
                                                style: AppFont.midBoldSecond,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.location_on_outlined),
                                                Text("${hotel.group.name} , "),
                                                Text("${hotel.group.country}")
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  SmoothStarRating(
                                                    allowHalfRating: false,
                                                    starCount: 5,
                                                    rating: 5,
                                                    size: 15.0,
                                                    // filledIconData: Icons.blur_off,
                                                    halfFilledIconData:
                                                        Icons.blur_on,
                                                    color: Colors.amber,
                                                    borderColor: Colors.amber,
                                                    spacing: 0.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    ' (4.9)',
                                                    style: AppFont.tinyGrey,
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Row(
                                            //   children: [Text('USD ,'), Text('Egypt')],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }
}
