import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/spa_category_controller.dart';
import 'package:tucana/screens/pages/wellness/spa_booking_screen.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';

import '../../../utilites/loading.dart';

class SpaProductDetails extends StatefulWidget {
  var hotel;
  var actvity;
  var category;
  var product;
  var product_id;
  SpaProductDetails({
    this.hotel,
    this.actvity,
    this.category,
    this.product,
    this.product_id,
    super.key,
  });

  @override
  State<SpaProductDetails> createState() => _SpaProductDetailsState();
}

class _SpaProductDetailsState extends State<SpaProductDetails> {
  final spaController = Get.put(SpaController());
  final hotelController = Get.put(HotelsController());

  _getData() async {
    spaController.singleActivityProductLoaded.value = false;
    await hotelController.getBackGround(
      search_key: widget.product_id,
      api_type: 'product_id',
    );
    await spaController.getSingleProduct(product_id: widget.product_id);
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
        return (spaController.singleActivityProductLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].wellness_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(top: 100),
            // margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                HeaderScreen(
                  h_id: spaController.activity[0].hid,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Spa.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      spaController.spaSingleProduct[0].product_name,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                (spaController.spaSingleProduct[0].logo != '')
                    ? SizedBox(
                        width: 400,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20.0), //add border radius

                          // margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/products/${spaController.spaSingleProduct[0].logo}',
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
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${spaController.activity[0].logo}',
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
                  'Price :  ${spaController.spaSingleProduct[0].price} ${spaController.activity[0].currency}',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),
                (GetStorage().read('room_num') != '' &&
                        spaController.activity[0].booking == "1")
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0.6),
                            elevation: 0),
                        child: Text(
                          "Book Now",
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/book-activity/${widget.product_id}');
                          // Get.to(BookingSpaScreen(
                          //   spa: widget.product,
                          //   hotel: widget.hotel,
                          //   actvity: widget.actvity,
                          // ));
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    width: 750,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        spaController.spaSingleProduct[0].description,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        //
        // HeaderScreen()
      ],
    );
  }
}
