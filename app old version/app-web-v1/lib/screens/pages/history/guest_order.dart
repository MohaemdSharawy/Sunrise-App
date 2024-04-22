import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/history_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/pages/history/guest_order_product.dart';

class GuestOrder extends StatefulWidget {
  GuestOrder({super.key});

  @override
  State<GuestOrder> createState() => _GuestOrderState();
}

class _GuestOrderState extends State<GuestOrder> {
  TextStyle text_style = TextStyle(color: Colors.white, fontSize: 25);
  final historyController = Get.put(HistoryController());
  final hotelController = Get.put(HotelsController());

  _getData() async {
    await historyController.getOrderHistory(
      h_id: GetStorage().read('h_id'),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyController.orderingHistoryLoaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return order();
  }

  int selectedTile = -1;
  Widget order() {
    String getDate(date) {
      DateTime n_date = DateTime.parse(date);
      String month = DateFormat.MMM().format(n_date).toString();
      String day = DateFormat.d().format(n_date).toString();
      return day + month;
    }

    String getTime(date) {
      String time = DateFormat('hh:mm').format(DateTime.parse(date)).toString();
      return time;
    }

    return Obx(() {
      return (historyController.orderingHistoryLoaded.value == true)
          ? (historyController.orderingHistory.length > 0)
              ? SingleChildScrollView(
                  child: ListView.builder(
                    key: Key(selectedTile.toString()),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyController.orderingHistory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, left: 10, right: 10, top: 5),
                        child: Container(
                          // height: 50,
                          color: Colors.grey.withOpacity(.35),

                          child: ExpansionTile(
                            // key: Key(index.toString()),
                            initiallyExpanded: index == selectedTile,
                            onExpansionChanged: (newState) async {
                              if (newState)
                                setState(() {
                                  historyController.orderProductLoaded.value =
                                      false;
                                  historyController.getOrderProducts(
                                      order_id: historyController
                                          .orderingHistory[index].id);

                                  // productController.isLoaded.value = false;
                                  // productController.getProduct(
                                  //     category_id:
                                  //         int.parse(categories[index].id),
                                  //     language: GetStorage().read('lang'));
                                  selectedTile = index;
                                });
                              else
                                setState(() {
                                  selectedTile = -1;
                                });
                            },
                            // backgroundColor: Colors.transparent.withOpacity(.05),

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${historyController.orderingHistory[index].restaurant_name}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Sans-bold',
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${getDate(historyController.orderingHistory[index].timestamp)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Sans-bold',
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${getTime(historyController.orderingHistory[index].timestamp)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Sans-bold',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            iconColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.platform,
                            children: [
                              buildProductList(
                                  historyController.orderingProductHistory)
                            ],
                          ),
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
    });
  }

  Widget buildProductList(product) {
    return Obx(
      () {
        return (historyController.orderProductLoaded.value == true)
            ? Stack(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      // getProduct(index);

                      return Container(
                        color: Colors.transparent.withOpacity(
                          0.2,
                        ),
                        // height: 180,
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  (product[index].logo != '')
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 20, bottom: 20),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60.0),
                                            child: Image.network(
                                              'https://yourcart.sunrise-resorts.com/assets/uploads/products/${product[index].logo}',
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
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
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            product[index].product_name,
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
                                          child: Text(product[index].notes,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                              overflow: TextOverflow.fade),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),

                                            Text(
                                              'Quantity : ${product[index].qty}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Sans-bold'),
                                            ),
                                            SizedBox(
                                              width: 35,
                                            ),
                                            Text(
                                              'Price : ${product[index].price}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Sans-bold'),
                                            ),
                                            // (GetStorage().read('room_num') != '')
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // (widget.restaurant.booking == "1")
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
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget orders1() {
    return Obx(() {
      return (historyController.orderingHistoryLoaded.value == true)
          ? (historyController.orderingHistory.length > 0)
              ? SizedBox(
                  height: 200.0 * historyController.orderingHistory.length,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(
                      //     parent: AlwaysScrollableScrollPhysics()),
                      itemCount: historyController.orderingHistory.length,
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
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(GuestOrderProduct(
                                        order: historyController
                                            .orderingHistory[i],
                                      ));
                                    },
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '*Room :${historyController.orderingHistory[i].room_no}',
                                                  style: text_style,
                                                ),
                                                Text(
                                                  '*${historyController.orderingHistory[i].restaurant_name}',
                                                  style: text_style,
                                                ),
                                                Text(
                                                  '* At ${historyController.orderingHistory[i].timestamp}',
                                                  style: text_style,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
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
    });
  }
}
