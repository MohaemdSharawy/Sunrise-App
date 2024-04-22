import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/ticket_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tucana/utilites/news_slider.dart';

class TicketHistory extends StatefulWidget {
  var h_id;

  TicketHistory({this.h_id, super.key});

  @override
  State<TicketHistory> createState() => _TicketHistoryState();
}

class _TicketHistoryState extends State<TicketHistory> {
  final hotelController = Get.put(HotelsController());
  final ticketController = Get.put(TicketController());

  @override
  _getData() async {
    ticketController.tickets_loaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await ticketController.myPreviousRequest(hid: widget.h_id);
  }

  void initState() {
    _getData();
    super.initState();
  }

  TextStyle main_text_style = TextStyle(fontSize: 25, color: Colors.white);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (ticketController.tickets_loaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].weather_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 750,
              child: Container(
                child: Column(
                  children: [
                    HeaderScreen(
                      h_id: widget.h_id,
                    ),
                    // AppBarWidget(),
                    SizedBox(height: 20),
                    // NewsSliderWidget(),
                    SizedBox(height: 20),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 200.0 * ticketController.tickets.length,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(20),
                          // physics: BouncingScrollPhysics(
                          //     parent: AlwaysScrollableScrollPhysics()),
                          itemCount: ticketController.tickets.length,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '*${ticketController.tickets[i].department_name}',
                                                    style: main_text_style,
                                                  ),
                                                  Text(
                                                    '*${ticketController.tickets[i].service_name}',
                                                    style: main_text_style,
                                                  ),
                                                  Text(
                                                    '*${ticketController.tickets[i].status}',
                                                    style: main_text_style,
                                                  ),
                                                  if (ticketController
                                                          .tickets[i]
                                                          .status_id !=
                                                      4) ...[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    if (ticketController
                                                            .tickets[i]
                                                            .status_id ==
                                                        3) ...[
                                                      confirm(
                                                          ticket_id:
                                                              ticketController
                                                                  .tickets[i]
                                                                  .id),
                                                      SizedBox(height: 8),
                                                      reopen(
                                                          ticket_id:
                                                              ticketController
                                                                  .tickets[i]
                                                                  .id)
                                                    ],
                                                    // if (ticketController
                                                    //         .tickets[i]
                                                    //         .status_id ==
                                                    //     3) ...[
                                                    //   reopen(
                                                    //       ticket_id:
                                                    //           ticketController
                                                    //               .tickets[i]
                                                    //               .id)
                                                    // ]
                                                  ]
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // restaurantItem(),
      ],
    );
  }

  Widget confirm({required int ticket_id}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.10),
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      onPressed: (() {
        areYouSure(action: 'confirm', ticket_id: ticket_id);
      }),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirm',
              style: main_text_style,
            ),
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget reopen({required int ticket_id}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.10),
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      onPressed: (() {
        areYouSure(action: 'reopen', ticket_id: ticket_id);
      }),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reopen',
              style: main_text_style,
            ),
            Icon(
              Icons.replay_circle_filled_sharp,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget cancel() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.10),
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      onPressed: (() {
        // areYouSure();
      }),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cancel',
              style: main_text_style,
            ),
            Icon(
              Icons.cancel,
              color: Colors.white,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Future areYouSure({required String action, required int ticket_id}) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      customHeader: Icon(
        Icons.airplay_sharp,
        size: 50,
      ),
      dialogBackgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Text('Are You Sure!!'),
      ),
      btnOkOnPress: () {
        ticketController.changeTicketStatus(
          action: action,
          ticket_id: ticket_id,
        );
      },
      btnCancelOnPress: () {},
    ).show();
  }
}
