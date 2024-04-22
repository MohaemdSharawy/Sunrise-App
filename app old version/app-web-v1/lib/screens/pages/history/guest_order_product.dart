import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/history_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/utilites/header_screen.dart';

class GuestOrderProduct extends StatefulWidget {
  var order;
  GuestOrderProduct({this.order, super.key});

  @override
  State<GuestOrderProduct> createState() => _GuestOrderProductState();
}

class _GuestOrderProductState extends State<GuestOrderProduct> {
  final historyController = Get.put(HistoryController());
  final hotelController = Get.put(HotelsController());
  TextStyle text_style = TextStyle(color: Colors.white, fontSize: 25);

  _getData() async {
    await historyController.getOrderProducts(order_id: widget.order.id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyController.orderProductLoaded.value = false;
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return product();
  }

  Widget product() {
    return Obx(
      () {
        return (historyController.orderProductLoaded.value == true)
            ? Container(
                // height: historyController.orderingProductHistory.length * 140,
                height: MediaQuery.of(context).size.height,

                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            // shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                historyController.orderingProductHistory.length,
                            itemBuilder: (context, index) {
                              // getProduct(index);

                              return Container(
                                color: Colors.transparent.withOpacity(
                                  0.2,
                                ),
                                height: 160,
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          (historyController
                                                      .orderingProductHistory[
                                                          index]
                                                      .logo !=
                                                  '')
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, bottom: 20),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0),
                                                    child: Image.network(
                                                      'https://yourcart.sunrise-resorts.com/assets/uploads/products/${historyController.orderingProductHistory[index].logo}',
                                                      height: 110,
                                                      width: 110,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20,
                                                          bottom: 20,
                                                          top: 10),
                                                      child: Image.asset(
                                                        "assets/images/no_image.png",
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                historyController
                                                    .orderingProductHistory[
                                                        index]
                                                    .product_name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Sans-bold'),
                                              ),
                                              Text(
                                                historyController
                                                    .orderingProductHistory[
                                                        index]
                                                    .notes,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Sans-bold'),
                                              ),
                                              Text(
                                                'Quantity : ${historyController.orderingProductHistory[index].qty}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Sans-bold'),
                                              ),
                                              // (widget.restaurant.booking == "1")
                                              Text(
                                                'Price : ${historyController.orderingProductHistory[index].price}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Sans-bold'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget product1() {
    return Obx(
      () {
        return (historyController.orderProductLoaded.value == true)
            ? (historyController.orderingProductHistory.length > 0)
                ? AnimationLimiter(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(
                      //     parent: AlwaysScrollableScrollPhysics()),
                      itemCount:
                          historyController.orderingProductHistory.length,
                      itemBuilder: (BuildContext c, int i) {
                        return AnimationConfiguration.staggeredList(
                          position: i,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            horizontalOffset: 30,
                            verticalOffset: 300.0,
                            child: FlipAnimation(
                                duration: Duration(milliseconds: 3000),
                                curve: Curves.fastLinearToSlowEaseIn,
                                flipAxis: FlipAxis.y,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            child: Image.network(
                                              'https://yourcart.sunrise-resorts.com/assets/uploads/products/${historyController.orderingProductHistory[i].logo}',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            '${historyController.orderingProductHistory[i].product_name}',
                                            style: text_style,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '*Quantity : ${historyController.orderingProductHistory[i].qty}',
                                            style: text_style,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          if (historyController
                                                  .orderingProductHistory[i]
                                                  .notes !=
                                              '') ...[
                                            Text(
                                              '*Notes : ${historyController.orderingProductHistory[i].notes}',
                                              style: text_style,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ]
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'There Is No order In This Room',
                      style: text_style,
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
