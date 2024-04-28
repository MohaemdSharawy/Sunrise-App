import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/const/app_constant.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/interface_controller.dart';
import 'package:tucana/controller/outside_auth_controller.dart';
import 'package:tucana/controller/pms_controller.dart';
import 'package:tucana/screens/home_screen.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/language_widget.dart';
import 'package:tucana/utilites/loading.dart';
import 'package:tucana/utilites/mycolors.dart';
import 'package:tucana/utilites/other_resorts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as htmls;

class LoginScreen extends StatefulWidget {
  var hotel;
  final h_id;
  LoginScreen({this.hotel, this.h_id, super.key});

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with BaseController, TickerProviderStateMixin {
  final interfaceController = Get.put(InterfaceController());
  final hotelController = Get.put(HotelsController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _roomNumberController = TextEditingController();
  final _birthdayController = TextEditingController();
  final pmsController = Get.put(PmsController());
  final outSideController = Get.put(OutSideAuthController());
  String? selectedMenu;

  TextStyle menuStyle = TextStyle(color: Colors.white);

  bool menuShown = false;
  double appbarHeight = 80.0;
  double menuHeight = 0.0;
  late Animation<double> openAnimation, closeAnimation;
  late AnimationController openController, closeController;

  Map<String, List> group_hotels_resorts = {};
  Map<String, List> group_hotels_cruises = {};
  List<String> group_hotels_resorts_keys = [];
  List<String> group_hotels_cruises_keys = [];

  @override
  _getData() async {
    await hotelController.getHotel(hid: widget.h_id);
    await hotelController.guestHotel();
    await filterByGroup();
    group_hotels_resorts_keys = group_hotels_resorts.keys.toList();
    group_hotels_cruises_keys = group_hotels_cruises.keys.toList();
    await hotelController.getBackGround(
      search_key: widget.h_id,
      screen_type: 'login_screen',
    );
    await interfaceController.bookingInterface(hotel_id: widget.h_id);
  }

  filterByGroup() {
    for (var i = 0; i < hotelController.hotels.length; i++) {
      if (hotelController.hotels[i].company_id != "2") {
        if (!group_hotels_resorts
            .containsKey(hotelController.hotels[i].hotel_group)) {
          group_hotels_resorts[hotelController.hotels[i].hotel_group] = [
            {
              "index": i,
              "id": hotelController.hotels[i].id,
              "name": hotelController.hotels[i].hotel_name,
              "logo": hotelController.hotels[i].logo,
              "logo_white": hotelController.hotels[i].logo_white,
              'image': hotelController.hotels[i].image
            }
          ];
        } else {
          group_hotels_resorts[hotelController.hotels[i].hotel_group]?.add({
            "index": i,
            "id": hotelController.hotels[i].id,
            "name": hotelController.hotels[i].hotel_name,
            "logo": hotelController.hotels[i].logo,
            "logo_white": hotelController.hotels[i].logo_white,
            'image': hotelController.hotels[i].image
          });
        }
      } else {
        if (!group_hotels_cruises
            .containsKey(hotelController.hotels[i].hotel_group)) {
          group_hotels_cruises[hotelController.hotels[i].hotel_group] = [
            {
              "index": i,
              "id": hotelController.hotels[i].id,
              "name": hotelController.hotels[i].hotel_name,
              "logo": hotelController.hotels[i].logo,
              "logo_white": hotelController.hotels[i].logo_white,
              'image': hotelController.hotels[i].image
            }
          ];
        } else {
          group_hotels_cruises[hotelController.hotels[i].hotel_group]?.add({
            "index": i,
            "id": hotelController.hotels[i].id,
            "name": hotelController.hotels[i].hotel_name,
            "logo": hotelController.hotels[i].logo,
            "logo_white": hotelController.hotels[i].logo_white,
            'image': hotelController.hotels[i].image
          });
        }
      }
    }

    // return group_hotels;
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      interfaceController.isbookingLoaded.value = false;
      // if (GetStorage().read('room_num') != '') {
      //   Navigator.pushNamed(context, '/home/${widget.h_id}');
      // }
      openController = AnimationController(
          duration: const Duration(milliseconds: 200), vsync: this);
      closeController = AnimationController(
          duration: const Duration(milliseconds: 200), vsync: this);
      openAnimation = Tween(begin: 0.0, end: 1.0).animate(openController)
        ..addListener(() {
          setState(() {
            menuHeight = openAnimation.value;
          });
        });
      closeAnimation = Tween(begin: 1.0, end: 0.0).animate(closeController)
        ..addListener(() {
          setState(() {
            menuHeight = closeAnimation.value;
          });
        });
      _getData();
    });
  }

