import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/categories_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/workingDaysController.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/img.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantInfoScreen extends StatefulWidget {
  var restaurant_code;
  RestaurantInfoScreen({this.restaurant_code, super.key});

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen>
    with BaseController {
  final categoriesController = Get.put(CategoriesController());
  final hotelController = Get.put(HotelsController());
  final workingDayController = Get.put(WorkingDayController());

  // List working_days = [];
  // List saturday = [];
  // List sunday = [];
  // List monday = [];
  // List tuesday = [];
  // List wednesday = [];
  // List thursday = [];
  // List friday = [];

  // void addDataToDay(workingList, day) {
  //   // print('satrday ----->${workingList.work}');r
  //   if (workingList.work == "1") {
  //     if (workingList.from_time == '') {
  //       day.add('24 Hours');
  //     } else {
  //       day.add(workingList.from_time + '-' + workingList.to_time);
  //     }
  //   }
  // }

  // void workingDayHandler(workingDays) {
  //   for (var i = 0; i < workingDays.length; i++) {
  //     switch (workingDays[i].day) {
  //       case "Saturday":
  //         addDataToDay(workingDays[i], saturday);
  //         break;
  //       case "Sunday":
  //         addDataToDay(workingDays[i], sunday);

  //         break;
  //       case "Monday":
  //         addDataToDay(workingDays[i], monday);

  //         break;
  //       case "Tuesday":
  //         addDataToDay(workingDays[i], tuesday);

  //         break;
  //       case "Wednesday":
  //         addDataToDay(workingDays[i], wednesday);

  //         break;
  //       case "Thursday":
  //         addDataToDay(workingDays[i], thursday);

  //         break;
  //       case "Friday":
  //         addDataToDay(workingDays[i], friday);

  //         break;
  //       default:
  //         print('Not Found');
  //     }
  //   }

  //   print(saturday);
  // }

  String day_selected = DateFormat('EEEE').format(DateTime.now());

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.restaurant_code,
      api_type: 'restaurant_code',
    );
    await categoriesController.guestCategories(
        restaurant_code: widget.restaurant_code);
    // print(categoriesController.restaurant[0].description);

    // await workingDayController.getWorkingDays(
    //     restaurant_id: int.parse(categoriesController.restaurant[0].id));
    // workingDayHandler(workingDayController.workingDay);

    await workingDayController.getSingleWorkingDay(
      restaurant_code: widget.restaurant_code,
      day: day_selected,
    );
    workingDayController.singleWorkingDayLoaded.value = true;
  }

  final List<DropdownMenuItem> list = [
    DropdownMenuItem(value: "Monday", child: Text("Monday")),
    DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
    DropdownMenuItem(value: "Wednesday", child: Text("Wednesday")),
    DropdownMenuItem(value: "Thursday", child: Text("Thursday")),
    DropdownMenuItem(value: "Friday", child: Text("Friday")),
    DropdownMenuItem(value: "Saturday", child: Text("Saturday")),
    DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      workingDayController.singleWorkingDayLoaded.value = false;
      _getData();
    });
    super.initState();
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(
        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].pdf_menu}'))) {
      await launchUrl(
          Uri.parse(
              'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].pdf_menu}'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (workingDayController.singleWorkingDayLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    const select_Text = TextStyle(color: Colors.white, fontSize: 15);

    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                AppBarWidget(
                  h_id: categoriesController.restaurant[0].hid,
                ),
                SizedBox(
                  height: 40,
                ),
                (categoriesController.restaurant[0].white_logo != '')
                    ? Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].white_logo}',
                        height: 150,
                      )
                    : Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].logo}',
                        height: 150,
                      ),
                SizedBox(
                  width: 650,
                  child: Center(
                      child: Text(
                    categoriesController.restaurant[0].description,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 500,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    // margin: EdgeInsets.only(left: 20, bottom: 20),
                    child: (categoriesController.restaurant[0].image != '')
                        ? Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].image}',
                            height: 250,
                            width: 150,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].logo}',
                            height: 120,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                    // child: Image.network(
                    //   'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].image}',
                    //   height: 120,
                    //   width: 150,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),

                SizedBox(height: 25),
                Text('Opening Day',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "Sans-bold"))
                    .tr(),
                SizedBox(height: 25),

                SizedBox(
                  width: 450,
                  child: DropdownButton<dynamic>(
                    underline: Container(
                      padding: EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: Divider(color: Colors.white),
                    ),
                    dropdownColor: Colors.black,
                    style: select_Text,
                    value: day_selected,
                    items: list,
                    onChanged: (newValue) {
                      setState(() async {
                        day_selected = newValue;
                        showLoading();
                        await workingDayController.getSingleWorkingDay(
                          restaurant_code: widget.restaurant_code,
                          day: day_selected,
                        );
                        // await hotelGuide.getEntertainment(
                        //     h_id: int.parse(widget.h_id), day_id: day_selected);
                        hideLoading();
                      });
                    },
                  ),
                ),

                SizedBox(height: 25),

                SizedBox(
                  height: 70.0 * workingDayController.singleWorkingDay.length,
                  child: ListView.builder(
                    itemCount: workingDayController.singleWorkingDay.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          (workingDayController.singleWorkingDay[index].work ==
                                  "1")
                              ? (workingDayController
                                          .singleWorkingDay[index].from_time !=
                                      "")
                                  ? '${workingDayController.singleWorkingDay[index].from_time} - ${workingDayController.singleWorkingDay[index].to_time}'
                                  : '24H'
                              : "Closed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: "Sans-bold"),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Center(
                  child: SizedBox(
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(0.6)),
                          child: Text('PDF Menu').tr(),
                          onPressed: () {
                            _launchUrl();
                          },
                        ),
                        (GetStorage().read('room_num') != '')
                            ? (categoriesController.restaurant[0].ordering ==
                                    "1")
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 15),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Colors.white.withOpacity(0.6)),
                                      child: Text('Book Now').tr(),
                                      onPressed: () {
                                        // Get.to(BookingScreen(
                                        //   hotel: widget.hotel,
                                        //   restaurant: widget.restaurant,
                                        // ));
                                        Navigator.pushNamed(context,
                                            '/book-restaurant/${widget.restaurant_code}');
                                      },
                                    ),
                                  )
                                : Container()
                            : Container(),
                      ],
                    ),
                  ),
                )

                // Text(
                //   'Saturday: ',
                //   style: TextStyle(color: Colors.white),
                // ),
                // ListView.builder(
                //   itemCount: saturday.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Text(
                //       saturday[index],
                //       style: TextStyle(color: Colors.white),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
        // restaurantItem(),
      ],
    );
  }

  // Widget buildOpenDays() {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Text(
  //             'Saturday: ',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           ListView.builder(
  //             itemCount: saturday.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Text(
  //                 saturday[index].toString(),
  //                 style: TextStyle(color: Colors.white),
  //               );
  //             },
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
