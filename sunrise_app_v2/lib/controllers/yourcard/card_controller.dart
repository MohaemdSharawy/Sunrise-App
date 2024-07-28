import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_custom_option.dart';
import 'package:sunrise_app_v2/models/yourcard/table_model.dart';
import 'package:sunrise_app_v2/response/yourcard/product_custom_response.dart';
import 'package:sunrise_app_v2/response/yourcard/table_response.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

// import '../model/product_custom_model.dart';

class CartController extends GetxController {
  var my_order = [].obs;
  var isLoaded = false.obs;
  var prices = 0.0.obs;
  var custom_option = <ProductCustomOption>[].obs;
  var custom_loaded = false.obs;

  var tables = <Tables>[].obs;
  final restaurantController = Get.put(RestaurantController());

  var current_product_qty = 0.obs;

  @override
  void onInit() {
    getSavedOrder();
    // print(price.value);
    super.onInit();
  }

  void get_price() {}

  get_product_cart_index(product_id) {
    int key = my_order.indexWhere((e) => e['product_id'] == product_id);
    if (key == -1) {
      return null;
    } else {
      return key;
    }
  }

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
      // await restaurant_table(restaurant_id: int.parse(my_order[0]['res_id']));
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

  void addTOCard(productData, restaurant) {
    var item = my_order
        .where((e) => e['product_id'] == productData.id && e['customize'] == 0);
    if (item.isEmpty) {
      addProduct(productData, restaurant);
      saveCardData();
    } else {
      updateProduct(productData);
      saveCardData();
    }
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
      'fired': 0,
      'customize': 0,
      'custom_option': [].obs,
      'room_service': restaurant.room_service,
      'notes': '',
      'hid': restaurant.hid,
      'view_price': productData.price
    };
    prices.value = prices.value + double.parse(productData.price);
    my_order.add(myProduct);
    // print(my_order);
  }

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

// // ? Adjusted Custom without split item
//   void create_new_product_with_custom(
//     product,
//     selected_answer,
//     custom_option_name,
//     context,
//   ) {
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
//     product['customize'] = 1;
//     price_custom(price: selected_answer['price'], product: product);

//     // Navigator.of(context).pop();

