import 'dart:convert';
import 'package:tucana/model/ResturanModel.dart';
import 'package:tucana/model/categories_model.dart';
import 'package:tucana/model/product_model.dart';
import 'package:tucana/response/Resturan_response.dart';
import 'package:tucana/response/categories_response.dart';
import 'package:tucana/response/product_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/api.dart';

class ProductController extends GetxController {
  var isLoaded = false.obs;
  var product = <Product>[].obs;
  var single_product = <Product>[].obs;
  var restaurant = <Restaurant>[].obs;
  var category = <Categories>[].obs;
  var currentIndex = 0.obs;
  var singleProductLoaded = false.obs;

  var categoryScreenHight = 0.0.obs;

  Future<void> getProduct({required int category_id}) async {
    var response = await Api.getProduct(category_id: category_id);

    var productResponse = ProductResponse.fromJson(response.data);

    var restaurantResponse = RestaurantCategory.fromJson(response.data);

    var categoryResponse = CategoryResponse.fromJson(response.data);

    product.clear();

    category.clear();

    restaurant.clear();

    product.addAll(productResponse.product);

    restaurant.addAll(restaurantResponse.restaurant);

    category.addAll(categoryResponse.category);

    currentIndex.value = 0;
    isLoaded.value = true;
    // print(lo)
  }

  Future<void> getSingleProduct({required int product_id}) async {
    var response = await Api.get_single_product(product_id: product_id);

    var productResponse = SingleProductResponse.fromJson(response.data);

    var restaurantResponse = RestaurantCategory.fromJson(response.data);

    single_product.clear();

    restaurant.clear();

    restaurant.addAll(restaurantResponse.restaurant);

    single_product.addAll(productResponse.product);

    singleProductLoaded.value = true;
  }

  Future<void> meal_product({
    required String category_id,
    required String meal_id,
    required String day,
  }) async {
    isLoaded.value = false;
    var response = await Api.meal_product(
      category_id: category_id,
      meal_id: meal_id,
      day: day,
    );

    var productResponse = ProductResponse.fromJson(response.data);

    var restaurantResponse = RestaurantCategory.fromJson(response.data);

    var categoryResponse = CategoryResponse.fromJson(response.data);

    product.clear();

    category.clear();

    restaurant.clear();

    product.addAll(productResponse.product);

    restaurant.addAll(restaurantResponse.restaurant);

    category.addAll(categoryResponse.category);

    currentIndex.value = 0;
    isLoaded.value = true;
  }
}
