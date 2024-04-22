import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/spa_category_controller.dart';
import 'package:tucana/screens/pages/wellness/spa_procut_details_screend.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class SpaProductScreen extends StatefulWidget {
  var hotel;
  var actvity;
  var category;
  var category_id;
  SpaProductScreen({
    this.category_id,
    this.hotel,
    this.actvity,
    this.category,
    super.key,
  });

  @override
  State<SpaProductScreen> createState() => _SpaProductScreenState();
}

class _SpaProductScreenState extends State<SpaProductScreen>
    with BaseController {
  final spaController = Get.put(SpaController());
  final hotelController = Get.put(HotelsController());
  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.category_id,
      api_type: 'category_id',
    );
    spaController.spaProductLoaded.value = false;
    await spaController.getSpaProduct(
        category_id: int.parse(widget.category_id));
    // print(spaController.spaProduct);
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
      npsQuestion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (spaController.spaProductLoaded.value == true)
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
            height: MediaQuery.of(context).size.height,

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
                      'Products',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 450,
                      child: spaProducts(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //
        // HeaderScreen()
      ],
    );
  }

  Widget spaProducts() {
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      itemCount: spaController.spaProduct.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              productImage(spaController.spaProduct[index]),
              Expanded(child: productDetails(spaController.spaProduct[index]))
            ],
          ),
        );
      },
    );
  }

  Widget productImage(product) {
    return (product.logo != '')
        ? Container(
            // margin: EdgeInsets.only(left: 20, bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: Image.network(
                'https://yourcart.sunrise-resorts.com/assets/uploads/products/${product.logo}',
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: Image.network(
                'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${spaController.activity[0].logo}',
                height: 150,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          );
  }

  Widget productDetails(product) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            '${product.product_name}',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, top: 3),
          child: Text(
            '${product.description}',
            // maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Price ${product.price} ${spaController.activity[0].currency}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white.withOpacity(0.6), elevation: 0),
              child: Text(
                "More",
              ),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/activity-product-details/${product.id}');
                // Get.to(SpaProductDetails(
                //   hotel: widget.hotel,
                //   product: product,
                //   actvity: widget.actvity,
                //   category: widget.category,
                // ));
              },
            ),
          ],
        )
      ],
    );
  }

  ///////////////////////// Old Design ///////////////
  // Widget spaProducts(spa) {
  //   return ListView.builder(
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: spa.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       // return product(spa, index);
  //       return Container(
  //         height: 180,
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               // crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 (spaController.spaProduct[index].logo != '')
  //                     ? ClipRRect(
  //                         borderRadius: BorderRadius.circular(8.0),

  //                         // margin: EdgeInsets.only(left: 20, bottom: 20),
  //                         child: Image.network(
  //                           'https://yourcart.sunrise-resorts.com/assets/uploads/products/${spa[index].logo}',
  //                           height: 160,
  //                           width: 120,
  //                           fit: BoxFit.fill,
  //                         ),
  //                       )
  //                     : Container(
  //                         // margin: EdgeInsets.only(left: 20, bottom: 20),
  //                         // child: Image.network(
  //                         //   'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${widget.actvity.logo}',
  //                         //   height: 120,
  //                         //   width: 100,
  //                         //   fit: BoxFit.fill,
  //                         // ),
  //                         ),
  //                 Container(
  //                   // margin: EdgeInsets.only(top: 28, left: 10),
  //                   child: Column(
  //                     children: [
  //                       Text(
  //                         spa[index].product_name,
  //                         style: TextStyle(color: Colors.white, fontSize: 17),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 8),
  //                         child: SizedBox(
  //                           width: 200,
  //                           height: 110,
  //                           child: Text(spa[index].description,
  //                               style: TextStyle(
  //                                   color: Colors.white, fontSize: 12),
  //                               overflow: TextOverflow.clip),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text(
  //                             'Price ${spa[index].price} ${spaController.activity[0].currency}',
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             width: 8,
  //                           ),
  //                           ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                                 primary: Colors.white.withOpacity(0.6),
  //                                 elevation: 0),
  //                             child: Text(
  //                               "More",
  //                             ),
  //                             onPressed: () {
  //                               // Get.to(SpaProductDetails(
  //                               //   hotel: widget.hotel,
  //                               //   product: spa[index],
  //                               //   actvity: widget.actvity,
  //                               //   category: widget.category,
  //                               // ));
  //                               Navigator.pushNamed(context,
  //                                   '/activity-product-details/${spa[index].id}');
  //                             },
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget product(spa, index) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: Colors.white,
  //       ),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: InkWell(
  //       onTap: () {},
  //       child: Card(
  //         elevation: 0,
  //         color: Colors.transparent,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             (spaController.spaProduct[index].logo != '')
  //                 ? Container(
  //                     // margin: EdgeInsets.only(left: 20, bottom: 20),
  //                     child: Image.network(
  //                       'https://yourcart.sunrise-resorts.com/assets/uploads/products/${spa[index].logo}',
  //                       height: 150,
  //                       width: 400,
  //                       fit: BoxFit.fill,
  //                     ),
  //                   )
  //                 : Container(
  //                     margin: EdgeInsets.only(left: 20, bottom: 20),
  //                     child: Image.network(
  //                       'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${widget.actvity.logo}',
  //                       height: 150,
  //                       width: 100,
  //                       fit: BoxFit.fill,
  //                     ),
  //                   ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(spa[index].product_name,
  //                 style: TextStyle(fontSize: 17, color: Colors.white)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
