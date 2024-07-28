import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';

class CartCheckOutBtn extends StatelessWidget {
  void Function() action;
  CartCheckOutBtn({required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    final cardController = Get.find<CartController>();
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width - 10,
        padding: EdgeInsets.only(bottom: 15),
        height: 60,
        child: CustomBtn(
          action: action,
          title: Text('Check Out Price(${cardController.prices})'),
        ),
      ),
    );
  }
}
