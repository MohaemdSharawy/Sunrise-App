import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tucana/controller/workingDaysController.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';

class BookingScreen extends StatefulWidget {
  // var hotel;
  // var restaurant;
  var restaurant_code;
  // BookingScreen({this.hotel, this.restaurant, this.restaurant_code, super.key});
  BookingScreen({this.restaurant_code, super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with BaseController {
  final workingDayController = Get.put(WorkingDayController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool working = true;
  List restaurant_day_off = [];
  var initialDate;

  void getDaysOff() {
    print(workingDayController.workingDay);
    for (int i = 0; i < workingDayController.workingDay.length; i++) {
      if (workingDayController.workingDay[i].work != "1") {
        restaurant_day_off.add(workingDayController.workingDay[i].day_number);
      }
    }
    restaurantNotWork();
    setInitialDate();
  }

  void restaurantNotWork() {
    if (restaurant_day_off.length == 7) {
      working = false;
    }
  }

  String dropdownvalue = '';

  List<String> weeks_name = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  void setInitialDate() {
    // String today = DateTime.now().weekday.toString();
    String today = DateTime.now().weekday.toString();

    if (restaurant_day_off.contains(today)) {
      for (int i = 1; i <= 7; i++) {
        if (!restaurant_day_off.contains(
            DateTime.now().add(Duration(days: i)).weekday.toString())) {
          initialDate = DateTime.now().add(Duration(days: i));
          break;
        }
      }
    } else {
      initialDate = DateTime.now();
    }
  }

  void clearData() {
    PostData.date.text = '';
    PostData.time.text = '';
    PostData.roomNun.text = '';
    PostData.pax.text = '';
  }

  _getWorkingDays() async {
    await workingDayController.getRestaurantByCode(
        restaurant_Code: widget.restaurant_code);

    getDaysOff();
  }

  _getData() async {
    var initialDate = new DateTime.now().add(Duration(days: 1));

    var day_name = DateFormat('EEEE').format(initialDate);
    // var dateParse = DateTime.parse(date);
    PostData.date.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: 1)))
        .toString();
    await workingDayController.getRestaurantByCode(
      restaurant_Code: widget.restaurant_code,
      day_name: day_name,
      date: PostData.date.text,
    );

    dropdownvalue = workingDayController.workingDay.first.from_time.toString();
    PostData.time.text = dropdownvalue;
  }

  @override
  void initState() {
    workingDayController.isLoaded.value = false;
    _getData();
    // _getWorkingDays();
    PostData.pax.text = GetStorage().read('pax');
    PostData.roomNun.text = GetStorage().read('room_num');
    // print(workingDayController.workingDay);
    super.initState();
  }

  Future<Null> selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: (GetStorage().read('departure') != null &&
              GetStorage().read('departure') != '')
          ? DateTime.parse(GetStorage().read('departure'))
          : DateTime(2030),
      // lastDate: DateTime(2030),
      // initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) =>
          restaurant_day_off.contains(val.weekday.toString()) ? false : true,
    );
    if (_datePicker != null) {
      print(_datePicker); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePicker);

      String day_name = DateFormat('EEEE').format(_datePicker);

      // await workingDayController.get_shifts_by_day(
      //   day_name: day_name,
      //   date: formattedDate,
      // );

