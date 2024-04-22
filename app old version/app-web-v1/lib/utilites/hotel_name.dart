import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';

class HotelNameWidget extends StatefulWidget {
  var hid;
  var type;
  HotelNameWidget({this.hid, this.type, super.key});

  @override
  State<HotelNameWidget> createState() => _HotelNameWidgetState();
}

class _HotelNameWidgetState extends State<HotelNameWidget> {
  final hotelController = Get.put(HotelsController());

  @override
  void initState() {
    hotelController.getHotel(hid: widget.hid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (hotelController.hotel_loaded.value == true)
          ? Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  hotelController.hotel.value.hotel_name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          : Container();
    });
  }
}
