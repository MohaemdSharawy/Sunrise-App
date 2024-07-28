import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_rooms_controller.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_gallery_view.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

class RoomViewScreen extends StatefulWidget {
  int room_id;
  RoomViewScreen({required this.room_id, super.key});

  @override
  State<RoomViewScreen> createState() => _RoomViewScreenState();
}

class _RoomViewScreenState extends State<RoomViewScreen> {
  final hotel_room_controller = Get.put(HotelRoomController());

  Future<void> _getData() async {
    await hotel_room_controller.getRoom(room_id: widget.room_id);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (hotel_room_controller.single_room_load.value)
            ? RefreshIndicator(
                onRefresh: _getData,
                child: SafeArea(
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
                              Container(
                                margin: EdgeInsets.only(
                                    top: 35, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor.background_card,
                                      ),
                                      // padding: EdgeInsets.all(5),
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_back),
                                        onPressed: () => Get.back(),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor.background_card,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () => print('ss'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height /
                                          3, //minimum height
                                ),
                                margin: EdgeInsets.only(top: 330),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColor.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            hotel_room_controller
                                                .room.value.room_name,
                                            style: AppFont.largeSecond,
                                          ),
                                          Text(
                                            "${hotel_room_controller.room.value.price}/Night",
                                            style: AppFont.largeSecond,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (hotel_room_controller
                                        .room.value.posh_club) ...[
                                      Container(
                                        padding: EdgeInsets.only(left: 3),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: AppColor.second,
                                            ),
                                            Text(
                                              'Posh Club Applicable',
                                              style: AppFont.midSecond,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      // padding:
                                      //     EdgeInsets.only(left: , right: 20),
                                      child: Wrap(
                                        spacing: 25,
                                        children: [
                                          boxInfo(
                                            info:
                                                '${hotel_room_controller.room.value.num_adults}  Adult',
                                          ),
                                          boxInfo(
                                            info:
                                                '${hotel_room_controller.room.value.num_beds}  Bed',
                                          ),
                                          boxInfo(
                                            info:
                                                '${hotel_room_controller.room.value.bed_type}',
                                          ),
                                          boxInfo(
                                            info:
                                                '${hotel_room_controller.room.value.room_view}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 110,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: hotel_room_controller
                                            .room.value.includes.length,
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
                                                      '${AppUrl.main_domain}uploads/hotel_includes/${hotel_room_controller.room.value.includes[index].icon}',
                                                      color: AppColor.primary,
                                                      height: 55,
                                                      width: 90,
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      hotel_room_controller
                                                          .room
                                                          .value
                                                          .includes[index]
                                                          .name,
                                                      style: AppFont.midSecond,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Desorption',
                                      style: AppFont.midSecond,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 5, left: 10),
                                      child: Text(
                                        hotel_room_controller
                                            .room.value.desorption,
                                        style: AppFont.midSecond,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        'Gallery',
                                        style: AppFont.smallBlack,
                                      ),
                                    ),
                                    CustomGalleryView(
                                      images: hotel_room_controller
                                          .roomGalleryHandel(),
                                    ),
                                    SizedBox(
                                      height: 12,
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
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }

  Widget boxInfo({required String info}) {
    return Container(
      // padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        elevation: 0,
        color: AppColor.background_card,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Text(info),
        ),
      ),
    );
  }
}
