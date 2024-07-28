import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/workingDaysController.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class BookingScreenNew extends StatefulWidget {
  var res_code;
  BookingScreenNew({this.res_code, super.key});

  @override
  State<BookingScreenNew> createState() => _BookingScreenNewState();
}

class _BookingScreenNewState extends State<BookingScreenNew> {
  final workingController = Get.put(WorkingDayController());
  final restaurantController = Get.put(RestaurantController());
  final hotelsController = Get.put(HotelsController());
  final TextEditingController pax = TextEditingController();
  final TextEditingController room_num = TextEditingController();
  final TextEditingController notes = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getData();
    // print(countSundays(
    //   DateTime.parse("2023-11-01"),
    //   DateTime.parse("2023-12-01"),
    // ));
    super.initState();
  }

  List open_days = [];
  List days = [];
  int selected_index = 0;
  int selected_time = 0;
  var selected_event;
  int selected_meal = 0;
  late String from;
  var dropdown;
  List selected_allergies = [];

  var selected_formated_day;
  var selected_day_name;
  var selected_meal_id;

  _getData() async {
    pax.text = GetStorage().read('pax').toString();
    room_num.text = GetStorage().read('room_num').toString();
    await workingController.get_booking_types();
    await workingController.get_allergies();
    // for(var event in workingController.booking_type){

    // }

    await restaurantController.restaurantByCode(
        restaurant_code: widget.res_code);

    await workingController.get_booking_meals(
        h_id: restaurantController.single_restaurant.value.id);

    if (workingController.booking_meals.isNotEmpty) {
      setState(() {
        selected_meal_id = workingController.booking_meals[0].meal_id;
        selected_meal = 0;
      });
    }

    await workingController.getWorkingDays(
      restaurant_id: int.parse(restaurantController.single_restaurant.value.id),
    );
    for (var element in workingController.workingDay) {
      if (!open_days.contains(element.day)) {
        // print(element.day);
        open_days.add(element.day.toLowerCase());
      }
    }
    print('check');
    print(restaurantController.single_restaurant.value.book_today);
    if (restaurantController.single_restaurant.value.book_today == "1") {
      from = DateTime.now().toString().split(' ')[0];
    } else {
      from = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
    }
    print(from);
    getDates(
      from,
      // '2023-12-01',
      GetStorage().read('departure'),
      open_days,
    );

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(days[selected_index]));

    String day_name =
        DateFormat('EEEE').format(DateTime.parse(days[selected_index]));

    setState(() {
      selected_day_name = day_name;
      selected_formated_day = formattedDate;
    });

    await workingController.get_shifts_by_day(
        restaurant_id: restaurantController.single_restaurant.value.id,
        day_name: day_name,
        date: formattedDate,
        meal_id: selected_meal_id);

    print(workingController.workingDay);
  }

  void getDates(String fromDate, String toDate, List openDays) {
    var from = DateTime.parse(fromDate);
    var to = DateTime.parse(toDate);
    var list = <String>[];

    for (int i = 0; i <= to.difference(from).inDays; i++) {
      var date = from.add(Duration(days: i));
      var weekday = DateFormat('EEEE').format(date).toLowerCase();

      if (openDays.contains(weekday)) {
        list.add(DateFormat('yyyy-MM-dd').format(date));
      }
    }

    days = list;
  }

  // int countSundays(DateTime startDate, DateTime endDate) {
  //   int count = 0;
  //   for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
  //     if (startDate.add(Duration(days: i)).weekday == DateTime.sunday) {
  //       count++;
  //     }
  //   }
  //   return count;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (workingController.isLoaded.value == true)
            ? mainComp()
            : LoadingScreen(img_name: 'booking.jpg');
      }),
    );
  }

  Widget mainComp() {
    return Stack(
      children: [
        Image.asset(
          Img.get('booking.jpg'),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 750,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderScreen(),
                    // Center(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(60.0),
                    //     child: Image.network(
                    //       'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.single_restaurant.value.image}',
                    //       height: 110,
                    //       width: 110,
                    //       fit: BoxFit.fill,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 25.0),
                    Center(
                      child: Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.single_restaurant.value.white_logo}',
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        tr('Date'),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    buildTabs(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        tr('Meal'),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    build_meal_taps(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        tr('Time'),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    buildTimeTabs(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        tr('Event'),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    buildEventTabs(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        tr('Allergies'),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildAllergiesTabs(),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: pax,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pax is required';
                          }
                        },
                        onChanged: (value) {
                          if (int.parse(value) < 1) {
                            pax.text = "1";
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: tr("Pax"),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: room_num,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room Number is required';
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: tr("Room Number"),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: notes,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: tr("Notes"),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(0.6),
                              elevation: 0),
                          child: Text(
                            "Confirm",
                          ),
                          onPressed: () async {
                            print('Select Date ${days[selected_index]}');
                            print(
                                'Select Time ${workingController.workingDay[selected_time].from_time}');
                            // print(int.parse(widget.restaurant.id));
                            // if (_formKey.currentState!.validate()) {

                            // showLoading();

                            await workingController.bookRestaurant(
                              restaurant_id: int.parse(restaurantController
                                  .single_restaurant.value.id),
                              hotel_id: int.parse(restaurantController
                                  .single_restaurant.value.hid),
                              room_no: room_num.text,
                              pax: int.parse(pax.text),
                              date: days[selected_index],
                              time: workingController
                                  .workingDay[selected_time].from_time,
                              type_id: (selected_event == null)
                                  ? '0'
                                  : workingController
                                      .booking_type[selected_event].id,
                              notes: notes.text,
                              allergies: selected_allergies,
                            );
                            // clearData();
                            // hideLoading();
                            // Get.snackbar(
                            //   'Message',
                            //   'Booking Restaurant Done Successfully',
                            //   snackPosition: SnackPosition.BOTTOM,
                            //   backgroundColor: Colors.green,
                            //   colorText: Colors.white,
                            // );
                            // }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabs() {
    int count = (days.length < 7) ? days.length : 7;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(width: 10),
          for (int i = 0; i < count; i++) buildTabContent(i),
          // Container(width: 10),
        ],
      ),
    );
  }

  Widget buildTimeTabs() {
    return Obx(
      () => (workingController.time_loaded.value)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(width: 10),
                  for (int i = 0; i < workingController.workingDay.length; i++)
                    if (workingController.workingDay[i].work == "1") ...[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: (i == selected_time)
                                  ? Color.fromRGBO(187, 173, 144, 1)
                                  : Colors.grey,
                              elevation: 1),
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Availability: ${workingController.workingDay[i].availability}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      'From : ${workingController.workingDay[i].from_time}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      'To: ${workingController.workingDay[i].to_time}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ],
                              )),
                          onPressed: () {
                            setState(() {
                              selected_time = i;
                            });
                          },
                        ),
                      ) // Container(width: 10),
                    ]
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildEventTabs() {
    return Obx(
      () => (workingController.time_loaded.value)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(width: 10),
                for (int i = 0; i < workingController.booking_type.length; i++)
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: (i == selected_event)
                              ? Color.fromRGBO(187, 173, 144, 1)
                              : Colors.grey,
                          elevation: 1),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${workingController.booking_type[i].type_name}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                      onPressed: () {
                        if (selected_event == i) {
                          setState(() {
                            selected_event = null;
                          });
                        } else {
                          setState(() {
                            selected_event = i;
                          });
                        }
                      },
                    ),
                  ) // Container(width: 10),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildAllergiesTabs() {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          Container(width: 10),
          for (int i = 0; i < workingController.allergies.length; i++)
            Container(
              margin: EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: (selected_allergies
                            .contains(workingController.allergies[i].id))
                        ? Color.fromRGBO(187, 173, 144, 1)
                        : Colors.grey,
                    elevation: 1),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/allergies/${workingController.allergies[i].logo}',
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('${workingController.allergies[i].allergies_name}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    )),
                onPressed: () {
                  if (selected_allergies
                      .contains(workingController.allergies[i].id)) {
                    setState(() {
                      selected_allergies
                          .remove(workingController.allergies[i].id);
                    });
                  } else {
                    setState(() {
                      selected_allergies.add(workingController.allergies[i].id);
                    });
                  }
                  print(selected_allergies);
                },
              ),
            ) // Container(width: 10),
        ]),
      ),
    );
  }

  Widget buildTabContent(index) {
    DateTime date = DateTime.parse(days[index]);
    String weekday =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();

    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: (index == selected_index)
                ? Color.fromRGBO(187, 173, 144, 1)
                : Colors.grey,
            elevation: 1),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(weekday,
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                SizedBox(
                  height: 2,
                ),
                Text(days[index],
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            )),
        onPressed: () async {
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(DateTime.parse(days[index]));

          String day_name =
              DateFormat('EEEE').format(DateTime.parse(days[index]));

          setState(() async {
            selected_index = index;
            selected_formated_day = formattedDate;
            selected_day_name = day_name;
            selected_meal = 0;
          });

          await workingController.get_shifts_by_day(
              restaurant_id: restaurantController.single_restaurant.value.id,
              day_name: day_name,
              date: formattedDate,
              meal_id: selected_meal_id);
        },
      ),
    );
  }

  Widget build_meal_taps() {
    return Obx(
      () => (workingController.meals_loaded.value)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(width: 10),
                for (int i = 0; i < workingController.booking_meals.length; i++)
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: (i == selected_meal)
                              ? Color.fromRGBO(187, 173, 144, 1)
                              : Colors.grey,
                          elevation: 1),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${workingController.booking_meals[i].main_category_name}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                      onPressed: () async {
                        setState(() {
                          selected_meal = i;
                          selected_meal_id = workingController
                              .booking_meals[i].main_category_name;
                        });

                        await workingController.get_shifts_by_day(
                          restaurant_id:
                              restaurantController.single_restaurant.value.id,
                          day_name: selected_day_name,
                          date: selected_formated_day,
                          meal_id: workingController.booking_meals[i].meal_id,
                        );
                      },
                    ),
                  ) // Container(width: 10),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 50.0);
    path.quadraticBezierTo(
        size.width - 70.0, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(size.width / 3.0, size.height - 32, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(10, size.height / 2 + 20, 5, size.height / 2);
    path.quadraticBezierTo(0, size.height / 3, 10, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
