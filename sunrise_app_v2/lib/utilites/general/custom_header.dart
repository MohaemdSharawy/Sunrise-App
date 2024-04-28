import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 57,
            width: MediaQuery.of(context).size.width / 1.6,
            child: CustomTextInput(
              hintText: 'Search hotel or deestinations',
              icon: Icons.search_rounded,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Container(
            height: 53,
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
