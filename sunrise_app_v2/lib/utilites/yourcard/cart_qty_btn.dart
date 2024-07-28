import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/category_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_model.dart';

class CartQtyBtn extends StatefulWidget {
  int? have_index;
  Product? productData;
  bool allow_delete;
  CartQtyBtn({
    this.have_index,
    this.productData,
    this.allow_delete = true,
    super.key,
  });

  @override
  State<CartQtyBtn> createState() => _CartQtyBtnState();
}

class _CartQtyBtnState extends State<CartQtyBtn> {
  final cartController = Get.find<CartController>();
  final categoryController = Get.find<CategoryController>();
  void increment() async {
    if (product_index == null) {
      cartController.addTOCard(
        widget.productData,
        categoryController.restaurant.value,
      );
      cartController.custom_loaded.value = false;
      cartController.current_product_qty.value = 1;
      await cartController.product_custom(product_id: widget.productData!.id);
      setState(() {
        product_index =
            cartController.get_product_cart_index(widget.productData!.id);
      });
    } else {
      cartController.increment(index: product_index!);
      setState(() {
        cartController.my_order = cartController.my_order;
      });
    }
  }

  void decrement() {
    //! Allow delete To Make min Qty 1
    if (product_index != null) {
      if (cartController.my_order[product_index!]['qty'] == 1 &&
          widget.allow_delete) {
        cartController.deleteItem(index: product_index!);
        cartController.current_product_qty.value = 0;
        setState(() {
          product_index = null;
        });
      } else {
        cartController.decrement(index: product_index!);
      }
      setState(() {
        cartController.my_order = cartController.my_order;
      });
    }
    print(cartController.my_order);
  }

  late int? product_index;

  @override
  void initState() {
    if (widget.have_index != null) {
      product_index = widget.have_index;
    } else {
      product_index =
          cartController.get_product_cart_index(widget.productData!.id);
    }
    // note.text = cartController.my_order[product_index!]['notes'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      // width: MediaQuery.of(context).size.width / ,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () => decrement(),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 30,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              (product_index == null)
                  ? '0'
                  : cartController.my_order[product_index!]['qty'].toString(),
              style: TextStyle(color: AppColor.background_card, fontSize: 16),
            ),
          ),
          InkWell(
            onTap: () {
              increment();
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
