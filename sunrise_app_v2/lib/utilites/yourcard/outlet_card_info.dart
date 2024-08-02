import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';

class OutLetCardScreen extends StatelessWidget {
  String title;
  String description;
  OutLetCardScreen({required this.title, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: AppColor.background_card,
        elevation: 0.5,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                title,
                style: AppFont.midBoldSecond,
              ),
            ),
            Text(
              description,
              style: TextStyle(color: AppColor.primary),
            )
          ],
        ),
      ),
    );
  }
}
