import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/screens/yourcart_screens/cart_screen.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';

class ViewBasketBtn extends StatelessWidget {
  ViewBasketBtn({super.key});

  final cardController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 10,
        padding: EdgeInsets.only(bottom: 15),
        height: 60,
        child: Obx(
          () => CustomBtn(
            action: () {
              if (cardController.my_order.length > 0) {
                Get.to(MyCartScreen());
              } else {
                Get.snackbar(
                  'Message',
                  'Card Is Empty',
                  // backgroundColor: AppColor.primary.withOpacity(0.8),
                  backgroundColor: AppColor.backgroundColor,
                );
              }
            },
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View Basket'),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.shopping_cart),
                SizedBox(
                  width: 5,
                ),
                Text('(${cardController.my_order.length.toString()})')
              ],
            ),
          ),
        ));
  }
}
