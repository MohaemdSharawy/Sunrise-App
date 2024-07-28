import 'dart:convert';

import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/yourcard/category_model.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/response/yourcard/category_response.dart';
import 'package:sunrise_app_v2/response/yourcard/restaurant_response.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class CategoryController extends GetxController {
  var categories = <Categories>[].obs;
  var restaurant = Restaurant().obs;
  var category_type = <CategoriesTypes>[].obs;
  var loaded = false.obs;
  var type_loaded = true.obs;
  var type_has_category = true.obs;

  Future<void> get_categories({required String code, String? type}) async {
    loaded.value = false;
    var response = await ApiYourCard.restaurantCategories(
        restaurant_code: code, type: type);
    categories.clear();
    var categoryResponse = CategoriesResponse.fromJson(response.data);
    categories.addAll(categoryResponse.categories);
    loaded.value = true;
  }

  Future<void> get_categories_with_product({
    required String code,
    String? type,
  }) async {
    loaded.value = false;

    var response = await ApiYourCard.get_categories_with_product(
      restaurant_code: code,
      type: type,
    );
    categories.clear();
    var categoryResponse = CategoriesResponse.fromJson(response.data);
    categories.addAll(categoryResponse.categories);
    restaurant.value = Restaurant.fromJson(response.data['restaurant']);

    loaded.value = true;
  }

  Future<void> get_categories_type({required String code}) async {
    type_loaded.value = false;
    try {
      var response = await ApiYourCard.restaurantCategoriesTypes(
        restaurant_code: code,
      );
      category_type.clear();
      var categoriesTypeResponse =
          CategoriesTypesResponse.fromJson(response.data);
      category_type.addAll(categoriesTypeResponse.categoriesTypesResponse);
    } catch (e) {}
    type_loaded.value = true;
  }

  Future<void> check_category_type_count({
    required String code,
    required String type,
  }) async {
    loaded.value = false;
    var response = await ApiYourCard.restaurantCategories(
        restaurant_code: code, type: type);
    var categoryTypeResponse = CategoriesResponse.fromJson(response.data);
    if (categoryTypeResponse.categories.length > 0) {
      type_has_category.value = true;
    } else {
      type_has_category.value = false;
    }
  }
}
