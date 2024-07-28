import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_btn.dart';

class BookingFooterBtn extends StatelessWidget {
  Future<void> _launchUrl() async {
    await launchUrl(
      Uri.parse('https://www.sunrise-resorts.com'),
      mode: LaunchMode.externalApplication,
    );
    // if (await canLaunchUrl(Uri.parse('https://www.sunrise-resorts.com'))) {
    //   await launchUrl(Uri.parse('https://www.sunrise-resorts.com'),
    //       mode: LaunchMode.externalApplication);
    // } else {
    //   Get.snackbar(
    //     'Message',
    //     // '${error}',
    //     'Sorry This Not Available',
    //     // snackPosition: SnackPosition.BOTTOM,
    //     // backgroundColor: Colors.red,
    //     // colorText: Colors.white,
    //   );
    // }
  }

  const BookingFooterBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: EdgeInsets.only(bottom: 15),
      height: 60,
      child: CustomBtn(
        action: () {
          _launchUrl();
        },
        title: Text('Book Now'),
      ),
    );
  }
}