//     saveCardData();
//   }
// ! Adjusted New Custom Without Split
  void create_new_product_with_custom(
    product,
    selected_answer,
    custom_option_name,
    context,
  ) {
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

    // Navigator.of(context).pop();

    saveCardData();
  }

  // void create_new_product_with_custom(
  //   product,
  //   selected_answer,
  //   custom_option_name,
  //   context,
  // ) {
  //   if (product['qty'] > 1) {
  //     product['qty'] = product['qty'] - 1;
  //     double view_price =
  //         double.parse(product['view_price']) - double.parse(product['price']);
  //     product['view_price'] = view_price.toString();
  //     var new_product = {
  //       'name': product['name'],
  //       'product_id': product['product_id'],
  //       'qty': 1,
  //       'img_name': product['img_name'],
  //       'price': product['price'],
  //       'res_code': product['res_code'],
  //       'default_logo': product['default_logo'],
  //       'res_id': product['res_id'],
  //       'fired': 0,
  //       'customize': 1,
  //       'room_service': product['room_service'],
  //       'notes': '',
  //       'hid': product['hid'],
  //       'view_price': product['price'],
  //       'custom_option': [
  //         {
  //           'product_id': product['product_id'],
  //           'custom_option_id': selected_answer['custom_option_id'],
  //           'custom_option_item_id': selected_answer['id'],
  //           'custom_option_name': custom_option_name,
  //           'custom_option_item_name': selected_answer['item_name'],
  //           'price': selected_answer['price'],
  //           'total_price': selected_answer['price'],
  //           'qty': "0"
  //         }
  //       ]
  //     };
  //     my_order.insert(0, new_product);
  //     price_custom(price: selected_answer['price'], product: my_order[0]);
  //     // my_order.add(new_product);
  //   } else {
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
  //     product['customize'] = 1;
  //     price_custom(price: selected_answer['price'], product: product);
  //   }

  //   // Navigator.of(context).pop();

  //   saveCardData();
  // }

  void removeCustom(product, custom_option_id) {
    int key = product['custom_option'].indexWhere((element) =>
        element['custom_option_id'].toString() == custom_option_id.toString());
    price_custom(
      price: '0',
      product: product,
      old_price: product['custom_option'][key]['price'].toString(),
    );
    product['custom_option'].removeWhere((item) =>
        item['custom_option_id'].toString() == custom_option_id.toString());
    saveCardData();
  }

  void updateProduct(productData) {
    int key = my_order.indexWhere((element) =>
        element['product_id'] == productData.id && element['customize'] == 0);
    my_order[key]['qty'] == my_order[key]['qty']++;
    // double view_price = double.parse(my_order[key]['view_price']) +
    //     double.parse(my_order[key]['price']);
    // my_order[key]['view_price'] = view_price.toString();
    changePrice(selected_method: 'inc_product', product_index: key);
  }

  void decrement({required int index}) {
    if (my_order[index]['qty'] > 1) {
      my_order[index]['qty'] == my_order[index]['qty']--;
      changePrice(selected_method: 'dec_product', product_index: index);
      saveCardData();
    }
  }

  void increment({required int index}) {
    my_order[index]['qty'] == my_order[index]['qty']++;
    changePrice(selected_method: 'inc_product', product_index: index);
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
          double.parse(product['view_price']) + double.parse(price!);
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

  void deleteItem({required int index}) {
    // int key = my_order.indexWhere((element) => element['name'] == productName);
    // prices.value = prices.value -
    //     (double.parse(my_order[key]['price']) * my_order[key]['qty']);
    changePrice(selected_method: 'del_product', product_index: index);
    my_order.removeAt(index);
    saveCardData();
  }
  // void deleteItem(productName) {
  //   int key = my_order.indexWhere((element) => element['name'] == productName);
  //   prices.value = prices.value -
  //       (double.parse(my_order[key]['price']) * my_order[key]['qty']);
  //   my_order.removeAt(key);
  //   saveCardData();
  // }

  void clearItem() {
    my_order.value = [];
    prices.value = 0.0;
    tables.clear();
    saveCardData();
  }

  Future<void> bookOrder({
    required dynamic restaurant_id,
    required dynamic room_no,
    required int table,
    required List products,
    required BuildContext context,
  }) async {
    // showLoading();
    try {
      // print(prices.value);
      var response = await ApiYourCard.bookOrder(
        restaurant_id: restaurant_id,
        room_no: room_no,
        table: table,
        total_price: prices.value,
        products: my_order,
      );
      clearItem();
      // hideLoading();

      Get.snackbar(
        'Message',
        'order Added Successfully',
        // snackPosition: SnackPosition.TOP,
        // backgroundColor: Colors.green,
        // colorText: Colors.white,
      );
      // String redirect_code = my_order[0]['res_code'];

      // Get.to(CategoriesScreen(
      //   hotel: hotelsController.hotels[hotelsController.selectHotel.value],
      //   restaurant: restaurantController.restaurant[restaurant_index],
      // ));
    } catch (_) {
      Get.snackbar(
        'Message',
        'Something Wrong happened',
        // snackPosition: SnackPosition.TOP,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
      );
    }
  }

  Future<void> restaurant_table({required int restaurant_id}) async {
    var response =
        await ApiYourCard.getRestaurantTable(restaurant_id: restaurant_id);

    var tableResponse = TablesResponse.fromJson(response.data);

    tables.clear();

    tables.addAll(tableResponse.tables);
  }

  Future<void> product_custom({required String product_id}) async {
    custom_loaded.value = false;
    var response = await ApiYourCard.product_custom(product_id: product_id);
    var productResponse = ProductCustomOptionResponse.fromJson(response.data);

    custom_option.clear();

    custom_option.addAll(productResponse.custom_option);
    custom_loaded.value = true;
  }
}
