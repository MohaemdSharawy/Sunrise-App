import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/utilites/background.dart';

import '../../../utilites/header_screen.dart';

class TvGuideScreen extends StatefulWidget {
  var h_id;
  TvGuideScreen({this.h_id, super.key});

  @override
  State<TvGuideScreen> createState() => _TvGuideScreenState();
}

class _TvGuideScreenState extends State<TvGuideScreen> {
  final hotelController = Get.put(HotelsController());
  final hotelGuide = Get.put(HotelGuideController());

  _getData() async {
    hotelGuide.info_loaded.value = true;
    await hotelController.getBackGround(search_key: widget.h_id);
    await hotelGuide.getTvGuid(h_id: int.parse(widget.h_id));
    print(hotelGuide.tv_guide[0].name_channel);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (hotelGuide.tv_loaded.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
    );
  }

  Widget mainBody() {
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
          child: Column(
            children: [
              HeaderScreen(),
              Container(
                // margin: EdgeInsets.only(top: 35, bottom: 25),
                // padding: EdgeInsets.only(bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TV Guide',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                          fontFamily: 'Northwell'),
                    ).tr(),
                  ],
                ),
              ),
              table(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget table() {
    const style = TextStyle(color: Colors.white, fontSize: 20);
    const smallText = TextStyle(color: Colors.white, fontSize: 15);

    var tv_guide = hotelGuide.tv_guide;
    List<DataRow> rows = tv_guide
        .map((element) => DataRow(cells: [
              DataCell(Center(
                child: Text(
                  element.name_channel,
                  style: smallText,
                ),
              )),
              DataCell(SizedBox(
                width: 70,
                height: 70,
                child: Center(
                    child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://hotelguide.sunrise-resorts.com/attach/${element.logo}',
                  ),
                  radius: 70,
                )),
              )),
              DataCell(Center(
                child: Text(
                  element.type,
                  style: smallText,
                ),
              )),
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
                label: Text(
              'Channel',
              style: style,
            )),
            DataColumn(
                label: Text(
              'Logo',
              style: style,
            )),
            DataColumn(
                label: Text(
              'Category',
              style: style,
            )),
          ],
          rows: rows

          // DataRow(
          //   cells: [
          //     DataCell(Text(
          //       'No. of Rooms',
          //       style: style,
          //       // style: TextStyle(fontSize: 18),
          //     )),
          //     DataCell(Text(
          //       'reservationController',
          //       style: style,
          //     ))
          //   ],
          // ),
          ,
        ),
      ),
    );
  }
}
