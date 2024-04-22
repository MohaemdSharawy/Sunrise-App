import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/utilites/img.dart';

class BackGroundWidget extends StatefulWidget {
  var search_key;
  var api_type;
  var screen_type;
  BackGroundWidget({
    this.search_key,
    this.api_type,
    this.screen_type,
    super.key,
  });

  @override
  State<BackGroundWidget> createState() => _BackGroundWidgetState();
}

class _BackGroundWidgetState extends State<BackGroundWidget> {
  final hotelController = Get.put(HotelsController());

  // _getData() async {
  //   await hotelController.getBackGround(
  //     hid: widget.search_key,
  //     screen_type: widget.screen_type,
  //   );
  //   print(hotelController.screen_img);
  // }

  // @override
  // void initState() {
  //   // _getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   return (hotelController.backGroundLoaded.value = true)
    //       ? Stack(
    //           children: [
    //             Image.asset(
    //                 'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.screen_img}',
    //                 width: double.infinity,
    //                 height: double.infinity,
    //                 fit: BoxFit.cover),
    //             Center(
    //               child: Center(child: CircularProgressIndicator()),
    //             ),
    //           ],
    //         )
    //       : Container();
    // });
    return Center(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
