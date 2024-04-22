import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/product_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/img.dart';

import '../../../utilites/header_screen.dart';
import '../../../utilites/loading.dart';

class DiningProductDetails extends StatefulWidget {
  var product_id;
  DiningProductDetails({this.product_id, super.key});

  @override
  State<DiningProductDetails> createState() => _DiningProductDetailsState();
}

class _DiningProductDetailsState extends State<DiningProductDetails> {
  final productController = Get.put(ProductController());
  final hotelController = Get.put(HotelsController());

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.product_id,
      api_type: 'product_id',
    );
    productController.singleProductLoaded.value = false;
    await productController.getSingleProduct(product_id: widget.product_id);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (productController.singleProductLoaded.value == true)
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
            padding: EdgeInsets.only(top: 100),
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Dining.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      productController.single_product[0].product_name,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                (productController.single_product[0].logo != '')
                    ? SizedBox(
                        width: 400,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20.0), //add border radius

                          // margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/products/${productController.single_product[0].logo}',
                            height: 200,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          // margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${productController.restaurant[0].logo}',
                            height: 120,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Price :  ${productController.single_product[0].price} ${productController.restaurant[0].currency}',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 15,
                ),
                // (GetStorage().read('room_num') != '')
                //     ? ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             primary: Colors.white.withOpacity(0.6),
                //             elevation: 0),
                //         child: Text(
                //           "Book Now",
                //         ),
                //         onPressed: () {
                //           // Get.to(BookingSpaScreen(
                //           //   spa: widget.product,
                //           //   hotel: widget.hotel,
                //           //   actvity: widget.actvity,
                //           // ));
                //         },
                //       )
                //     : Container(),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    productController.single_product[0].description,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 15),
                    child: Wrap(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0;
                            i <
                                productController
                                    .single_product[0].allergies.length;
                            i++)
                          Tooltip(
                            message: productController.single_product[0]
                                .allergies[i]['allergies_name'],
                            triggerMode: TooltipTriggerMode.tap,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.white),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: Image.network(
                                'https://yourcart.sunrise-resorts.com/assets/uploads/allergies/${productController.single_product[0].allergies[i]['allergies_logo']}',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //
        HeaderScreen()
      ],
    );
  }
}
