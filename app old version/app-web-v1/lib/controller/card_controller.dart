import 'dart:convert';
// import 'dart:ffi';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/model/product_custom_model.dart';
import 'package:tucana/model/table_model.dart';
import 'package:tucana/response/product_custom_response.dart';
import 'package:tucana/response/table_response.dart';
import 'package:tucana/services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tucana/utilites/new_socket.dart';
import 'dart:html' as htmls;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../utilites/websocket.dart';

class CardController extends GetxController with BaseController {
  var my_order = [].obs;
  var isLoaded = false.obs;
  var prices = 0.0.obs;
  var tables = <Tables>[].obs;
  var custom_option = <ProductCustomOption>[].obs;

  @override
  void onInit() {
    getSavedOrder();
    // print(price.value);
    super.onInit();
  }

  void get_price() {}

  void getSavedOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('order');
    final double? saved_price = prefs.getDouble('prices');
    tables.clear();
    if (saved_price != null) {
      prices.value = saved_price;
    }

    if (action != null) {
      my_order.value = jsonDecode(action);
    }
    if (my_order.length > 0) {
      await restaurant_table(restaurant_id: int.parse(my_order[0]['res_id']));
    }
    isLoaded.value = true;
  }

  void loadData() {
    getSavedOrder();
  }

  void saveCardData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('order', jsonEncode(my_order));
    await prefs.setDouble('prices', prices.value);
  }

  void handel_add_to_cart(productData, restaurant) {
    var item = my_order.where((e) => e['product_id'] == productData.id);
    if (item.length == 0) {
      addProduct(productData, restaurant);
      saveCardData();
    } else {
      updateProduct(productData);
      saveCardData();
    }
  }

  void addTOCard(productData, restaurant) {
    // print('-------');
    // print(int.parse( productData) );
    if (int.parse(restaurant.hid) == 29) {
      if (check_count_of_product()) {
        handel_add_to_cart(productData, restaurant);
      } else {
        Get.snackbar(
          'Message',
          'You can Add Only 3',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      handel_add_to_cart(productData, restaurant);

      // var item = my_order.where((e) => e['product_id'] == productData.id);
      // if (item.length == 0) {
      //   addProduct(productData, restaurant);
      //   saveCardData();
      // } else {
      //   updateProduct(productData);
      //   saveCardData();
      // }
    }
  }

  //Check For 3 Product of total Qty = 3
  bool check_count_of_product() {
    int count = 0;
    if (my_order.length >= 3) {
      print('false');
      return false;
    } else {
      for (var product in my_order) {
        count += int.parse(product['qty']);
        if (count >= 3) {
          print('false');
          return false;
        }
      }
    }
    print('true');
    return true;
  }

  void addProduct(productData, restaurant) {
    Map myProduct = {
      'name': productData.product_name,
      'product_id': productData.id,
      'qty': 1,
      'img_name': productData.logo,
      'price': productData.price,
      'res_code': restaurant.code,
      'default_logo': restaurant.logo,
      'res_id': restaurant.id,
      'room_service': restaurant.room_service,
      'fired': 0,
      'customize': 0,
      'custom_option': [].obs,
      'notes': '',
      'hid': restaurant.hid,
      'view_price': productData.price
    };
    prices.value = prices.value + double.parse(productData.price);
    my_order.add(myProduct);
    // print(my_order);
  }

  // void customOption(
  //     product, selected_answer, custom_option_name, custom_option_id) {
  //   if (!product['custom_option'].isEmpty) {
  //     var item = product['custom_option']
  //         .where((e) => e['custom_option_id'] == custom_option_id);
  //     //ADD Custom OPtin For THis Product
  //     if (item.isEmpty) {
  //       product['custom_option'].add({
  //         'product_id': product['product_id'],
  //         'custom_option_id': selected_answer['custom_option_id'],
  //         'custom_option_item_id': selected_answer['id'],
  //         'custom_option_name': custom_option_name,
  //         'custom_option_item_name': selected_answer['item_name'],
  //         'price': selected_answer['price'],
  //         'total_price': selected_answer['price'],
  //         'qty': "0"
  //       });
  //       prices.value = prices.value + double.parse(selected_answer['price']);
  //     } else {
  //       //Edit option Custom For Product
  //       int key = product['custom_option'].indexWhere(
  //           (element) => element['custom_option_id'] == custom_option_id);
  //       double old_price = double.parse(product['custom_option'][key]['price']);
  //       prices.value = prices.value - old_price;
  //       product['custom_option'][key] = {
  //         'product_id': product['product_id'],
  //         'custom_option_id': selected_answer['custom_option_id'],
  //         'custom_option_item_id': selected_answer['id'],
  //         'custom_option_name': custom_option_name,
  //         'custom_option_item_name': selected_answer['item_name'],
  //         'price': selected_answer['price'],
  //         'total_price': selected_answer['price'],
  //         'qty': "0"
  //       };
  //       prices.value = prices.value + double.parse(selected_answer['price']);
  //     }
  //   } else {
  //     //Add First Custom For Product

  //     product['custom_option'] = [
  //       {
  //         'product_id': product['product_id'],
  //         'custom_option_id': selected_answer['custom_option_id'],
  //         'custom_option_item_id': selected_answer['id'],
  //         'custom_option_name': custom_option_name,
  //         'custom_option_item_name': selected_answer['item_name'],
  //         'price': selected_answer['price'],
  //         'total_price': selected_answer['price'],
  //         'qty': "0"
  //       }
  //     ];
  //     prices.value = prices.value + double.parse(selected_answer['price']);
  //   }
  //   product['customize'] = 1;
  //   saveCardData();
  // }

  void customOption(
    product,
    selected_answer,
    custom_option_name,
    custom_option_id,
    context,
  ) {
    if (!product['custom_option'].isEmpty) {
      var item = product['custom_option']
          .where((e) => e['custom_option_id'] == custom_option_id);
      //ADD Custom OPtin For THis Product
      if (item.isEmpty) {
        product['custom_option'].add({
          'product_id': product['product_id'],
          'custom_option_id': selected_answer['custom_option_id'],
          'custom_option_item_id': selected_answer['id'],
          'custom_option_name': custom_option_name,
          'custom_option_item_name': selected_answer['item_name'],
          'price': selected_answer['price'],
          'total_price': selected_answer['price'],
          'qty': "0"
        });
        price_custom(price: selected_answer['price'], product: product);

        // prices.value = prices.value + double.parse(selected_answer['price']);
      } else {
        //Edit option Custom For Product
        int key = product['custom_option'].indexWhere(
            (element) => element['custom_option_id'] == custom_option_id);
        // double old_price = double.parse(product['custom_option'][key]['price']);
        // prices.value = prices.value - old_price;
        price_custom(
          price: selected_answer['price'],
          product: product,
          old_price: product['custom_option'][key]['price'],
        );

        product['custom_option'][key] = {
          'product_id': product['product_id'],
          'custom_option_id': selected_answer['custom_option_id'],
          'custom_option_item_id': selected_answer['id'],
          'custom_option_name': custom_option_name,
          'custom_option_item_name': selected_answer['item_name'],
          'price': selected_answer['price'],
          'total_price': selected_answer['price'],
          'qty': "0"
        };
        // prices.value = prices.value + double.parse(selected_answer['price']);
      }
    } else {
      //Add First Custom For Product

      create_new_product_with_custom(
        product,
        selected_answer,
        custom_option_name,
        context,
      );
    }
    // product['customize'] = 1;
    saveCardData();
  }

  void create_new_product_with_custom(
    product,
    selected_answer,
    custom_option_name,
    context,
  ) {
    if (product['qty'] > 1) {
      product['qty'] = product['qty'] - 1;
      double view_price =
          double.parse(product['view_price']) - double.parse(product['price']);
      product['view_price'] = view_price.toString();
      var new_product = {
        'name': product['name'],
        'product_id': product['product_id'],
        'qty': 1,
        'img_name': product['img_name'],
        'price': product['price'],
        'res_code': product['res_code'],
        'default_logo': product['default_logo'],
        'res_id': product['res_id'],
        'fired': 0,
        'customize': 1,
        'room_service': product['room_service'],
        'notes': '',
        'hid': product['hid'],
        'view_price': product['price'],
        'custom_option': [
          {
            'product_id': product['product_id'],
            'custom_option_id': selected_answer['custom_option_id'],
            'custom_option_item_id': selected_answer['id'],
            'custom_option_name': custom_option_name,
            'custom_option_item_name': selected_answer['item_name'],
            'price': selected_answer['price'],
            'total_price': selected_answer['price'],
            'qty': "0"
          }
        ]
      };
      my_order.insert(0, new_product);
      price_custom(price: selected_answer['price'], product: my_order[0]);
      // my_order.add(new_product);
    } else {
      product['custom_option'] = [
        {
          'product_id': product['product_id'],
          'custom_option_id': selected_answer['custom_option_id'],
          'custom_option_item_id': selected_answer['id'],
          'custom_option_name': custom_option_name,
          'custom_option_item_name': selected_answer['item_name'],
          'price': selected_answer['price'],
          'total_price': selected_answer['price'],
          'qty': "0"
        }
      ];
      product['customize'] = 1;
      price_custom(price: selected_answer['price'], product: product);
    }

    Navigator.of(context).pop();

    saveCardData();
  }

  void deleted_custom_option(product) {
    for (var element in product['custom_option']) {
      double old_price = double.parse(element['price']);
      prices.value = prices.value - old_price;
    }

    product['custom_option'] = [];
  }

  void updateProduct(productData) {
    // int key = my_order
    //     .indexWhere((element) => element['name'] == productData.product_name);
    // my_order[key]['qty'] == my_order[key]['qty']++;
    // prices.value = prices.value + double.parse(productData.price);
    int key = my_order.indexWhere((element) =>
        element['product_id'] == productData.id && element['customize'] == 0);
    my_order[key]['qty'] == my_order[key]['qty']++;

    changePrice(selected_method: 'inc_product', product_index: key);
  }

  // void increment(productName) {
  //   int key = my_order.indexWhere((element) => element['name'] == productName);
  //   my_order[key]['qty'] == my_order[key]['qty']++;
  //   prices.value = prices.value + double.parse(my_order[key]['price']);
  //   saveCardData();
  //   // print(my_order);
  // }

  // void decrement(productName) {
  //   int key = my_order.indexWhere((element) => element['name'] == productName);
  //   my_order[key]['qty'] == my_order[key]['qty']--;
  //   prices.value = prices.value - double.parse(my_order[key]['price']);
  //   saveCardData();
  //   // print(my_order);
  // }

  // void deleteItem(productName) {
  //   int key = my_order.indexWhere((element) => element['name'] == productName);
  //   prices.value = prices.value -
  //       (double.parse(my_order[key]['price']) * my_order[key]['qty']);

  //   deleted_custom_option(my_order[key]);

  //   my_order.removeAt(key);
  //   saveCardData();
  // }

  void decrement({required int index}) {
    if (my_order[index]['qty'] > 1) {
      if (int.parse(my_order[0]['hid']) == 29) {
        if (check_count_of_product()) {
          my_order[index]['qty'] == my_order[index]['qty']--;
          changePrice(selected_method: 'dec_product', product_index: index);
          saveCardData();
        } else {
          Get.snackbar(
            'Message',
            'You can Add Only 3',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        my_order[index]['qty'] == my_order[index]['qty']--;
        changePrice(selected_method: 'dec_product', product_index: index);
        saveCardData();
      }
    }
    // print(my_order);
  }

  void increment({required int index}) {
    if (int.parse(my_order[0]['hid']) == 29) {
      if (check_count_of_product()) {
        my_order[index]['qty'] == my_order[index]['qty']++;
        changePrice(selected_method: 'inc_product', product_index: index);
        saveCardData();
      } else {
        Get.snackbar(
          'Message',
          'You can Add Only 3',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      my_order[index]['qty'] == my_order[index]['qty']++;
      changePrice(selected_method: 'inc_product', product_index: index);
      saveCardData();
    }
  }

  void deleteItem({required int index}) {
    // int key = my_order.indexWhere((element) => element['name'] == productName);
    // prices.value = prices.value -
    //     (double.parse(my_order[key]['price']) * my_order[key]['qty']);
    changePrice(selected_method: 'del_product', product_index: index);
    my_order.removeAt(index);
    saveCardData();
  }

  void clearItem() {
    my_order.value = [];
    prices.value = 0.0;
    tables.clear();
    saveCardData();
  }

  void changePrice({
    required String selected_method,
    required int product_index,
  }) {
    var methods = {
      'inc_product': inc_product_price,
      'dec_product': dec_product_price,
      'del_product': del_product_price,
    };
    methods[selected_method]!(product_index: product_index);
  }

  void inc_product_price({required int product_index}) {
    prices.value =
        prices.value + double.parse(my_order[product_index]['price']);

    double view_price = double.parse(my_order[product_index]['view_price']) +
        double.parse(my_order[product_index]['price']);
    my_order[product_index]['view_price'] = view_price.toString();
    if (my_order[product_index]['customize'] == 1) {
      for (var element in my_order[product_index]['custom_option']) {
        double view_price =
            double.parse(my_order[product_index]['view_price']) +
                double.parse(element['price']);
        my_order[product_index]['view_price'] = view_price.toString();
        prices.value = prices.value + double.parse(element['price']);
      }
    }
  }

  void dec_product_price({required int product_index}) {
    prices.value =
        prices.value - double.parse(my_order[product_index]['price']);

    double view_price = double.parse(my_order[product_index]['view_price']) -
        double.parse(my_order[product_index]['price']);
    my_order[product_index]['view_price'] = view_price.toString();
    if (my_order[product_index]['customize'] == 1) {
      for (var element in my_order[product_index]['custom_option']) {
        double view_price =
            double.parse(my_order[product_index]['view_price']) -
                double.parse(element['price']);
        my_order[product_index]['view_price'] = view_price.toString();
        prices.value = prices.value - double.parse(element['price']);
      }
    }
  }

  void del_product_price({required int product_index}) {
    if (my_order[product_index]['customize'] == 1) {
      for (var element in my_order[product_index]['custom_option']) {
        prices.value = prices.value - double.parse(element['price']);
      }
    }
    prices.value = prices.value -
        (double.parse(my_order[product_index]['price']) *
            my_order[product_index]['qty']);
  }

  void price_custom({
    // String? custom_option_id,
    required String price,
    String? old_price,
    required Map product,
  }) {
    if (old_price == null) {
      double view_price =
          double.parse(product['view_price']) + double.parse(price);
      product['view_price'] = view_price.toString();
      prices.value = prices.value + double.parse(price);
    } else {
      print('I Am Hereee');

      double view_price = double.parse(product['view_price']) +
          double.parse(price) -
          double.parse(old_price);
      product['view_price'] = view_price.toString();

      prices.value =
          prices.value + double.parse(price) - double.parse(old_price);
    }
  }

  Future<void> bookOrder(
      {required int restaurant_id,
      required String room_no,
      required int table,
      required List products,
      required context}) async {
    showLoading();

    Map<String, dynamic> postData = {
      'room': room_no,
      'table': table.toString(),
      'total_price': prices.value.toString(),
      // 'order_id': '',
      'restaurant_id': restaurant_id,
      'products': products,
      'total_qty': get_total_qty()
    };

    const Map<String, String> _JSON_HEADERS = {
      "content-type": "application/json"
      // "Content-Type": "multipart/form-data,multipart/form-data",
      // "Access-Control-Allow-Origin": "*",
    };
    var url = Uri.parse(
        "https://yourcart.sunrise-resorts.com/clients/api/post_order/${restaurant_id}");

    Future sendPost(Map<String, dynamic> data) async {
      try {
        http.Client client = new http.Client();
        final String encodedData = json.encode(data);
        final response = await client.post(
          url, //your address here
          body: encodedData,
          // headers: _JSON_HEADERS,
        );

        if (my_order[0]['hid'] == "29") {
          final socket = SocketIo(
            // '496',
            my_order[0]['res_id'],
            "https://yourcart.sunrise-resorts.com/",
          );
          socket.connectToSocket();
          // final webSocketManager = WebSocketManager(
          //   my_order[0]['res_id'],
          //   // "496",
          //   "https://yourcart.sunrise-resorts.com/",
          // );

          // webSocketManager.webSocketFireProducts();
        }

        hideLoading();
        // String redirect_code = my_order[0]['res_code'];
        clearItem();
        // Navigator.pushNamed(context, '/categories/${redirect_code}');

        switch (response.statusCode) {
          case 200:
            return Get.snackbar(
              'Message',
              'Order Done Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          default:
            Get.snackbar(
              'Message',
              json.decode(response.body)['msg'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          // print(response.body);
          // throw Exception(json.decode(response.body)['msg']);
        }

        // Get.snackbar(
        //   'Message',
        //   'Order Done Successfully',
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        // htmls.window.location.reload();
      } catch (e) {
        print(e);
        hideLoading();
        Get.snackbar(
          'Message',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    await sendPost(postData);
  }

  Future<void> restaurant_table({required int restaurant_id}) async {
    var response = await Api.getRestaurantTable(restaurant_id: restaurant_id);
    var tableResponse = TablesResponse.fromJson(response.data);

    tables.clear();

    tables.addAll(tableResponse.tables);
  }

  Future<void> product_custom({required String product_id}) async {
    var response = await Api.product_custom(product_id: product_id);
    var productResponse = ProductCustomOptionResponse.fromJson(response.data);

    custom_option.clear();

    custom_option.addAll(productResponse.custom_option);
  }

  int get_table_id_by_name(table_name) {
    int key = tables.indexWhere((e) => e.table_name == table_name);
    return int.parse(tables[key].id);
  }

  int get_total_qty() {
    int total_qty = 0;
    for (var product in my_order) {
      total_qty += int.parse(product['qty']);
    }
    return total_qty;
  }
}
