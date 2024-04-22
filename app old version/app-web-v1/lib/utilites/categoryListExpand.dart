import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/card_controller.dart';
import 'package:tucana/controller/product_controller.dart';
import 'package:tucana/model/product_model.dart';
import 'package:tucana/services/api.dart';
import 'package:tucana/utilites/loading.dart';
import 'package:tucana/utilites/my_toast.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class CategoryListExpandAdapter {
  // List? items = <People>[];
  // List itemsTile = <ItemTile>[];

  // CategoryListExpandAdapter(this.items) {
  //   for (var i = 0; i < items!.length; i++) {
  //     itemsTile.add(ItemTile(index: i));
  //   }
  // }

  List itemsTile = <ItemTile>[];

  var item;

  CategoryListExpandAdapter(this.item) {
    // print(this.item);
    // print(this.item);
    // print(this.item.length);
    for (var i = 0; i < this.item.length; i++) {
      itemsTile.add(ItemTile(index: i, object: this.item));
    }
  }
  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  var object;
  var index;
  final productController = Get.put(ProductController());
  final cardController = Get.put(CardController());

  ItemTile({
    Key? key,
    required this.index,
    required this.object,
  }) : super(key: key);

  Future<List<String>> getProduct() async {
    // var response =
    //     await Api.getProduct(category_id: int.parse(object[index].id));

    // return response.data['products'];
    print(object[index].id);
    final response = await http.get(Uri.parse(
        'https://yourcart.sunrise-resorts.com/clients/api/get_category_products/${object[index].id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
      // return data.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            key: PageStorageKey<int>(index),
            onExpansionChanged: (bool open) async {
              if (open) {
                await getProduct();
              }
            },
            title: Card(
              color: Colors.grey.withOpacity(0.5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  // allWordsCapitilize(
                  object[index].category_name!,
                  // ),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Sans-bold',
                      color: Colors.white),
                ),
              ),
            ),
            children: [
              // buildProducts()

              FutureBuilder<dynamic>(
                  future: getProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('No data'));
                    }
                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                          data[index].toString(),
                          style: TextStyle(color: Colors.white),
                        ));
                      },
                    );
                    // print(productController.product.length);
                    // return Text(productController.product[0].product_name);
                  })
            ]),
        Divider(height: 0)
      ],
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    MyToast.show(action + " clicked", context);
  }

  Widget buildProducts() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: productController.product.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {
            Navigator.pushNamed(context,
                '/dinning-product-details/${productController.product[index].id}');
          }),
          child: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    (productController.product[index].logo != '')
                        ? Container(
                            margin: EdgeInsets.only(left: 20, bottom: 20),
                            child: Image.network(
                              'https://yourcart.sunrise-resorts.com/assets/uploads/products/${productController.product[index].logo}',
                              height: 150,
                              width: 120,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 20, bottom: 20),
                            child: Image.network(
                              'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${productController.restaurant[0].white_logo}',
                              height: 150,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            productController.product[index].product_name,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Sans-bold'),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                              productController.product[index].description,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                              overflow: TextOverflow.fade),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (productController.restaurant[0].hide_price !=
                                "1") ...[
                              Text(
                                '${productController.restaurant[0].currency} ${productController.product[index].price}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sans-bold'),
                              ),
                            ],
                            SizedBox(
                              width: 35,
                            ),
                            (GetStorage().read('room_num') != '')
                                ? SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Colors.white.withOpacity(0.6),
                                          elevation: 0),
                                      child: Text('Add to Card').tr(),
                                      onPressed: () {
                                        // if(product[index].logo != ''){

                                        // }
                                        cardController.addTOCard(
                                          productController.product[index],
                                          productController.restaurant[0],
                                        );
                                        Get.snackbar(
                                          'Message',
                                          // '${error}',
                                          'Order Add To Card Successfully',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                        );
                                      },
                                    ),
                                  )
                                : Container()
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
