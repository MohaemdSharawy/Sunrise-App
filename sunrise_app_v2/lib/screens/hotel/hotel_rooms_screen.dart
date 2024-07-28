import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_rooms_controller.dart';
import 'package:sunrise_app_v2/screens/hotel/room_view_screen.dart';
import 'package:sunrise_app_v2/screens/wellness/spa_screen.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_drawer.dart';
import 'package:sunrise_app_v2/utilites/general/home_app_bar.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class HotelRoomsScreen extends StatefulWidget {
  int hotel_id;
  HotelRoomsScreen({required this.hotel_id, super.key});

  @override
  State<HotelRoomsScreen> createState() => _HotelRoomsScreenState();
}

class _HotelRoomsScreenState extends State<HotelRoomsScreen> {
  final GlobalKey<ScaffoldState> roomScaffold = GlobalKey<ScaffoldState>();
  final hotel_room_controller = Get.put(HotelRoomController());

  List<Map> menu = [
    {
      'name': 'SPA',
      'description':
          'Vestibulum auctor maximus leo, ac facilities est varuis  in .',
      'image':
          'https://res.cloudinary.com/simplotel/image/upload/x_0,y_4,w_916,h_515,r_0,c_crop,q_90,fl_progressive/w_1650,f_auto,c_fit/hablis-hotel-chennai/couple_spa_at_hablis',
      'link': SpaScreen(
        code: 's',
      )
    },
    {
      'name': 'Gym',
      'description':
          'Vestibulum auctor maximus leo, ac facilities est varuis  in .',
      'image':
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'link': SpaScreen(
        code: 's',
      )
    }
  ];

  _getData() async {
    await hotel_room_controller.getHotelRooms(hotel_id: widget.hotel_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotel_room_controller.room_loaded.value = false;
      _getData();
    });
    super.initState();
  }

  var selectedOption;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      key: roomScaffold,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: 150,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 15),
          child: HomeAppBar(
            scaffoldKey: roomScaffold,
          ),
        ),
        leading: Container(),
      ),
      body: Obx(
        () => (hotel_room_controller.room_loaded.value)
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      headerFilter(context: context),
                      ListView.builder(
                        itemCount: hotel_room_controller.rooms.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => Get.to(
                              RoomViewScreen(
                                  room_id:
                                      hotel_room_controller.rooms[index].id),
                            ),
                            child: Container(
                              // padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: AppColor.background_card,
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RoomSlider(
                                      images: hotel_room_controller
                                          .rooms[index].gallery,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        hotel_room_controller
                                            .rooms[index].room_name,
                                        style: AppFont.smallBoldBlack,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.bed_outlined,
                                                size: 15,
                                              ),
                                              Text(
                                                '${hotel_room_controller.rooms[index].num_beds} ${hotel_room_controller.rooms[index].bed_type}',
                                                style: AppFont.midTinSecond,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outlined,
                                                size: 15,
                                              ),
                                              Text(
                                                '${hotel_room_controller.rooms[index].num_adults} Adult',
                                                style: AppFont.midTinSecond,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
      drawer: CustomDrawer(
        scaffoldKey: roomScaffold,
      ),
    );
  }

  Widget headerFilter({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rooms',
            style: AppFont.smallBoldBlack,
          ),
          Container(
            height: 35,
            width: 35,
            child: IconButton(
              icon: Icon(Icons.display_settings_sharp),
              onPressed: () async {
                // await categoryController.get_categories_type(
                //   code: widget.code,
                // );
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SingleChildScrollView(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 25),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price Range',
                                        style: AppFont.midBoldSecond,
                                      ),
                                      RangeSlider(
                                        activeColor: AppColor.primary,
                                        inactiveColor: AppColor.second,
                                        values: _currentRangeValues,
                                        max: 100,
                                        divisions: 100,
                                        labels: RangeLabels(
                                          _currentRangeValues.start
                                              .round()
                                              .toString(),
                                          _currentRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            _currentRangeValues = values;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Text('All'),
                                  leading: Radio<int>(
                                    value: 0,
                                    groupValue: selectedOption,
                                    splashRadius:
                                        20, // Change the splash radius when clicked
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Suite'),
                                  leading: Radio<int>(
                                    value: 1,
                                    groupValue: selectedOption,
                                    splashRadius:
                                        20, // Change the splash radius when clicked
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Room'),
                                  leading: Radio<int>(
                                    value: 2,
                                    groupValue: selectedOption,
                                    splashRadius:
                                        20, // Change the splash radius when clicked
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomBtn(
                                      height: 40,
                                      title: Text('Change '),
                                      color: AppColor.primary,
                                      action: () async {
                                        Navigator.pop(context);
                                        // _getData(
                                        //     type: selectedOption.toString());
                                      },
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    CustomBtn(
                                      title: Text('Close'),
                                      height: 40,
                                      color: AppColor.second,
                                      action: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
          // : Container(
          //     width: 10,
          //     height: 10,
          //     child: CircularProgressIndicator(
          //       color: AppColor.primary,
          //     ),
          //   )
        ],
      ),
    );
  }
}

class RoomSlider extends StatefulWidget {
  List images;
  RoomSlider({required this.images, super.key});

  @override
  State<RoomSlider> createState() => _RoomSliderState();
}

class _RoomSliderState extends State<RoomSlider> {
  @override
  void initState() {
    print(widget.images);
    super.initState();
  }

  int _sliderIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider.builder(
                options: CarouselOptions(
                  height: double.maxFinite,
                  autoPlay: false,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  autoPlayInterval: Duration(seconds: 5),
                  enlargeCenterPage: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _sliderIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ImageCustom(
                          image:
                              "${AppUrl.main_domain}/uploads/hotel_gallery/${widget.images[index]}",
                          // image: AppUrl.main_domain +
                          //     'uploads/hotel_gallery/' +
                          //     hotel_controller.sliders[_sliderIndex],
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ));
                },
                itemCount: widget.images.length),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // margin: EdgeInsets.only(top: 150),
                height: 50.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black54),
                        shape: BoxShape.circle,
                        color: _sliderIndex == index
                            ? AppColor.primary
                            : AppColor.third,
                      ),
                    );
                  },
                  itemCount: widget.images.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
