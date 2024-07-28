import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_model.dart';

class ProductCustomOption extends StatefulWidget {
  Product? productData;
  int? have_index;
  ProductCustomOption({this.productData, this.have_index, super.key});

  @override
  State<ProductCustomOption> createState() => _ProductCustomOptionState();
}

class _ProductCustomOptionState extends State<ProductCustomOption> {
  final cartController = Get.find<CartController>();
  late int? product_index;

  @override
  void initState() {
    if (widget.have_index != null) {
      product_index = widget.have_index;
    } else {
      product_index =
          cartController.get_product_cart_index(widget.productData!.id);
    }
    super.initState();
  }

  void product_custom() {
    setState(() {
      cartController.my_order = cartController.my_order;
    });
  }

  double left_padding = 10;
  double right_padding = 25;
  @override
  Widget build(BuildContext context) {
    List selected_answer = List.generate(
      cartController.custom_option.length,
      (i) => '',
    );
    return Container(
      // height: 200,
      padding: EdgeInsets.only(left: left_padding, right: right_padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartController.custom_option.length,
            itemBuilder: (BuildContext c, int i) {
              if (product_index != null) {
                if (!cartController
                    .my_order[product_index!]['custom_option'].isEmpty) {
                  for (var item in cartController.my_order[product_index!]
                      ['custom_option']) {
                    if (item['custom_option_id'] ==
                        cartController.custom_option[i].custom_option_id) {
                      for (var element
                          in cartController.custom_option[i].answers) {
                        if (element['id'] == item['custom_option_item_id']) {
                          selected_answer[i] = element;
                        }
                      }
                    }
                  }
                }
              }
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter answerState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        cartController.custom_option[i].custom_option_name,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 5),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 4,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            cartController.custom_option[i].answers.length,
                        itemBuilder: (context, index) {
                          var answer =
                              cartController.custom_option[i].answers[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${answer['item_name']} (${answer['price']})"),
                              Radio(
                                value: answer,
                                groupValue: selected_answer[i],
                                splashRadius:
                                    20, // Change the splash radius when clicked
                                onChanged: (value) {
                                  print(product_index);
                                  answerState(() {
                                    print(value);
                                    selected_answer[i] = value;
                                    cartController.customOption(
                                      cartController.my_order[product_index!],
                                      selected_answer[i],
                                      cartController
                                          .custom_option[i].custom_option_name,
                                      selected_answer[i]['custom_option_id'],
                                      context,
                                    );
                                    product_custom();
                                    print(cartController.my_order);
                                  });
                                },
                              ),
                            ],
                          );
                          // return ListTile(
                        },
                      ),
                    )
                  ],
                );
              });
            },
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
