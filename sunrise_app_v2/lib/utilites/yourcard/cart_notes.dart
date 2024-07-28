import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_model.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class CartNotes extends StatefulWidget {
  Product? productData;
  int? have_index;
  CartNotes({this.have_index, this.productData, super.key});

  @override
  State<CartNotes> createState() => _CartNotesState();
}

class _CartNotesState extends State<CartNotes> {
  final cartController = Get.find<CartController>();
  final TextEditingController note = TextEditingController();

  double left_padding = 10;
  double right_padding = 25;
  late int? product_index;

  @override
  void initState() {
    if (widget.have_index != null) {
      product_index = widget.have_index;
      note.text = cartController.my_order[product_index!]['notes'];
    } else {
      product_index =
          cartController.get_product_cart_index(widget.productData!.id);
      if (product_index != null) {
        note.text = cartController.my_order[product_index!]['notes'];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: left_padding,
            right: right_padding,
          ),
          child: Text(
            'Notes',
            style: AppFont.smallBoldBlack,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          padding: EdgeInsets.only(
            left: left_padding,
            right: right_padding,
          ),
          // margin: EdgeInsets.only(bottom: 50),
          child: CustomTextInput(
            controller: note,
            hintText: 'Notes',
            icon: Icons.note,
            onChanged: ((value) {
              setState(() {
                cartController.my_order[product_index!]['notes'] = value;
              });
              cartController.saveCardData();
            }),
          ),
        ),
      ],
    );
  }
}