  _handleMenuPress() {
    setState(() {
      openController.reset();
      closeController.reset();
      menuShown = !menuShown;
      menuShown ? openController.forward() : closeController.forward();
    });
  }

  /// ---------------------------
  /// Closing all  controllers for memory leaks.
  /// ---------------------------
  @override
  void dispose() {
    openController.dispose();
    closeController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(interfaceController.booking.value))) {
      await launchUrl(Uri.parse(interfaceController.booking.value),
          mode: LaunchMode.externalApplication);
    } else {
      print('error');
    }
  }

  getLink(type) async {
    showLoading();

    await interfaceController.getInterface(
      hotel_id: widget.h_id,
      interfaceType: type,
    );

    _launchUrls();
    hideLoading();
  }

  Future<void> _launchUrls() async {
    if (await canLaunchUrl(Uri.parse(interfaceController.interfaceVal.value))) {
      await launchUrl(Uri.parse(interfaceController.interfaceVal.value),
          mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<Null> selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(2050),
      // initialDatePickerMode: DatePickerMode.day,
      // selectableDayPredicate: (DateTime val) =>
      //     restaurant_day_off.contains(val.weekday.toString()) ? false : true,
    );
    if (_datePicker != null) {
      print(_datePicker); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePicker);

      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        _birthdayController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  hotelsInGroup(group, key) {
    var item = group[key];
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.black,
      body: SizedBox(
        height: (item!.length > 3) ? 600 : item!.length * 200,
        child: ListView.builder(
          itemCount: item!.length,
          itemBuilder: (context, index) {
            return ItemHotelGroup(
              index: item[index]['index'],
              items: item[index],
            );
          },
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: tr('cancel'),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // return mainBody();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Obx(() {
        return (interfaceController.isbookingLoaded.value == true)
            ? layout()
            // : LoadingScreen(img_name: 'Pool.jpg');
            : BackGroundWidget(
                search_key: widget.h_id,
              );
      }),
    );
  }

  Widget layout() {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /// ---------------------------
          /// Building close icon with title for drawer .
          /// ---------------------------

          Container(
            color: Colors.black,
            height: menuHeight,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: (() {
                    _handleMenuPress();
                  }),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(menuShown ? Icons.cancel : Icons.home_work),
                        color: Colors.white,
                        onPressed: _handleMenuPress,
                      ),
                      Text(menuShown ? "Destination" : "Destination",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0))
                    ],
                  ),
                ),

                SizedBox(
                  height: 40.0,
                ),

                /// ---------------------------
                /// Building drawer list items .
                /// ---------------------------

                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.center,
                          child: Text("Resorts",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      for (var i = 0; i < group_hotels_resorts_keys.length; i++)
                        InkWell(
                          onTap: (() {
                            // ignore: void_checks
                            return hotelsInGroup(group_hotels_resorts,
                                group_hotels_resorts_keys[i]);
                          }),
                          child: Container(
                              padding: EdgeInsets.only(bottom: 15.0, left: 20),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                  (group_hotels_resorts_keys[i] == "Cairo")
                                      ? 'Sokhna'
                                      : group_hotels_resorts_keys[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ))),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.center,
                          child: Text("Cruises",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      for (var i = 0; i < group_hotels_cruises_keys.length; i++)
                        InkWell(
                          onTap: (() {
                            // ignore: void_checks
                            return hotelsInGroup(group_hotels_cruises,
                                group_hotels_cruises_keys[i]);
                          }),
                          child: Container(
                              padding: EdgeInsets.only(bottom: 15.0, left: 20),
                              alignment: Alignment.bottomLeft,
                              child: Text(group_hotels_cruises_keys[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ))),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),

          /// ---------------------------
          /// Main content goes here .
          /// ---------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                margin: EdgeInsets.only(
                    top: menuHeight * (constraints.maxHeight - 60) + 60),
                color: Colors.transparent,
                child: Material(
                  elevation: 16.0,
                  shape: BeveledRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(46.0)),
                  ),
                  child: (hotelController.hotel.value.out_side == "0")
                      ? mainBody()
                      : outSideBody(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].login_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5)),
        Center(
          child: SizedBox(
            width: 800,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(25),
              scrollDirection: Axis.vertical,
              child: Align(
                alignment: Alignment.topCenter,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 20),
                      Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${interfaceController.hotel[0].logo_white}',
                        height: 200,
                        width: double.infinity,
                      ),
                      InkWell(
                        onTap: (() {
                          getLink('RC');
                        }),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/Check-in.png',
                              height: 60,
                              width: 80,
                            ),
                            Text(
                              'Check -In',
                              style: TextStyle(color: Colors.white),
                            ).tr()
                          ],
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _roomNumberController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('Room Number is required');
                          }
                        },
                        decoration: InputDecoration(
                          labelText: tr('Room Number'),
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
                      Container(height: 20),
                      // TextFormField(
                      //   keyboardType: TextInputType.text,
                      //   controller: _birthdayController,
                      //   style: TextStyle(color: Colors.white),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return tr('Birth day is required');
                      //     }
                      //   },
                      //   decoration: InputDecoration(
                      //     labelText: tr("Last Name"),
                      //     labelStyle: TextStyle(color: Colors.white),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.white, width: 1),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.white, width: 2),
                      //     ),
                      //   ),
                      // ),
                      TextFormField(
                        controller: _birthdayController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date is required';
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: tr("Departure Day"),
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
                        readOnly: true,
                        onTap: () async {
                          setState(() {
                            selectDate(context);
                          });
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white.withOpacity(0.6),
                                  elevation: 0),
                              child: Text(
                                "Confirm",
                              ).tr(),
                              onPressed: () async {
                                GetStorage()
                                    .write('see_time_msg', 'not_showed');
                                if (_formKey.currentState!.validate()) {
                                  await pmsController.login(
                                    room_no: _roomNumberController.text,
                                    hotel_id: widget.h_id,
                                    context: context,
                                    birthday: _birthdayController.text,
                                  );

                                  // GetStorage().write(
                                  //     'room_num', _roomNumberController.text);
                                  // Get.to(HomeScreen(
                                  //   hotel: widget.hotel,
                                  // ));
                                  // if (pmsController.isLogin.value == true) {
                                  //   Navigator.pushNamed(
                                  //       context, '/home/${widget.h_id}');
                                  // }
                                }
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white.withOpacity(0.6),
                                  elevation: 0),
                              child: Text(
                                "Book Your Stay",
                              ).tr(),
                              onPressed: () {
                                _launchUrl();
                              },
                            ),
                          ),
                        ],
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
                              "Join As Guest",
                            ).tr(),
                            onPressed: () {
                              GetStorage().write('room_num', '');
                              Navigator.pushNamed(
                                  context, '/home/${widget.h_id}');

                              // Get.to(
                              //   HomeScreen(
                              //     hotel: widget.hotel,
                              //   ),
                              // );
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
        ),
        Container(
            height: kToolbarHeight,
            child: AppBar(
                backgroundColor: Colors.transparent,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
                elevation: 0,
                leading:
                    //  IconButton(
                    //   icon: Icon(Icons.language),
                    //   onPressed: () {
                    //     // print('test');
                    //     // Navigator.pop(context);
                    //     // ignore: deprecated_member_use
                    //     if (context.locale == AppConstant.EN_LOCAL) {
                    //       context.locale = AppConstant.AR_LOCAL;
                    //     } else {
                    //       context.locale = AppConstant.EN_LOCAL;
                    //     }
                    //     htmls.window.location.reload();
                    //   },
                    // ),

                    Row(
                  children: [],
                ),

                // Container(),

                actions: <Widget>[
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       primary: Colors.white.withOpacity(0.6), elevation: 0),
                  //   child: Text('other Resorts').tr(),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/hotels');
                  //   },
                  // ),

                  // ExpansionTile(title: title)
                  PopupMenuButton(
                    color: Colors.black,
                    icon: Icon(Icons.library_books_sharp),
                    initialValue: selectedMenu,
                    // // Callback that sets the selected popup menu item.
                    onSelected: (item) {
                      // print(item);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Book Your Stay",
                          style: menuStyle,
                        ).tr(),
                        onTap: (() {
                          _launchUrl();
                        }),
                      ),
                      PopupMenuItem(
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Join As Guest",
                          style: menuStyle,
                        ).tr(),
                        onTap: (() {
                          GetStorage().write('room_num', '');
                          // Navigator.pushNamed(
                          //     context, '/home/${widget.h_id}');
                          htmls.window.location.href = '#/home/${widget.h_id}';
                        }),
                      ),
                      PopupMenuItem(
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Check -In",
                          style: menuStyle,
                        ).tr(),
                        onTap: (() {
                          getLink('RC');
                        }),
                      ),
                    ],
                  ),
                  //
                  //
                  //
                  //
                  ////////////Lang Menu//////////
                  //
                  //
                  //
                  //
                  LanguageWidget()
                ]))
      ],
    );
  }

  Widget outSideBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].login_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5)),
        Center(
          child: SizedBox(
            width: 800,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(25),
              scrollDirection: Axis.vertical,
              child: Align(
                alignment: Alignment.topCenter,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 20),
                      Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${interfaceController.hotel[0].logo_white}',
                        height: 200,
                        width: double.infinity,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _roomNumberController,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('Your  Number is required');
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Your Number',
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
                      Container(height: 20),
                      SizedBox(
                        height: 35,
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
                            ).tr(),
                            onPressed: () {
                              outSideController.out_side_login(
                                  employee_code: _roomNumberController.text,
                                  h_id: widget.h_id,
                                  context: context);
                              // GetStorage().write('room_num', '');
                              // Navigator.pushNamed(
                              //     context, '/home/${widget.h_id}');
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
        ),
        Container(
            height: kToolbarHeight,
            child: AppBar(
                backgroundColor: Colors.transparent,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
                elevation: 0,
                leading: Row(
                  children: [],
                ),

                // Container(),

                actions: <Widget>[
                  //
                  //
                  //
                  //
                  ////////////Lang Menu//////////
                  //
                  //
                  //
                  //
                  LanguageWidget()
                ]))
      ],
    );
  }
}

class ItemHotelGroup extends StatelessWidget {
  final hotelController = Get.put(HotelsController());

  var index;
  var items;
  ItemHotelGroup({this.index, this.items, Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        // hotelController.selectHotel.value = index;
        Navigator.pushNamed(context, '/login/${items['id']}');
      }),
      child: Card(
        color: Colors.grey,
        // margin: EdgeInsets.only(top: 20),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                      'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${items['image']}',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.60)),
                  Center(
                    child: SizedBox(
                      // height: 150,
                      width: 150,
                      child: Center(
                        child: Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${items['logo_white']}',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
