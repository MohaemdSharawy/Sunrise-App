import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';

class EntertainmentScreen extends StatefulWidget {
  var h_id;
  EntertainmentScreen({this.h_id, super.key});

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen>
    with BaseController {
  final hotelController = Get.put(HotelsController());
  final hotelGuide = Get.put(HotelGuideController());
  @override
  int day_selected = 0;
  late String title;

  _getData() async {
    day_selected = today_id();
    hotelGuide.entertainment_load.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await hotelController.getHotel(hid: widget.h_id);
    if (hotelController.hotel.value.company_id == "2") {
      title = 'Boat Entertainment';
    } else {
      title = 'Hotel Entertainment';
    }

    await hotelGuide.getEntertainment(
      h_id: int.parse(widget.h_id),
      day_id: today_id(),
    );
  }

  void initState() {
    _getData();
    super.initState();
  }

  int today_id() {
    final today = DateTime.now();
    return today.weekday;
  }

  String convertTime(time) {
    var splitTime = time.split(':');
    // print(splitTime);
    return splitTime[0] + ':' + splitTime[1];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListExpandAdapter().getView(),
      body: Obx(
        () {
          return (hotelGuide.entertainment_load.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
    );
  }

  Widget mainBody() {
    const select_Text = TextStyle(color: Colors.white, fontSize: 15);

    final List<DropdownMenuItem> list = [
      DropdownMenuItem(value: 1, child: Text("Monday")),
      DropdownMenuItem(value: 2, child: Text("Tuesday")),
      DropdownMenuItem(value: 3, child: Text("Wednesday")),
      DropdownMenuItem(value: 4, child: Text("Thursday")),
      DropdownMenuItem(value: 5, child: Text("Friday")),
      DropdownMenuItem(value: 6, child: Text("Saturday")),
      DropdownMenuItem(value: 7, child: Text("Sunday")),
    ];
    return Stack(
      children: [
        // BackGroundWidget(),
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
            margin: EdgeInsets.only(top: 35, bottom: 105),
            // padding: EdgeInsets.only(bottom: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontFamily: 'Northwell'),
                    ).tr(),
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: 650,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      margin: EdgeInsets.only(top: 70),
                      child: DropdownButton<dynamic>(
                        dropdownColor: Colors.black,
                        style: select_Text,
                        value: day_selected,
                        items: list,
                        onChanged: (newValue) {
                          setState(() async {
                            day_selected = newValue;
                            showLoading();
                            await hotelGuide.getEntertainment(
                                h_id: int.parse(widget.h_id),
                                day_id: day_selected);
                            hideLoading();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(child: table()),
                SizedBox(
                  height: 20,
                ),
                Text('The Attached Program Subject To Location Changes Due To Weather Condition',
                        style: TextStyle(color: Colors.white, fontSize: 30))
                    .tr(),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 100),

        // ),

        HeaderScreen()
      ],
    );
  }

  Widget table() {
    const style = TextStyle(color: Colors.white, fontSize: 20);
    const smallText = TextStyle(color: Colors.white, fontSize: 15);

    var entertainment = hotelGuide.entertainment;
    List<DataRow> rows = entertainment
        .map((element) => DataRow(cells: [
              DataCell(Text(
                element.event,
                style: smallText,
              )),
              DataCell(Center(
                  child: Text(
                element.location,
                style: smallText,
              ))),
              DataCell(Center(
                child: (element.to != '')
                    ? Text(
                        convertTime(element.from) +
                            '-' +
                            convertTime(element.to),
                        style: smallText,
                      )
                    : Text(
                        convertTime(element.from),
                        style: smallText,
                      ),
              )),
              // DataCell(Center(
              //   child: (element.to != '')
              //       ? Text(
              //           element.to,
              //           style: smallText,
              //         )
              //       : Text(
              //           '---',
              //           style: smallText,
              //         ),
              // )),
            ]))
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.white),
        child: DataTable(
          // headingRowHeight: 0,
          columns: [
            DataColumn(
              label: Container(
                width: 200,
                child: Text(
                  'Event',
                  style: style,
                ).tr(),
              ),
            ),
            DataColumn(
              label: Container(
                width: 200,
                child: Center(
                  child: Text(
                    'Location',
                    style: style,
                  ).tr(),
                ),
              ),
            ),
            DataColumn(
              label: Container(
                width: 200,
                child: Center(
                  child: Text(
                    'Time',
                    style: style,
                  ).tr(),
                ),
              ),
            ),
            // DataColumn(
            //   label: Text(
            //     'To',
            //     style: style,
            //   ),
            // ),
          ],
          rows: rows,
        ),
      ),
    );
  }
}