      print(workingDayController.workingDay);

      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        PostData.date.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (workingDayController.isLoaded.value == true)
            ? mainCompu()
            : LoadingScreen(img_name: 'booking.jpg');
        // return LoadingScreen(img_name: 'booking.jpg');
      }),
    );
  }

  Widget mainCompu() {
    return (working == true)
        ? Stack(
            children: [
              Image.asset(Img.get('booking.jpg'),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.7)),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 750,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // AppBarWidget(),
                          // restaurant_info(),
                          Container(
                            padding: EdgeInsets.all(25),
                            child: Column(children: [
                              buildHeader(),
                              // Container(height: 150),
                              TextFormField(
                                readOnly: true,
                                controller: PostData.roomNun,
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
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                              Container(height: 20),
                              TextFormField(
                                controller: PostData.pax,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Pax is required';
                                  }
                                },
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: tr("Pax"),
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                              Container(height: 20),
                              TextFormField(
                                controller: PostData.date,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date is required';
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: tr("Date"),
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  setState(() {
                                    selectDate(context);
                                  });
                                },
                              ),
                              // Container(height: 20),
                              // TextFormField(
                              //   controller: PostData.time,
                              //   readOnly: true,
                              //   keyboardType: TextInputType.text,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Time is required';
                              //     }
                              //   },
                              //   style: TextStyle(color: Colors.white),
                              //   decoration: InputDecoration(
                              //     labelText: tr("Time"),
                              //     labelStyle: TextStyle(color: Colors.white),
                              //     enabledBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.white, width: 1),
                              //     ),
                              //     focusedBorder: UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.white, width: 2),
                              //     ),
                              //   ),
                              //   onTap: () async {
                              //     TimeOfDay? pickedDate = await showTimePicker(
                              //         context: context,
                              //         initialTime: TimeOfDay.now());

                              //     if (pickedDate != null) {
                              //       String _hour = pickedDate.hour.toString();
                              //       String _minute =
                              //           pickedDate.minute.toString();
                              //       String _time = _hour + ':' + _minute;
                              //       print(_time);

                              //       setState(() {
                              //         PostData.time.text =
                              //             _time; //set output date to TextField value.
                              //       });
                              //     } else {
                              //       print("Date is not selected");
                              //     }
                              //   },
                              // ),
                              SizedBox(
                                height: 35,
                              ),
                              Obx(() {
                                return Container(
                                  width: 750,
                                  child: DropdownButton(
                                    dropdownColor: Colors.black,
                                    value: dropdownvalue,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: TextStyle(color: Colors.white),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    items: workingDayController.workingDay
                                        .map((element) => DropdownMenuItem(
                                              child: Text(
                                                element.from_time +
                                                    ' -- ' +
                                                    element.to_time +
                                                    ' (' +
                                                    element.availability
                                                        .toString() +
                                                    ')',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              value: element.from_time,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      PostData.time.text = value.toString();

                                      setState(() {
                                        dropdownvalue = value.toString();
                                      });
                                    },
                                  ),
                                );
                              }),

                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
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
                                      // print(int.parse(widget.restaurant.id));
                                      if (_formKey.currentState!.validate()) {
                                        // await workingDayController
                                        //     .bookRestaurant(
                                        //   restaurant_id: int.parse(
                                        //       workingDayController
                                        //           .restaurant[0].id),
                                        //   hotel_id: int.parse(
                                        //       workingDayController
                                        //           .restaurant[0].hid),
                                        //   room_no: PostData.roomNun.text,
                                        //   pax: int.parse(PostData.pax.text),
                                        //   date: PostData.date.text,
                                        //   time: PostData.time.text,
                                        // );
                                        // clearData();

                                      }
                                    },
                                  ),
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Image.asset(Img.get('booking.jpg'),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
              Center(
                child: Card(
                  child: Text(
                    'Sorry This Restaurant Not Available',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.7)),
              // Container(
              //     height: kToolbarHeight,
              //     child: AppBar(
              //         backgroundColor: Colors.transparent,
              //         systemOverlayStyle: SystemUiOverlayStyle(
              //             statusBarBrightness: Brightness.dark),
              //         elevation: 0,
              //         actions: <Widget>[
              //           IconButton(
              //             icon: Icon(Icons.search),
              //             onPressed: () {},
              //           ),
              //         ]))
            ],
          );
  }

  Widget buildHeader() {
    return Container(
      // padding: EdgeInsets.only(top: 10),
      // margin: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          restaurant_info(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (workingDayController.restaurant[0].white_logo != '')
                  ? Image.network(
                      'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${workingDayController.restaurant[0].white_logo}',
                      width: 150,
                      height: 100,
                    )
                  : Image.network(
                      'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${workingDayController.restaurant[0].white_logo}',
                      width: 150,
                      height: 100,
                    ),
              SizedBox(
                width: 16,
                height: 20,
              ),
              Text(
                workingDayController.restaurant[0].restaurant_name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget restaurant_info() {
    return Container(
      padding: EdgeInsets.only(top: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/Book your Restaurant.png',
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            'Book Your Restaurant ',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PostData {
  static TextEditingController date = TextEditingController();
  static TextEditingController time = TextEditingController();
  static TextEditingController roomNun = TextEditingController();
  static TextEditingController pax = TextEditingController();
}
