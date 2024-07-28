import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class CustomHeader extends StatefulWidget {
  double speace;
  bool back_icon;
  CustomHeader({this.back_icon = false, this.speace = 25.0, super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (!widget.back_icon)
          ? EdgeInsets.all(12.0)
          : EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.back_icon) ...[
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back),
            )
          ],
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 50,
            width: MediaQuery.of(context).size.width / 1.8,
            child: CustomTextInput(
              hintText: 'Search hotel or deestinations',
              icon: Icons.search_rounded,
            ),
          ),
          // SizedBox(
          //   width: widget.speace,
          // ),
          Container(
            height: 50,
            padding: EdgeInsets.only(right: 8),
            child: CustomBtn(
                title: Text('Check In'),
                action: () => {print('Chick in Clicked')}),
          ),
        ],
      ),
    );
  }
}
