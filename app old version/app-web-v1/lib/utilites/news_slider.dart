import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSliderWidget extends StatelessWidget with BaseController {
  const NewsSliderWidget({super.key});

  @override
  Future<void> _launchUrl() async {
    showLoading();
    if (await canLaunchUrl(Uri.parse(
        'https://tickets.sunrise-resorts.com/breaking_news/breaking-news.pdf'))) {
      await launchUrl(
        Uri.parse(
            'https://tickets.sunrise-resorts.com/breaking_news/breaking-news.pdf'),
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available Now PLease Try Again Later',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    hideLoading();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        _launchUrl();
      }),
      child: SizedBox(
        height: 70,
        child: Marquee(
          text: 'Breaking News ......',
          style: TextStyle(
              fontFamily: 'Northwell',
              // fontWeight: FontWeight.bold,
              fontSize: 55,
              color: Colors.white),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
        ),
      ),
    );
  }
}
