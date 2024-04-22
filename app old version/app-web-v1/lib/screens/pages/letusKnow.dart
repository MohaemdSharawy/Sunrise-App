import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/let_us_know_controller.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/hotel_name.dart';
import 'package:tucana/utilites/img.dart';

class LetUsKnowScreen extends StatefulWidget {
  var hotel_id;
  LetUsKnowScreen({this.hotel_id, super.key});

  @override
  State<LetUsKnowScreen> createState() => _LetUsKnowScreenState();
}

class _LetUsKnowScreenState extends State<LetUsKnowScreen> with BaseController {
  final letUsKnowController = Get.put(LetUsKnowController());
  final hotelController = Get.put(HotelsController());
  final TextEditingController name = TextEditingController();
  final TextEditingController room_num = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController notes = TextEditingController();
  final TextEditingController code = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  var dropdown;
  var selected_code;
  void initState() {
    _getDate();
    if (GetStorage().read('room_num') != null &&
        GetStorage().read('room_num') != '') {
      name.text = GetStorage().read('full_name');
      room_num.text = GetStorage().read('room_num');
      email.text = GetStorage().read('email');
      phone.text = GetStorage().read('phonenumber');
    }
    super.initState();
  }

  int selected_dep = 0;
  _getDate() async {
    await hotelController.getHotel(hid: widget.hotel_id);
    if (hotelController.hotel.value.let_us_know_code == '') {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home/${widget.hotel_id}');
    }
    await letUsKnowController.getData(
      hotel_code: hotelController.hotel.value.let_us_know_code,
    );
    // dropdown = letUsKnowController.let_us_know_departments[0].id;
  }

