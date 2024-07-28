import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/category_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cart_check_out_btn.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cart_notes.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cart_qty_btn.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cutom_option_radio.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final cartController = Get.put(CartController());
  final categoryController = Get.put(CategoryController());
  final restaurantController = Get.put(RestaurantController());

  Future book_order() async {
    // var check_in_data = jsonDecode(GetStorage().read('check_in_hotel'));

    await cartController.bookOrder(
        context: context,
        restaurant_id: cartController.my_order[0]['res_id'],
        room_no: '1000000',
        table: 0,
        products: cartController.my_order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomSheet: CartCheckOutBtn(
        action: () => book_order(),
      ),
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColor.background_card,
                    // color: Color.fromARGB(255, 240, 232, 232),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: CustomStayHeader(
                    title: Text(
                      restaurantController.hotel_name.value,
                      style: AppFont.boldBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.my_order.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: Card(
                        color: AppColor.background_card,
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Obx(
                            () => CartProduct(
                              product: cartController.my_order[index],
                              product_index: index,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartProduct extends StatefulWidget {
  var product;
  int product_index;
  CartProduct({this.product, required this.product_index, super.key});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final cartController = Get.find<CartController>();

  void deleteItem(index) {
    cartController.deleteItem(index: index);
    setState(() {
      cartController.my_order = cartController.my_order;
    });
  }

  bool loadcustom = true;

  void loaded() {
    setState(() {
      loadcustom = !loadcustom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      widget.product['name'],
                      style: AppFont.smallBlack,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Text(
                    "Price: ${widget.product['price']}",
                    style: AppFont.tinyBlack,
                  ),
                  SizedBox(height: 5),
                  if (!widget.product['custom_option'].isEmpty) ...[
                    for (var item in widget.product['custom_option'])
                      Row(
                        children: [
                          Text(
                            '${item['custom_option_name']} : ',
                            style: AppFont.tinyBlack,
                          ),
                          Text(
                            item['custom_option_item_name'],
                            style: AppFont.tinyBlack,
                          ),
                        ],
                      )
                  ],
                  Row(
                    children: [
                      CartQtyBtn(
                        have_index: widget.product_index,
                        allow_delete: true,
                      ),
                      InkWell(
                        onTap: () {
                          deleteItem(widget.product_index);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Card(
                            color: AppColor.primary,
                            child: Icon(
                              Icons.delete,
                              color: AppColor.background_card,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          loaded();
                          await cartController.product_custom(
                            product_id: widget.product['product_id'],
                          );
                          loaded();
                          showModalBottomSheet<void>(
                            context: context,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return showCustom();
                                },
                              );
                            },
                          );
                        },
                        child: (loadcustom)
                            ? Container(
                                height: 40,
                                width: 40,
                                child: Card(
                                  color: AppColor.primary,
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColor.background_card,
                                  ),
                                ),
                              )
                            : Container(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                ),
                              ),
                      ),
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  print(widget.product['custom_option']);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image.network(
                    '${AppUrl.restaurant_domain}assets/uploads/products/${widget.product['img_name']}',
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CartNotes(
            have_index: widget.product_index,
          )
        ],
      ),
    );
  }

  Widget showCustom() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: <Widget>[
              (cartController.custom_option.length > 0)
                  ? ProductCustomOption(
                      have_index: widget.product_index,
                    )
                  : Center(
                      child: Text(
                        'There is No Custom Option for This Product',
                        style: AppFont.tinyGrey,
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomBtn(
                    title: Text('Close'),
                    height: 40,
                    color: AppColor.second,
                    action: () {
                      setState(() {});
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
