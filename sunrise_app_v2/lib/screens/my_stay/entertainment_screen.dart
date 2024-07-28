import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/entertainment_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/models/entertainment_model.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class EntertainmentScreen extends StatefulWidget {
  int hotel_id;
  EntertainmentScreen({required this.hotel_id, super.key});

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

const select_Text = TextStyle(
  color: AppColor.second,
  fontSize: 20,
);

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  final entertainmentController = Get.put(EntertainmentController());
  final hotel_controller = Get.put(HotelController());

  final List<DropdownMenuItem> list = [
    DropdownMenuItem(value: 'Monday', child: Text("Monday")),
    DropdownMenuItem(value: 'Tuesday', child: Text("Tuesday")),
    DropdownMenuItem(value: 'Wednesday', child: Text("Wednesday")),
    DropdownMenuItem(value: 'Thursday', child: Text("Thursday")),
    DropdownMenuItem(value: 'Friday', child: Text("Friday")),
    DropdownMenuItem(value: 'Saturday', child: Text("Saturday")),
    DropdownMenuItem(value: 'Sunday', child: Text("Sunday")),
  ];
  String day_selected = DateFormat('EEEE').format(DateTime.now()).toString();

  _getData() async {
    await hotel_controller.getSlider(
      type_name: 'Entertainment Screen',
      hotel_id: widget.hotel_id,
    );
    await hotel_controller.hotel_view(hotel_id: widget.hotel_id);
    await entertainmentController.getEntertainment(
      hotel_id: widget.hotel_id,
      day: day_selected,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      entertainmentController.entertainment_loaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (entertainmentController.entertainment_loaded.value)
            ? SingleChildScrollView(
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
                                  hotel_controller.hotel.value.hotel_name,
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
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 10),
                                    margin: EdgeInsets.only(
                                        top: 15, left: 25, right: 25),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0.5,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                      ),
                                    ),
                                    child: DropdownButton<dynamic>(
                                      padding: EdgeInsets.only(left: 15),
                                      isExpanded: true,
                                      dropdownColor: Colors.grey,
                                      underline: Container(),
                                      style: select_Text,
                                      value: day_selected,
                                      items: list,
                                      onChanged: (newValue) async {
                                        setState(() {
                                          day_selected = newValue;
                                        });
                                        _getData();
                                      },
                                    ),
                                  ),
                                ),

                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: entertainmentController
                                        .entertainment.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomTimelineTile(
                                        isFirst: index == 0,
                                        isLast: index ==
                                            entertainmentController
                                                    .entertainment.length -
                                                1,
                                        exercise: entertainmentController
                                            .entertainment[index],
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
              )
            : AnimatedLoader(),
      ),
    );
  }
}

class CustomTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final EntertainmentModel exercise;

  const CustomTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          color: AppColor.primary,
          indicator: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.primary),
              child: const Center(
                child: Icon(Icons.circle),
              )),
        ),
        afterLineStyle: LineStyle(
          thickness: 1,
          color: AppColor.primary,
        ),
        beforeLineStyle: LineStyle(
          thickness: 1,
          color: AppColor.primary,
        ),
        endChild: EntertainmentCard(entertainment: exercise),
      ),
    );
  }
}

class EntertainmentCard extends StatelessWidget {
  final EntertainmentModel entertainment;

  const EntertainmentCard({super.key, required this.entertainment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${entertainment.event} ",
                    style: AppFont.smallBoldBlack,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${entertainment.event} ",
                    style: AppFont.tinyBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('From ${entertainment.from} | To ${entertainment.to}')
                ],
              ),
            ),
            // child: ListTile(
            //   leading: const Icon(Icons.fitness_center),
            //   title: Text(
            //       "${entertainment.event} Test tets yevxj  hfv n vsds djvnsdvjkns  jsdvjksj"),
            //   subtitle: Text('150 kcal | 70 min'),
            // ),
          ),
        ],
      ),
    );
  }
}

class Exercise {
  final String name;
  final int calories;
  final int minutes;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.calories,
    required this.minutes,
    this.isCompleted = false,
  });
}
