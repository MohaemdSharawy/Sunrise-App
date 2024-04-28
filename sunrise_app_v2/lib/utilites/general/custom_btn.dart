import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';

class CustomBtn extends StatelessWidget {
  Color color;
  void Function() action;
  Widget title;
  double height;
  CustomBtn({
    this.height = 70.0,
    required this.title,
    required this.action,
    this.color = AppColor.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
      onPressed: action,
      textColor: Colors.white,
      color: color,
      child: title,
    );
  }
}
