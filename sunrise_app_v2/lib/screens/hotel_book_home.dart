import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_icons.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_card_controller.dart';
import 'package:sunrise_app_v2/controllers/hotel_rooms_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/models/hotel_room_model.dart';
import 'package:sunrise_app_v2/screens/hotel/room_view_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/booking_btn_footer.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_drawer.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/home_app_bar.dart';
import 'package:sunrise_app_v2/utilites/general/hotel_card_widget.dart';

class HotelHomeBookingScreen extends StatefulWidget {
  int hotel_id;
  HotelHomeBookingScreen({required this.hotel_id, super.key});

  @override
  State<HotelHomeBookingScreen> createState() => _HotelHomeBookingScreenState();
}

class _HotelHomeBookingScreenState extends State<HotelHomeBookingScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final hotel_controller = Get.put(HotelController());
  final hotel_card_controller = Get.put(HotelCardController());
  final hotel_room_controller = Get.put(HotelRoomController());

  int count = 4;

  bool expaned = false;

  Future<void> _getData() async {
    await hotel_controller.hotel_view(hotel_id: widget.hotel_id);
    await hotel_controller.get_hotel_includes(hotel_id: widget.hotel_id);
    await hotel_card_controller.getCards(hotel_id: widget.hotel_id, type_id: 2);
    await hotel_room_controller.getHotelRooms(hotel_id: widget.hotel_id);
    await hotel_controller.getSlider(
      type_name: 'Hotel Booking Screen',
      hotel_id: 1,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotel_controller.slider_loaded.value = false;
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (hotel_controller.slider_loaded.value)
          ? Scaffold(
              backgroundColor: AppColor.backgroundColor,
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: AppColor.background_card,
                surfaceTintColor: Colors.white,
                toolbarHeight: 150,
                flexibleSpace: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: HomeAppBar(
                    scaffoldKey: scaffoldKey,
                  ),
                ),
                leading: Container(),
              ),
              body: RefreshIndicator(
                color: AppColor.primary,
                onRefresh: _getData,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          //SLIDER SECTION

                          Container(
                            padding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // padding: EdgeInsets.only(left: 10, right: 10),
                                  child: SliderWidget(
                                    height: 280.0,
                                    radius: 30.0,
                                    counter_on_image: false,
                                  ),
                                ),

                                // ABOUT HOTEL SECTION

                                Container(
                                  child: Text(
                                    "About Hotel",
                                    style: AppFont.midBoldSecond,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                (!expaned)
                                    ? HtmlWidget(
                                        hotel_controller
                                            .hotel.value.about_hotel,
                                        // "<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>",
                                        customStylesBuilder: (element) {
                                          return {
                                            'overflow': 'hidden',
                                            'text-overflow': 'ellipsis',
                                            'max-lines': "2"
                                          };
                                        },
                                      )
                                    : Container(
                                        child: HtmlWidget(hotel_controller
                                                .hotel.value.about_hotel
                                            // "<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>",
                                            ),
                                      ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      expaned = !expaned;
                                    });
                                  },
                                  child: Text(
                                    (!expaned) ? 'show more ..' : 'show less',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                  ),
                                ),

                                // INCLUDES SECTION

                                SizedBox(
                                  height: 15,
                                ),
                                if(hotel_controller.hotel_includes.length >0)...[

                                SizedBox(
                                  height: 110,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        hotel_controller.hotel_includes.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: 100,
                                        height: 110,
                                        child: Card(
                                          color: AppColor.background_card,
                                          elevation: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  '${AppUrl.main_domain}uploads/hotel_includes/${hotel_controller.hotel_includes[index].icon}',
                                                  color: AppColor.primary,
                                                  height: 55,
                                                  width: 90,
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Text(hotel_controller
                                                    .hotel_includes[index].name)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ],

                                //HOTEL ROOMS

                                SizedBox(
                                  height: 15,
                                ),
                                if (hotel_room_controller.rooms.length > 0) ...[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Accommodation",
                                              textAlign: TextAlign.right,
                                              style: AppFont.midBoldSecond,
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text('Room'),
                                            //     SizedBox(
                                            //       width: 5,
                                            //     ),
                                            //     Text('Suite'),
                                            //   ],
                                            // )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 240,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: hotel_room_controller
                                                .rooms.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return rooms(
                                                room: hotel_room_controller
                                                    .rooms[index],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],

                                SizedBox(
                                  height: 15,
                                ),

                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: hotel_card_controller.card.length,
                                  itemBuilder: (context, index) =>
                                      HotelCardWidget(
                                    hotel_card:
                                        hotel_card_controller.card[index],
                                    hotel_id: widget.hotel_id,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2.3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height * 0.17),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              drawer: CustomDrawer(
                scaffoldKey: scaffoldKey,
              ),
              bottomSheet: BookingFooterBtn(),
            )
          : Scaffold(
              body: AnimatedLoader(),
            ),
    );
  }

  Widget rooms({required HotelRoom room}) {
    return InkWell(
      onTap: () => Get.to(RoomViewScreen(room_id: room.id)),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.1,
        child: Card(
          color: AppColor.background_card,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "${AppUrl.main_domain}/uploads/rooms/${room.image}",
                  fit: BoxFit.cover,
                  height: 130,
                  width: MediaQuery.of(context).size.width / 2.2,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${room.room_name}',
                            style: AppFont.midBoldSecond,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '${room.price} USD/ Night',
                            style: AppFont.midTinSecond,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => print('s'),
                        icon: Icon(
                          color: AppColor.background_card,
                          Icons.arrow_forward_ios,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bed,
                          size: 10,
                        ),
                        Text(
                          '${room.num_beds} Beds',
                          style: AppFont.midTinSecond,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.group_add,
                            size: 10,
                          ),
                          Text(
                            '${room.num_adults} Adult',
                            style: AppFont.midTinSecond,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
