import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/category_screen.dart';
import 'package:tucana/controller/card_controller.dart';
import 'package:tucana/controller/product_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilites/appbar.dart';
import '../utilites/loading.dart';

class ProductScreen extends StatefulWidget {
  var hotel;
  var restaurant;
  var category;
  var h_id;
  var restaurant_id;
  var category_id;
  ProductScreen({
    this.hotel,
    this.restaurant,
    this.category,
    this.h_id,
    this.category_id,
    this.restaurant_id,
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Get.put(ProductController());
  final cardController = Get.put(CardController());
  final hotelController = Get.put(HotelsController());

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.category_id,
      api_type: 'category_id',
    );
    productController.isLoaded.value = false;
    await productController.getProduct(category_id: widget.category_id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (productController.isLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                AppBarWidget(
                  h_id: widget.h_id,
                ),
                // AppBarWidget(
                //     notback: true,
                //     screen: CategoriesScreen(
                //       hotel: widget.hotel,
                //       restaurant: widget.restaurant,
                //     )),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: SizedBox(
                    width: 750,
                    child: headerCard(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 750,
                    height: 200.0 * productController.product.length,
                    child: buildProducts(productController.product),
                  ),
                ),
              ],
            ),
          ),
        ),
        // restaurantItem(),
      ],
    );
  }

  Widget headerCard() {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 50, right: 50),
      width: double.infinity,
      child: Card(
        color: Colors.grey.withOpacity(0.5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            productController.category[0].category_name,
            style: TextStyle(
                fontSize: 15, fontFamily: 'Sans-bold', color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildProducts(product) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {
            Navigator.pushNamed(
                context, '/dinning-product-details/${product[index].id}');
          }),
          child: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    (product[index].logo != '')
                        ? Container(
                            margin: EdgeInsets.only(left: 20, bottom: 20),
                            child: Image.network(
                              'https://yourcart.sunrise-resorts.com/assets/uploads/products/${product[index].logo}',
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
                            product[index].product_name,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Sans-bold'),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(product[index].description,
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
                            Text(
                              '${productController.restaurant[0].currency} ${product[index].price}',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Sans-bold'),
                            ),
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
                                      child: Text('Add to Card'),
                                      onPressed: () {
                                        // if(product[index].logo != ''){

                                        // }
                                        cardController.addTOCard(
                                          product[index],
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
