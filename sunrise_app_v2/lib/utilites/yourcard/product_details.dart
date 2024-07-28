import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/yourcard/card_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/category_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_model.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';
import 'package:sunrise_app_v2/utilites/general/view_basket_btn.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cart_notes.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cart_qty_btn.dart';
import 'package:sunrise_app_v2/utilites/yourcard/cutom_option_radio.dart';

class ProductDetails extends StatefulWidget {
  Product product;
  ProductDetails({required this.product, super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final categoryController = Get.find<CategoryController>();
  final cartController = Get.put(CartController());

  double left_padding = 10;
  double right_padding = 25;
  var product_cart_index;
  int qty = 0;

  _getData() async {
    await cartController.product_custom(product_id: widget.product.id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print('current QTY ${cartController.current_product_qty.value}');
      // cartController.custom_loaded.value = false;

      product_cart_index =
          cartController.get_product_cart_index(widget.product.id);
      if (product_cart_index != null) {
        setState(() {
          qty = cartController.my_order[product_cart_index]['qty'];
        });
        cartController.current_product_qty.value = qty;
      } else {
        cartController.current_product_qty.value = 0;
      }
      _getData();

      // cartController.current_product_qty.value = 0;
    });
    super.initState();
  }

  void increment() {
    if (qty == 0) {
      cartController.addTOCard(
        widget.product,
        categoryController.restaurant.value,
      );
      product_cart_index =
          cartController.get_product_cart_index(widget.product.id);
    } else {
      cartController.increment(index: product_cart_index);
    }
    setState(() {
      qty = cartController.my_order[product_cart_index]['qty'];
      cartController.current_product_qty.value = qty;
    });
  }

  void decrement() {
    // cartController.clearItem();
    late int new_qty;
    if (qty == 1) {
      cartController.deleteItem(index: product_cart_index);
      new_qty = 0;
    } else {
      cartController.decrement(index: product_cart_index);
      new_qty = cartController.my_order[product_cart_index]['qty'];
    }
    setState(() {
      qty = new_qty;
      cartController.current_product_qty.value = qty;
    });
  }

  void product_custom() {
    setState(() {
      cartController.my_order = cartController.my_order;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
              ),
            ),
            pinned: true, // Add this line
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text(
              //   widget.product.product_name,
              //   style: AppFont.smallBoldBlack,
              // ),

              background: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: (widget.product.logo != '')
                    ? Image.network(
                        '${AppUrl.restaurant_domain}assets/uploads/products/${widget.product.logo}',
                        fit: BoxFit.fill,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.asset(
                        'assets/no_image.png',
                        fit: BoxFit.fill,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
            backgroundColor: AppColor.backgroundColor,
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: left_padding),
                      child: Text(
                        widget.product.product_name,
                        style: AppFont.boldBlack,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: left_padding, right: right_padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              '${categoryController.restaurant.value.currency}  ${widget.product.price}',
                              style: AppFont.smallBlack,
                            ),
                          ),
                          CartQtyBtn(
                            productData: widget.product,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: left_padding,
                          right: right_padding,
                          top: right_padding),
                      child: Text(
                        widget.product.description,
                        style: AppFont.tinyBlack,
                      ),
                    ),
                    allergies(),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => (cartController.current_product_qty.value > 0)
                          ? (cartController.custom_loaded.value)
                              ? ProductCustomOption(
                                  productData: widget.product,
                                )
                              : Center(
                                  child: Row(
                                    children: [
                                      Text('Loading Custom Option'),
                                      WidgetDotFade(
                                        color: AppColor.primary,
                                      ),
                                    ],
                                  ),
                                )
                          : Container(),
                    ),
                    Obx(
                      () => (cartController.current_product_qty.value > 0)
                          ? Column(
                              children: [
                                CartNotes(
                                  productData: widget.product,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                )
                              ],
                            )
                          : Container(),
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Stack(
    //           children: [
    //             // ImageCustom(
    //             //   image:
    //             //       '${AppUrl.restaurant_domain}assets/uploads/products/${widget.product.logo}',
    //             //   height: 200,
    //             //   width: MediaQuery.of(context).size.width,
    //             //   fit: BoxFit.fill,
    //             // ),
    //             ClipRRect(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(50),
    //                   topRight: Radius.circular(50)),
    //               child: Image.network(
    //                 '${AppUrl.restaurant_domain}assets/uploads/products/${widget.product.logo}',
    //                 fit: BoxFit.fill,
    //                 height: 200,
    //                 width: MediaQuery.of(context).size.width,
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () => Navigator.pop(context),
    //               icon: Icon(Icons.close),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           padding: EdgeInsets.only(left: left_padding),
    //           child: Text(
    //             widget.product.product_name,
    //             style: AppFont.boldBlack,
    //           ),
    //         ),
    //         Container(
    //           padding:
    //               EdgeInsets.only(left: left_padding, right: right_padding),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                 child: Text(
    //                   '${categoryController.restaurant.value.currency}  ${widget.product.price}',
    //                   style: AppFont.smallBlack,
    //                 ),
    //               ),
    //               qty_btn(),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           padding: EdgeInsets.only(
    //               left: left_padding, right: right_padding, top: right_padding),
    //           child: Text(
    //             widget.product.description,
    //             style: AppFont.tinyBlack,
    //           ),
    //         ),
    //         allergies(),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Obx(
    //           () => (cartController.current_product_qty.value > 0 &&
    //                   product_cart_index != null)
    //               ? (cartController.custom_loaded.value)
    //                   ? custom_option()
    //                   : Center(
    //                       child: WidgetDotFade(
    //                         color: AppColor.primary,
    //                       ),
    //                     )
    //               : Container(),
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(
    //                 left: left_padding,
    //                 right: right_padding,
    //               ),
    //               child: Text(
    //                 'Notes',
    //                 style: AppFont.smallBoldBlack,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Container(
    //               height: 50,
    //               padding: EdgeInsets.only(
    //                 left: left_padding,
    //                 right: right_padding,
    //               ),
    //               margin: EdgeInsets.only(bottom: 90),
    //               child: CustomTextInput(hintText: 'Notes', icon: Icons.note),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  // Widget qty_btn() {
  //   return Container(
  //     height: 40,
  //     width: 100,
  //     // width: MediaQuery.of(context).size.width / ,
  //     padding: EdgeInsets.all(3),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       color: AppColor.primary,
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         InkWell(
  //             onTap: () => decrement(),
  //             child: Icon(
  //               Icons.remove,
  //               color: Colors.white,
  //               size: 30,
  //             )),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 3),
  //           padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(3), color: Colors.white),
  //           child: Text(
  //             qty.toString(),
  //             style: TextStyle(color: AppColor.second, fontSize: 16),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             increment();
  //           },
  //           child: Icon(
  //             Icons.add,
  //             color: Colors.white,
  //             size: 30,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget allergies() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Wrap(
        children: [
          for (int i = 0; i < widget.product.allergies.length; i++)
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Tooltip(
                message: widget.product.allergies[i]['allergies_name'],
                triggerMode: TooltipTriggerMode.tap,
                textStyle: TextStyle(fontSize: 15, color: Colors.black),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.network(
                        '${AppUrl.restaurant_domain}/assets/uploads/allergies/${widget.product.allergies[i]['allergies_logo']}',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Text(widget.product.allergies[i]['allergies_name'])
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget custom_option() {
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
          // Text(
          //   'Custom Option',
          //   style: AppFont.smallBoldBlack,
          // ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartController.custom_option.length,
            itemBuilder: (BuildContext c, int i) {
              // if (!cartController
              //     .my_order[product_cart_index]['custom_option'].isEmpty) {
              //   for (var item in cartController.my_order[product_cart_index]
              //       ['custom_option']) {
              //     if (item['custom_option_id'] ==
              //         cartController.custom_option[i].custom_option_id) {
              //       for (var element
              //           in cartController.custom_option[i].answers) {
              //         if (element['id'] == item['custom_option_item_id']) {
              //           selected_answer[i] = element;
              //         }
              //       }
              //     }
              //   }
              // }
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
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    if (selected_answer[i] != value) {
                                      print('change TO ----------');
                                      print(selected_answer[i]);
                                    } else {
                                      print('Same ------------');
                                      print(selected_answer[i]);
                                      print(value);
                                    }
                                    answerState(() {
                                      selected_answer[i] = value;
                                      cartController.customOption(
                                        cartController
                                            .my_order[product_cart_index],
                                        selected_answer[i],
                                        cartController.custom_option[i]
                                            .custom_option_name,
                                        selected_answer[i]['custom_option_id'],
                                        context,
                                      );
                                      product_custom();
                                    });
                                  },
                                ),
                              ],
                            );
                            // return ListTile(
                            //   title: Text(
                            //       "${answer['item_name']} (${answer['price']}  ${categoryController.restaurant.value.currency})"),
                            //   leading: Radio(
                            //     value: answer,
                            //     groupValue: selected_answer[i],
                            //     splashRadius:
                            //         20, // Change the splash radius when clicked
                            //     onChanged: (value) {
                            //       answerState(() {
                            //         selected_answer[i] = value;
                            //         cartController.customOption(
                            //           cartController
                            //               .my_order[product_cart_index],
                            //           selected_answer[i],
                            //           cartController.custom_option[i]
                            //               .custom_option_name,
                            //           selected_answer[i]
                            //               ['custom_option_id'],
                            //           context,
                            //         );
                            //         product_custom();
                            //       });
                            //     },
                            //   ),
                            // );
                          }),
                    )
                    // for (var answer
                    //     in cartController.custom_option[i].answers)
                    //   ListTile(
                    //     title: Text(
                    //         "${answer['item_name']} (${answer['price']})"),
                    //     leading: Radio(
                    //       value: answer,
                    //       groupValue: selected_answer[i],
                    //       splashRadius:
                    //           20, // Change the splash radius when clicked
                    //       onChanged: (value) {
                    //         answerState(() {
                    //           selected_answer[i] = value;
                    //           cartController.customOption(
                    //             cartController
                    //                 .my_order[product_cart_index],
                    //             selected_answer[i],
                    //             cartController
                    //                 .custom_option[i].custom_option_name,
                    //             selected_answer[i]['custom_option_id'],
                    //             context,
                    //           );
                    //           product_custom();
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 40),
                    //   child: Row(
                    //     mainAxisAlignment:
                    //         MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //           "${answer['item_name']} (${answer['price']})"),
                    //       Radio(
                    //         value: answer,
                    //         groupValue: selected_answer[i],
                    //         splashRadius:
                    //             20, // Change the splash radius when clicked
                    //         onChanged: (value) {
                    //           answerState(() {
                    //             selected_answer[i] = value;
                    //             cartController.customOption(
                    //               cartController
                    //                   .my_order[product_cart_index],
                    //               selected_answer[i],
                    //               cartController.custom_option[i]
                    //                   .custom_option_name,
                    //               selected_answer[i]
                    //                   ['custom_option_id'],
                    //               context,
                    //             );
                    //             product_custom();
                    //           });
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
  // Widget custom_option() {
  //   return Container(
  //     height: 300,
  //     child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: 3,
  //         shrinkWrap: true,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Text('s');
  //         }),
  //   );
  // }

  // Widget custom_option1() {
  //   List selected_answer = List.generate(
  //     cartController.custom_option.length,
  //     (i) => '',
  //   );
  //   int selectedOption = 0;

  //   return Container(
  //     // height: 200,
  //     padding: EdgeInsets.only(left: left_padding, right: right_padding),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Custom Option',
  //           style: AppFont.smallBoldBlack,
  //         ),
  //         (cartController.custom_option.isNotEmpty)
  //             ? ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 itemCount: cartController.custom_option.length,
  //                 itemBuilder: (BuildContext c, int i) {
  //                   if (!cartController
  //                       .my_order[product_cart_index]['custom_option']
  //                       .isEmpty) {
  //                     for (var item in cartController
  //                         .my_order[product_cart_index]['custom_option']) {
  //                       if (item['custom_option_id'] ==
  //                           cartController.custom_option[i].custom_option_id) {
  //                         for (var element
  //                             in cartController.custom_option[i].answers) {
  //                           if (element['id'] ==
  //                               item['custom_option_item_id']) {
  //                             selected_answer[i] = element;
  //                           }
  //                         }
  //                       }
  //                     }
  //                   }
  //                   return StatefulBuilder(builder:
  //                       (BuildContext context, StateSetter dropdownState) {
  //                     return Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.all(8),
  //                           child: Text(
  //                             cartController
  //                                 .custom_option[i].custom_option_name,
  //                             style:
  //                                 TextStyle(color: Colors.black, fontSize: 15),
  //                           ),
  //                         ),
  //                         // ! Start DropBtn
  //                         // DropdownButton(
  //                         //   items: cartController.custom_option[i].answers
  //                         //       .map((answer) {
  //                         //     return DropdownMenuItem(
  //                         //       value: answer,
  //                         //       child: Text(
  //                         //           '${answer["item_name"]} (${answer["price"]})'),
  //                         //     );
  //                         //   }).toList(),
  //                         //   onChanged: (newValue) {
  //                         //     dropdownState(
  //                         //       () {
  //                         //         selected_answer[i] = newValue;
  //                         //         // print(selected_answer[i]);
  //                         //         print(selected_answer[i]);
  //                         //         cartController.customOption(
  //                         //           cartController.my_order[product_cart_index],
  //                         //           selected_answer[i],
  //                         //           cartController
  //                         //               .custom_option[i].custom_option_name,
  //                         //           selected_answer[i]['custom_option_id'],
  //                         //           context,
  //                         //         );
  //                         //         product_custom();
  //                         //         print(cartController
  //                         //                 .my_order[product_cart_index]
  //                         //             ['custom_option']);
  //                         //       },
  //                         //     );
  //                         //   },
  //                         // )
  //                         // ! End DropBtn
  //                         // ! Start Radio
  //                         // for (var answer
  //                         //     in cartController.custom_option[i].answers)
  //                         //   ListTile(
  //                         //     title: Text(
  //                         //         "${answer['item_name']} ${answer['price']}"),
  //                         //     leading: Radio(
  //                         //       value: int.parse(answer['id']),
  //                         //       groupValue: selected_answer[i],
  //                         //       splashRadius:
  //                         //           20, // Change the splash radius when clicked
  //                         //       onChanged: (value) {
  //                         //         // setState(() {
  //                         //         //   selectedOption = value!;
  //                         //         // });
  //                         //       },
  //                         //     ),
  //                         //   ),
  //                         // ! End Radio
  //                         SizedBox(
  //                           height: 50,
  //                           child: Radio<int>(
  //                             value: 0,
  //                             groupValue: selectedOption,
  //                             splashRadius:
  //                                 20, // Change the splash radius when clicked
  //                             onChanged: (value) {
  //                               print(value);
  //                               setState(() {
  //                                 selectedOption = value!;
  //                               });
  //                             },
  //                           ),
  //                           // child: ListTile(
  //                           //   title: Text('All'),
  //                           //   leading: Radio<int>(
  //                           //     value: 0,
  //                           //     groupValue: selectedOption,
  //                           //     splashRadius:
  //                           //         20, // Change the splash radius when clicked
  //                           //     onChanged: (value) {
  //                           //       print(value);
  //                           //       setState(() {
  //                           //         selectedOption = value!;
  //                           //       });
  //                           //     },
  //                           //   ),
  //                           // ),
  //                         ),

  //                         // DropdownButton(
  //                         //   value: selected_answer[i],
  //                         //   items: cartController.custom_option[i].answers
  //                         //       .map((answer) {
  //                         //     return DropdownMenuItem(
  //                         //       value: answer,
  //                         //       child: Text(
  //                         //           '${answer["item_name"]} (${answer["price"]})'),
  //                         //     );
  //                         //   }).toList(),
  //                         //   onChanged: (newValue) {
  //                         //     dropdownState(
  //                         //       () {
  //                         //         selected_answer[i] = newValue;

  //                         //         print(selected_answer[i]);
  //                         //         cartController.customOption(
  //                         //           widget.product,
  //                         //           selected_answer[i],
  //                         //           cartController
  //                         //               .custom_option[i].custom_option_name,
  //                         //           selected_answer[i]['custom_option_id'],
  //                         //           context,
  //                         //         );
  //                         //         product_custom();
  //                         //         // print(product['custom_option']);
  //                         //       },
  //                         //     );
  //                         //     // cardController.saveCardData();
  //                         //   },
  //                         // )
  //                       ],
  //                     );
  //                   });
  //                 },
  //               )
  //             : Center(
  //                 child: Text(
  //                   'There Is No Custom Option For This Product',
  //                   style: TextStyle(fontSize: 25),
  //                 ),
  //               ),
  //         SizedBox(height: 5.0),
  //       ],
  //     ),
  //   );
  // }
}
