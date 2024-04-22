import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tucana/controller/card_controller.dart';
import 'package:tucana/controller/product_controller.dart';

class CategoryList extends StatefulWidget {
  var categories;
  var restaurant;
  var active_alert;
  CategoryList({
    this.categories,
    this.restaurant,
    this.active_alert = true,
    super.key,
  });

  @override
  State<CategoryList> createState() => _CategoryList();
}

class _CategoryList extends State<CategoryList> {
  int selectedTile = -1;

  final cardController = Get.put(CardController());
  final productController = Get.put(ProductController());

  getProduct(category_id) async {
    productController.categoryScreenHight.value =
        widget.categories.length * 85.0;
    productController.isLoaded.value = false;
    var response =
        await productController.getProduct(category_id: int.parse(category_id));

    productController.categoryScreenHight.value =
        (widget.categories.length * 80.0) +
            (productController.product.length * 200.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key(selectedTile.toString()),
      // physics: NeverScrollableScrollPhysics(),
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Card(
            color: Colors.grey.withOpacity(0.5),
            child: ExpansionTile(
              initiallyExpanded: index == selectedTile,
              onExpansionChanged: (newState) async {
                if (newState)
                  setState(() {
                    selectedTile = index;
                    getProduct(widget.categories[index].id);
                  });
                else
                  setState(() {
                    productController.categoryScreenHight.value =
                        widget.categories.length * 85.0;
                    selectedTile = -1;
                  });
              },
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.categories[index].category_name,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Sans-bold',
                      color: Colors.white),
                ),
              ),
              children: [
                buildProductList()
                // Obx(() {
                //   return (productController.isLoaded.value == true)
                //       ? SizedBox(
                //           height: 200.0 * productController.product.length,
                //           child: buildProducts())
                //       : Center(child: CircularProgressIndicator());
                // })

                // FutureBuilder<List<String>>(
                //     future: getProduct(categories[index].id),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //       if (snapshot.hasError) {
                //         return Center(child: Text('Error: ${snapshot.error}'));
                //       }
                //       if (!snapshot.hasData) {
                //         return Center(child: Text('No data'));
                //       }
                //       final data = snapshot.data!;
                //       return buildProducts();
                //       // return ListView.builder(
                //       //   shrinkWrap: true,
                //       //   itemCount: productController.product.length,
                //       //   itemBuilder: (context, e) {
                //       //     // return Text(data[e].to);
                //       //     // return buildProduct(snapshot.data![e]);

                //       //     // return Text(productController.product[e].product_name);
                //       //   },
                //       // );
                //     })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductList() {
    return Obx(
      () {
        return (productController.isLoaded.value == true)
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productController.product.length,
                itemBuilder: (context, index) {
                  // getProduct(index);

                  return Container(
                    padding: EdgeInsets.only(bottom: 15),
                    color: Colors.transparent.withOpacity(
                      0.2,
                    ),
                    // height: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/dinning-product-details/${productController.product[index].id}');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              (productController.product[index].logo != '')
                                  ? Stack(
                                      children: [
                                        (productController
                                                    .product[index].logo !=
                                                '')
                                            ? Container(
                                                width: 120,
                                                margin: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  child: Image.network(
                                                    'https://yourcart.sunrise-resorts.com/assets/uploads/products/${productController.product[index].logo}',
                                                    height: 110,
                                                    width: 110,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 120,
                                                margin: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: Image.asset(
                                                  'assets/no-image-icon-4.png',
                                                  height: 150,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        Positioned(
                                          right: 0,
                                          top: 5,
                                          // right: 10,
                                          child: Column(
                                            children: [
                                              (productController
                                                          .product[index].hot ==
                                                      "1")
                                                  ? Container(
                                                      color: Colors.red,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .local_fire_department_rounded),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              (productController.product[index]
                                                          .vegan ==
                                                      "1")
                                                  ? Container(
                                                      color: Colors.green,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .grass_outlined),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20, bottom: 20, top: 10),
                                          child: Image.asset(
                                            "assets/no-image-icon-4.png",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        productController
                                            .product[index].product_name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Sans-bold'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                          productController
                                              .product[index].description,
                                          maxLines: 6,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    (productController.product[index].allinc ==
                                            "1")
                                        ? Card(
                                            shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              color: Color.fromARGB(
                                                  255, 190, 146, 109),
                                              child: Text(
                                                'All Inclusive',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                         (productController.product[index].extra_charge ==
                                            "1")
                                        ? Card(
                                            shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              color: Color.fromARGB(
                                                  255, 190, 146, 109),
                                              child: Text(
                                                'Extra Charge',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  productController
                                                      .product[index]
                                                      .allergies
                                                      .length;
                                              i++)
                                            Tooltip(
                                              message: productController
                                                      .product[index]
                                                      .allergies[i]
                                                  ['allergies_name'],
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                                child: Image.network(
                                                  'https://yourcart.sunrise-resorts.com/assets/uploads/allergies/${productController.product[index].allergies[i]['allergies_logo']}',
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          // ClipRRect(
                                          //   borderRadius:
                                          //       BorderRadius.circular(60.0),
                                          //   child: Image.network(
                                          //     'https://yourcart.sunrise-resorts.com/assets/uploads/allergies/${productController.product[index].allergies[i]['allergies_logo']}',
                                          //     height: 30,
                                          //     width: 30,
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (productController
                                                .restaurant[0].hide_price !=
                                            "1") ...[
                                          Text(
                                            '${productController.restaurant[0].currency}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Sans-bold'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${productController.product[index].price}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Sans-bold'),
                                          ),
                                        ],
                                        SizedBox(
                                          width: 35,
                                        ),
                                        // (GetStorage().read('room_num') != '')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    (productController.restaurant[0].booking ==
                                                "1" &&
                                            widget.active_alert)
                                        ? SizedBox(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white
                                                      .withOpacity(0.6),
                                                  elevation: 0),
                                              child: Text('Add to Cart').tr(),
                                              onPressed: () {
                                                // if(product[index].logo != ''){

                                                // }
                                                cardController.addTOCard(
                                                    productController
                                                        .product[index],
                                                    productController
                                                        .restaurant[0]);
                                                Get.snackbar(
                                                  'Message',
                                                  // '${error}',
                                                  'Order Add To Cart Successfully',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white,
                                                );
                                              },
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