  List<Map> emoji = [
    {
      "id": 1,
      "color": Colors.red,
      "status": "bad",
      "img": "assets/icons/bad.png"
    },
    {
      "id": 2,
      "color": Colors.amber,
      "status": "Ok",
      "img": "assets/icons/ok.png"
    },
    {
      "id": 3,
      "color": Colors.green,
      "status": "Great",
      "img": "assets/icons/great.png"
    }
  ];
  int selected_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (letUsKnowController.isLoaded.value == true)
            ? (GetStorage().read('room_num') != null &&
                    GetStorage().read('room_num') != '')
                ? mainBody()
                : need_login()
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  @override
  Widget need_login() {
    return Stack(children: [
      Image.asset(Img.get('letusKnowCover.png'),
          width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      Column(
        children: [
          HeaderScreen(),
          SizedBox(height: 15),
          Image.asset('assets/icons/Let Us Know.png'),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                tr('You Need Login First'),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      )
    ]);
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.asset(Img.get('letusKnowCover.png'),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),

        SingleChildScrollView(
          child: Column(
            children: [
              HeaderScreen(
                h_id: widget.hotel_id,
              ),
              SizedBox(height: 15),
              Image.asset('assets/icons/Let Us Know.png'),
              // Text(
              //     'Help us to improve our service and customer satisfaction.',),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(15),
                // height: MediaQuery.of(context).size.height,
                width: 1500,
                color: Colors.grey.withOpacity(0.6),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('Name is required');
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: tr("Name"),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('Please enter the room number');
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
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('Email is required');
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: tr("Email"),
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
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              controller: code,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr('Country Code is Required');
                                }
                              },
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: '+00',
                                labelText: tr("Code"),
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
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextFormField(
                              controller: phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr('Phone Number is required');
                                }
                              },
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: tr("Phone"),
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
                        ],
                      ),
                      SizedBox(height: 18),
                      buildDepTabs(),
                      // Container(
                      //   width: 450,
                      //   padding: EdgeInsets.all(10),
                      //   child: DropdownButton(
                      //     iconEnabledColor: Colors.white,
                      //     iconDisabledColor: Colors.white,
                      //     dropdownColor: Colors.black,
                      //     value: dropdown,
                      //     focusColor: Colors.black,
                      //     isExpanded: kFlutterMemoryAllocationsEnabled,
                      //     style: TextStyle(color: Colors.white, fontSize: 20),
                      //     hint: Text(
                      //       'Select Department'.tr,
                      //       style: TextStyle(color: Colors.white, fontSize: 20),
                      //     ),
                      //     // value: selected_answer[i],
                      //     items: letUsKnowController.let_us_know_departments
                      //         .map((dep) {
                      //       return DropdownMenuItem(
                      //           value: dep.id, child: Text(dep.dep_name));
                      //     }).toList(),

                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         dropdown = newValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 18),
                      Center(
                        child: SizedBox(
                          width: 750,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var element
                                  in letUsKnowController.priorities)
                                Column(
                                  children: [
                                    InkWell(
                                        child: Image.network(
                                          'https://letusknow.sunrise-resorts.com/public/geust/${element.image}',
                                          width: 100,
                                          height: 100,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selected_index = element.id;
                                          });
                                          print(element.name);
                                        }),
                                    Text(
                                      element.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    if (element.id == selected_index) ...[
                                      IconButton(
                                        icon: Icon(
                                          Icons.check,
                                          size: 50,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ]
                                  ],
                                )

                              // for (var element in emoji)
                              //   Column(
                              //     children: [
                              //       InkWell(
                              //           child: Image.asset(
                              //             element['img'],
                              //           ),
                              //           onTap: () {
                              //             setState(() {
                              //               selected_index = element['id'];
                              //             });
                              //             print(selected_index);
                              //           }),
                              //       if (element['id'] == selected_index) ...[
                              //         IconButton(
                              //           icon: Icon(
                              //             Icons.check,
                              //             size: 50,
                              //           ),
                              //           onPressed: () {},
                              //         ),
                              //       ]
                              //     ],
                              //   )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: notes,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('required');
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: tr("How We Can Help You"),
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
                      SizedBox(height: 25),
                      Center(
                        child: Container(
                          width: 150,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white.withOpacity(0.6),
                                elevation: 0),
                            child: Text(
                              tr("Confirm"),
                            ),
                            onPressed: () async {
                              // showLoading();

                              if (_formKey.currentState!.validate()) {
                                letUsKnowController.postData(
                                  name: name.text,
                                  phone: code.text + phone.text,
                                  email: email.text,
                                  priority_id: selected_index.toString(),
                                  room_num: room_num.text,
                                  dep_id: letUsKnowController
                                      .let_us_know_departments[selected_dep].id
                                      .toString(),
                                  hotel_code: hotelController
                                      .hotel.value.let_us_know_code,
                                  description: notes.text,
                                );
                              }

                              // hideLoading();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

        // Center(
        //   child: Container(
        //     padding: EdgeInsets.only(top: 100),
        //     child: Column(
        //       children: [
        //         Image.asset('assets/icons/Let Us Know.png'),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Container(
        //           padding: EdgeInsets.only(left: 25, right: 25),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Image.asset(
        //                 'assets/images/AR.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //               Image.asset(
        //                 'assets/images/RU.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Container(
        //           padding: EdgeInsets.only(left: 25, right: 25),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Image.asset(
        //                 'assets/images/GR.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //               Image.asset(
        //                 'assets/images/EN.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //             ],
        //           ),
        //         ),
        //         Container(
        //           padding: EdgeInsets.only(left: 25, right: 25),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Image.asset(
        //                 'assets/images/FR.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //               Image.asset(
        //                 'assets/images/IT.png',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           height: 65,
        //         ),
        //         Center(
        //           child: Text(
        //             'Let us Know Survey',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //         Center(
        //           child: Text(
        //             'Help Us To Improve Our Service and Customer Satisfaction',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
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

  Widget buildDepTabs() {
    return Obx(
      () => Wrap(children: [
        // Container(width: 10),
        for (int i = 0;
            i < letUsKnowController.let_us_know_departments.length;
            i++)
          Container(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: (i == selected_dep) ? Colors.black : Colors.grey,
                  elevation: 1),
              child: Container(
                  // padding: EdgeInsets.all(10),
                  child: Text(
                      letUsKnowController.let_us_know_departments[i].dep_name,
                      style: TextStyle(color: Colors.white, fontSize: 14))),
              onPressed: () {
                setState(() {
                  selected_dep = i;
                });
              },
            ),
          ) // Container(width: 10),
      ]),
    );
  }
}
