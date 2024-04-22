import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/card_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/outside_auth_controller.dart';
import 'package:tucana/controller/pms_controller.dart';
import 'package:tucana/model/product_model.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controller/base_controller.dart';
import '../utilites/loading.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'dart:html' as htmls;

import '../utilites/websocket.dart';

// import 'package:awesome_select/awesome_select.dart';

class MyOrderScreen extends StatefulWidget {
  var h_id;
  MyOrderScreen({this.h_id, super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> with BaseController {
  final cardController = Get.put(CardController());
  final pmsController = Get.put(PmsController());
  late SingleValueDropDownController _cnt;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final hotelController = Get.put(HotelsController());
  final TextEditingController room_no = TextEditingController();
  // final _roomNumberController = TextEditingController();
  final _birthdayController = TextEditingController();
  final outSideController = Get.put(OutSideAuthController());
  // List dropdownValue = [];
  String? selected_table;

  @override
  void initState() {
    room_no.text = GetStorage().read('room_num');
    _cnt = SingleValueDropDownController();

    _getData() async {
      await hotelController.getHotel(hid: widget.h_id);
      await hotelController.getBackGround(
        search_key: widget.h_id,
        // screen_type: 'home_screen',
      );
      cardController.getSavedOrder();
      npsQuestion(context);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    _getData();

    super.initState();
  }

  @override
  void dispose() {
    // _cnt.dispose();
    super.dispose();
  }

  Future book_order() async {
    await cardController.bookOrder(
        context: context,
        restaurant_id: int.parse(cardController.my_order[0]['res_id']),
        room_no: room_no.text,
        table: (selected_table != null)
            ? cardController.get_table_id_by_name(selected_table)
            : 0,
        products: cardController.my_order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (cardController.isLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
    // return Scaffold(body: Obx((() => mainBody())));
  }

  // void increaseItem(itemCount, itemName) {
  //   setState(() {
  //     itemCount = itemCount++;
  //   });
  //   cardController.increment(itemName);
  // }

  // // updateCustom(i, value) {
  // //   setState(() {
  // //     dropdownValue[i] = value;
  // //   });
  // // }

  // void decreaseItem(itemCount, itemName) {
  //   if (itemCount != 0) {
  //     setState(() {
  //       itemCount = itemCount--;
  //     });
  //     cardController.decrement(itemName);
  //   }
  // }

  // void deleteItem(itemName) {
  //   cardController.deleteItem(itemName);
  //   setState(() {
  //     cardController.my_order = cardController.my_order;
  //   });
  // }

  void increaseItem(index) {
    print('x');
    cardController.increment(index: index);
    // cardController.clearItem();
    setState(() {
      cardController.my_order = cardController.my_order;
    });
  }

  void decreaseItem(index) {
    cardController.decrement(index: index);
    // cardController.clearItem();
    setState(() {
      cardController.my_order = cardController.my_order;
    });
  }

  void deleteItem(index) {
    cardController.deleteItem(index: index);
    setState(() {
      cardController.my_order = cardController.my_order;
    });
  }

  void product_custom() {
    setState(() {
      cardController.my_order = cardController.my_order;
    });
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

  Widget mainBody() {
    // return Obx(() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 650,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppBarWidget(
                        h_id: widget.h_id,
                      ),
                      SizedBox(height: 60),
                      Center(
                        child: Text(
                          'MY ORDERS',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sans-bold',
                              fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (GetStorage().read('room_num') != '' &&
                          GetStorage().read('room_num') != null) ...[
                        Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: TextFormField(
                            readOnly: (GetStorage().read('room_num') != '' &&
                                    GetStorage().read('room_num') != null)
                                ? true
                                : false,
                            controller: room_no,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Room Number is required';
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText:
                                  (hotelController.hotel.value.out_side != "1")
                                      ? tr("Room Number")
                                      : "Employee Code",
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
                        )
                      ],
                      SizedBox(
                        height: 15,
                      ),
                      (cardController.my_order.length > 0)
                          ? (cardController.my_order[0]['room_service'] == "0")
                              ? Container(
                                  width: 750,
                                  // margin: EdgeInsets.only(left: 25, right: 25),
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Card(
                                      color: Colors.white.withOpacity(0.7),
                                      // child: DropDownTextField(
                                      //   textFieldDecoration: InputDecoration(
                                      //     hintText: tr('Select Table'),
                                      //   ),
                                      //   // padding: EdgeInsets.only(left: 15, right: 15),
                                      //   clearOption: true,
                                      //   controller: _cnt,
                                      //   enableSearch: false,
                                      //   listTextStyle:
                                      //       TextStyle(color: Colors.black),
                                      //   clearIconProperty:
                                      //       IconProperty(color: Colors.green),
                                      //   searchDecoration: const InputDecoration(
                                      //       hintText:
                                      //           "enter your custom hint text here"),
                                      //   validator: (value) {
                                      //     if (cardController.my_order[0]
                                      //             ['room_service'] !=
                                      //         "1") {
                                      //       if (value == null || value.isEmpty) {
                                      //         return 'Table is required';
                                      //       }
                                      //     }
                                      //   },
                                      //   dropDownItemCount: 6,
                                      //   dropDownList: cardController.tables
                                      //       .map((e) => DropDownValueModel(
                                      //           value: e.id, name: e.table_name))
                                      //       .toList(),
                                      //   onChanged: (val) {},
                                      // ),
                                      child: DropdownButton(
                                        value: selected_table,
                                        hint: (hotelController
                                                    .hotel.value.out_side !=
                                                "1")
                                            ? Text(tr('Select Table'))
                                            : Text(tr('Select Office')),
                                        items:
                                            cardController.tables.map((answer) {
                                          return DropdownMenuItem(
                                            value: answer.table_name,
                                            child: Text('${answer.table_name}'),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          print(newValue);
                                          setState(() {
                                            selected_table =
                                                newValue.toString();
                                          });
                                        },
                                      )),
                                )
                              : Container()
                          : Container(),
                      SizedBox(
                        height: 25,
                      ),
                      if (cardController.my_order.length > 0) ...[
                        SizedBox(
                          height: 200.0 * cardController.my_order.length,
                          child: buildItems(),
                        ),
                      ],
                      Container(
                        margin: EdgeInsets.all(25),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              cardController.prices.value.toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (cardController.my_order.length > 0) ...[
                        footerBtn(),
                      ],
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // restaurantItem(),
      ],
    );
    // });
  }

  Widget buildItems() {
    return Obx(() {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cardController.my_order.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, bottom: 10),
                      child: Image.network(
                        (cardController.my_order[index]['img_name'] != '')
                            ? 'https://yourcart.sunrise-resorts.com/assets/uploads/products/${cardController.my_order[index]['img_name']}'
                            : 'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${cardController.my_order[index]['default_logo']}',
                        height: 100,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 25),
                              width: 120,
                              child: Text(
                                cardController.my_order[index]['name'],
                                style: TextStyle(
                                    overflow: TextOverflow.fade,
                                    color: Colors.white,
                                    fontFamily: 'Sans-bold'),
                              ),
                            ),
                            Text(
                              cardController.my_order[index]['view_price'],
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Sans-bold'),
                            ),
                          ],
                        ),
                        if (!cardController
                            .my_order[index]['custom_option'].isEmpty) ...[
                          for (var item in cardController.my_order[index]
                              ['custom_option'])
                            Row(
                              children: [
                                Text(
                                  '${item['custom_option_name']} : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  item['custom_option_item_name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                        ],
                        Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                // decreaseItem(
                                //   cardController.my_order[index]['qty'],
                                //   cardController.my_order[index]['name'],
                                // );
                                decreaseItem(index);
                              }),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.grey,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Text(
                              '${cardController.my_order[index]['qty']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: (() {
                                // increaseItem(
                                //   cardController.my_order[index]['qty'],
                                //   cardController.my_order[index]['name'],
                                // );
                                increaseItem(index);
                              }),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.grey,
                                child: Icon(Icons.add),
                              ),
                            ),
                            InkWell(
                              onTap: (() {
                                // deleteItem(
                                //     cardController.my_order[index]['name']);
                                deleteItem(index);
                              }),
                              child: Card(
                                color: Colors.grey,
                                child: Icon(Icons.delete),
                              ),
                            ),
                            InkWell(
                              onTap: (() async {
                                await cardController.product_custom(
                                    product_id: cardController.my_order[index]
                                        ['product_id']);

                                showCustom(cardController.my_order[index]);
                              }),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.grey,
                                child: Icon(Icons.edit_note_sharp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  // marg,
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        cardController.my_order[index]['notes'] = value;
                        cardController.saveCardData();
                      });
                    }),
                    initialValue: cardController.my_order[index]['notes'],
                    // controller: cardController.my_order[index]['notes'],
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: tr("Note"),
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
              ],
            ),
          );
        },
      );
    });
  }

  Widget footerBtn() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            child: Text('Check Out'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white.withOpacity(0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: (() async {
              if (_formKey.currentState!.validate()) {
                // showLoading();
                if (room_no.text != null && room_no.text != '') {
                  book_order();
                  // print(room_no.text);
                } else {
                  print(room_no.text);
                  return AwesomeDialog(
                    context: context,
                    autoDismiss: false,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    dialogBackgroundColor: Colors.black,
                    body: Center(
                      child: (hotelController.hotel.value.out_side == "0")
                          ? login()
                          : outsideLogin(),
                    ),
                    btnCancelOnPress: () {
                      htmls.window.location.reload();
                    },
                    btnOkOnPress: () async {
                      if (_formKey.currentState!.validate()) {
                        (hotelController.hotel.value.out_side == "0")
                            ? await pmsController
                                .login(
                                room_no: room_no.text,
                                hotel_id: cardController.my_order[0]['hid'],
                                context: context,
                                birthday: _birthdayController.text,
                                login_type: 'ordering',
                              )
                                .then((value) {
                                if (GetStorage().read('room_num') != null &&
                                    GetStorage().read('room_num') != '' &&
                                    cardController.my_order.length > 0) {
                                  book_order();
                                }
                              })
                            : await outSideController
                                .out_side_login(
                                employee_code: room_no.text,
                                h_id: widget.h_id,
                                context: context,
                                redirect_login: false,
                              )
                                .then((value) {
                                if (GetStorage().read('room_num') != null &&
                                    GetStorage().read('room_num') != '' &&
                                    cardController.my_order.length > 0) {
                                  book_order();
                                }
                              });
                      }
                    },
                    btnCancelText: tr('cancel'),
                    btnOkText: tr('login'),
                  ).show();
                }

                // // String redirect_code = cardController.my_order[0]['res_code'];
                // cardController.clearItem();
                // // Navigator.pushNamed(context, '/categories/${redirect_code}');
                // hideLoading();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget outsideLogin() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              controller: room_no,
              style: TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return tr('Code is required');
                }
              },
              decoration: InputDecoration(
                labelText: 'Employee Code',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }

  Widget login() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              controller: room_no,
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
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            Container(height: 20),
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
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              readOnly: true,
              onTap: () async {
                setState(() {
                  selectDate(context);
                });
              },
            ),
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
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white, width: 2),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 35,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 150,
            //       height: 45,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Colors.white.withOpacity(0.6), elevation: 0),
            //         child: Text(
            //           "Confirm",
            //         ).tr(),
            //         onPressed: () async {
            //           if (_formKey.currentState!.validate()) {
            //             await pmsController.login(
            //               room_no: _roomNumberController.text,
            //               hotel_id: 0,
            //               context: context,
            //               birthday: _birthdayController.text,
            //             );
            //           }
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showCustom(product) async {
    String back_ground;
    bool _dilog_open = true;
    if (product['img_name'] != '') {
      back_ground =
          'https://yourcart.sunrise-resorts.com/assets/uploads/products/${product['img_name']}';
    } else {
      back_ground =
          'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${product['default_logo']}';
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          List selected_answer = List.generate(
            cardController.custom_option.length,
            (i) => '',
          );

          // if (product['custom_option'].isEmpty) {
          //   product['custom_option'] = List.generate(
          //     cardController.custom_option.length,
          //     (i) => '',
          //     // (i) => cardController.custom_option[i].answers[0].toString(),
          //   );
          //   // print(product['custom_option'][0].runtimeType);
          // } else {
          //   print('old');
          //   product['custom_option'] = List.generate(
          //     cardController.custom_option.length,
          //     (i) => product['custom_option'][i].toString(),
          //   );
          //   // print(product['custom_option'][0].runtimeType);
          // }

          return SingleChildScrollView(
            child: Container(
              height: 600,
              child: Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 750,
                      padding: EdgeInsets.only(
                        top: 66.0 + 16.0,
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      margin: EdgeInsets.only(top: 66.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 16.0,
                            offset: const Offset(0.0, 16.0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (cardController.custom_option.isNotEmpty)
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        cardController.custom_option.length,
                                    itemBuilder: (BuildContext c, int i) {
                                      if (!product['custom_option'].isEmpty) {
                                        for (var item
                                            in product['custom_option']) {
                                          if (item['custom_option_id'] ==
                                              cardController.custom_option[i]
                                                  .custom_option_id) {
                                            for (var element in cardController
                                                .custom_option[i].answers) {
                                              if (element['id'] ==
                                                  item[
                                                      'custom_option_item_id']) {
                                                selected_answer[i] = element;
                                              }
                                            }
                                          }
                                        }
                                      }
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter dropdownState) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                cardController.custom_option[i]
                                                    .custom_option_name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            DropdownButton(
                                              value: selected_answer[i],
                                              items: cardController
                                                  .custom_option[i].answers
                                                  .map((answer) {
                                                return DropdownMenuItem(
                                                  value: answer,
                                                  child: Text(
                                                      '${answer["item_name"]} (${answer["price"]})'),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                dropdownState(() {
                                                  selected_answer[i] = newValue;

                                                  print(selected_answer[i]);
                                                  cardController.customOption(
                                                    product,
                                                    selected_answer[i],
                                                    cardController
                                                        .custom_option[i]
                                                        .custom_option_name,
                                                    selected_answer[i]
                                                        ['custom_option_id'],
                                                    context,
                                                  );
                                                  product_custom();
                                                  // print(product['custom_option']);
                                                });
                                                // cardController.saveCardData();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'There Is No Custom Option For This Product',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                          if (cardController.custom_option.isNotEmpty) ...[
                            SizedBox(height: 24.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              // child: RaisedButton(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(16.0)),
                              //   color: Colors.teal,
                              //   onPressed: () {
                              //     List selected_answer = List.generate(
                              //       cardController.custom_option.length,
                              //       (i) => '',
                              //     );
                              //     // product['custom_option'] = [];
                              //     // product_custom();
                              //     cardController.deleted_custom_option(product);
                              //     Navigator.of(context).pop();
                              //   },
                              //   child: Text(
                              //     "Clear Customize",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              // ),
                            ),
                          ],
                          SizedBox(height: 24.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            // child: RaisedButton(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(16.0)),
                            //   color: Colors.teal,
                            //   onPressed: () {
                            //     Navigator.of(context).pop();
                            //   },
                            //   child: Text(
                            //     "Close",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black.withOpacity(0.6),
                                  elevation: 0),
                              child: Text(
                                "close",
                              ).tr(),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 24.0 + 66.0,
                      right: 24.0 + 66.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(back_ground),
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showCustom1(product) async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.white,
      body: SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: cardController.custom_option.length,
            itemBuilder: (BuildContext c, int i) {
              return DropDownTextField(
                textFieldDecoration: InputDecoration(
                    hintText:
                        cardController.custom_option[i].custom_option_name),

                clearOption: true,
                enableSearch: false,
                // initialValue: "3",
                dropDownItemCount: 3,
                dropDownList: cardController.custom_option[i].answers
                    .map((e) => DropDownValueModel(value: e.id, name: e.id))
                    .toList(),

                // .map((e) =>
                //     DropDownValueModel(value: e.id, name: e.table_name))
                // .toList(),
                onChanged: (val) {},
              );

              // dropdownValue
              //     .add(cardController.custom_option[i].answers[0]);
              // return Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(8),
              //       child: Text(
              //         cardController.custom_option[i].custom_option_name,
              //         style: TextStyle(color: Colors.black, fontSize: 15),
              //       ),
              //     ),
              //     // DropdownButton(
              //     //   // hint: Text(
              //     //   //     'Please choose Option'), // Not necessary for Option 1
              //     //   value: dropdownValue[i],

              //     //   items:
              //     //       cardController.custom_option[i].answers.map((answer) {
              //     //     return DropdownMenuItem(
              //     //       value: answer,
              //     //       child: Text(answer['item_name']),
              //     //     );
              //     //   }).toList(),
              //     //   onChanged: (newValue) {
              //     //     setState(() {
              //     //       dropdownValue[i] = newValue;
              //     //     });
              //     //   },
              //     // )
              //   ],
              // );
            }),
      ),
      btnCancelOnPress: () {},
      btnCancelText: tr('cancel'),
    ).show();
  }
}
