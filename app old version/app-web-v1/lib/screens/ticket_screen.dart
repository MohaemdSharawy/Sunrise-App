import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/ticket_controller.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TicketScreen extends StatefulWidget {
  var h_id;

  TicketScreen({this.h_id, super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with BaseController {
  final hotelController = Get.put(HotelsController());
  final ticketController = Get.put(TicketController());

  _getData() async {
    ticketController.services_loaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
    await ticketController.getDepartmentService();
    await ticketController.getServices();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  String? selected_service;
  String selected_department = "All";

  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (ticketController.department_service_loaded.value == true)
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
                    departmentService(),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      width: 750,
                      height: 83.0 * ticketController.services.length,
                      child: serviceItem(),
                    ),
                    SizedBox(
                      height: 3,
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

  Widget serviceItem() {
    // double _w = MediaQuery.of(context).size.width;

    return Obx(() {
      return (ticketController.services_loaded.value == true)
          ? AnimationLimiter(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(20),
                // physics: BouncingScrollPhysics(
                //     parent: AlwaysScrollableScrollPhysics()),
                itemCount: ticketController.services.length,
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
                        child: (ticketController.services[i].id !=
                                selected_service)
                            ? InkWell(
                                onTap: (() {
                                  setState(() {
                                    selected_service =
                                        ticketController.services[i].id;
                                  });
                                }),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            ticketController
                                                .services[i].service_name,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : selectedService(ticketController.services[i]),
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
    });
  }

  Widget departmentService() {
    List serviceType = ['All', 'Rooms', 'Bathroom'];
    Color? card_color_background;
    Color? card_color;
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: serviceType.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              if (selected_department == 'All') {
                card_color_background = Colors.white;
                card_color = Colors.black;
              } else {
                card_color_background = Colors.transparent;
                card_color = Colors.white;
              }
            } else {
              if (selected_department ==
                  ticketController
                      .department_service[index - 1].department_name) {
                card_color_background = Colors.white;
                card_color = Colors.black;
              } else {
                card_color_background = Colors.transparent;
                card_color = Colors.white;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(left: 9.0, right: 8),
              child: InkWell(
                onTap: (() {
                  ticketController.services_loaded.value = false;
                  if (index == 0) {
                    setState(() {
                      selected_department = 'All';
                    });
                    ticketController.getServices();
                  } else {
                    selected_department = ticketController
                        .department_service[index - 1].department_name;
                    print(serviceType[index]);
                    ticketController.getServices(
                        department_id: serviceType[index]);
                  }
                }),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Card(
                    elevation: 0,
                    color: card_color_background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          serviceType[index],
                          style: TextStyle(fontSize: 25, color: card_color),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget selectedService(service) {
    return InkWell(
      onTap: (() {
        setState(() {
          selected_service = '';
        });
      }),
      child: Column(
        children: [
          Container(
            width: 750,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(service.service_name,
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          actions(),
        ],
      ),
    );
  }

  Widget actions() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: PostData.note,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: tr("Notes"),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white.withOpacity(0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: (() async {
                if (selected_service != null && selected_service != '') {
                  showLoading();
                  ticketController.makeRequest(
                      hid: widget.h_id,
                      service_id: selected_service,
                      description: PostData.note.text);
                  hideLoading();
                } else {
                  Get.snackbar(
                    'Message',
                    'Please Select Service First',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class PostData {
  static TextEditingController note = TextEditingController();
}
