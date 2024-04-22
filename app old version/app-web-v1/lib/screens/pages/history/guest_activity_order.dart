import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/history_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';

class GuestActivityOrder extends StatefulWidget {
  const GuestActivityOrder({super.key});

  @override
  State<GuestActivityOrder> createState() => _GuestActivityOrderState();
}

class _GuestActivityOrderState extends State<GuestActivityOrder> {
  TextStyle text_style = TextStyle(color: Colors.white, fontSize: 25);
  final historyController = Get.put(HistoryController());
  final hotelsController = Get.find<HotelsController>();
  @override
  _getData() async {
    await historyController.getActivityHistory(h_id: GetStorage().read('h_id'));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyController.activityHistoryLoaded.value = false;
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String getDate(date) {
      DateTime n_date = DateTime.parse(date);
      String month = DateFormat.MMM().format(n_date).toString();
      String day = DateFormat.d().format(n_date).toString();
      return day + ' ' + month;
    }

    return Obx(() {
      return (historyController.activityHistoryLoaded.value == true)
          ? (historyController.activityHistory.length > 0)
              ? SizedBox(
                  height: 200.0 * historyController.activityHistory.length,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(
                      //     parent: AlwaysScrollableScrollPhysics()),
                      itemCount: historyController.activityHistory.length,
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
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  '${historyController.activityHistory[i].restaurant_name}',
                                                  style: text_style,
                                                ),
                                              ),
                                              Text(
                                                '${historyController.activityHistory[i].product_name}',
                                                style: text_style,
                                              ),
                                              Text(
                                                'Date : ${getDate(historyController.activityHistory[i].date)}',
                                                style: text_style,
                                              ),
                                              Text(
                                                'Time: ${historyController.activityHistory[i].time}',
                                                style: text_style,
                                              ),
                                              Text(
                                                'Pax: ${historyController.activityHistory[i].pax}',
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
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'There Is No Wellness In This Room',
                    style: text_style,
                  ),
                )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
