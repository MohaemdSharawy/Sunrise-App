import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/model/spa_model.dart';
import 'package:tucana/response/spa_response.dart';

import '../../services/api.dart';

class SpaController extends GetxController {
  var isLoaded = false.obs;
  var spaCategories = <SpaCategories>[].obs;
  var spaCategoriesLoaded = false.obs;
  var spaProduct = <SpaProduct>[].obs;
  var spaSingleProduct = <SpaProduct>[].obs;
  var activity = <Spa>[].obs;
  var spaProductLoaded = false.obs;
  var singleActivityProductLoaded = false.obs;

  Future<void> getSpaCategories({required String spa_code}) async {
    var response = await Api.get_activity_categories(spa_code: spa_code);

    var spaCategoriesResponse = SpaCategoriesResponse.fromJson(response.data);

    spaCategories.clear();

    spaCategories.addAll(spaCategoriesResponse.spa_categories);

    spaCategoriesLoaded.value = true;
  }

  Future<void> getSpaProduct({required int category_id}) async {
    var response =
        await Api.get_activity_category_products(category_id: category_id);

    var spaProductResponse = SpaProductResponse.fromJson(response.data);

    var spaActivityResponse = SingleSpaResponse.fromJson(response.data);

    activity.clear();

    spaProduct.clear();

    spaProduct.addAll(spaProductResponse.spa_product);

    activity.addAll(spaActivityResponse.spa);

    spaProductLoaded.value = true;
  }

  Future<void> getSingleProduct({required int product_id}) async {
    var response =
        await Api.get_activity_category_product(product_id: product_id);

    var spaProductResponse = SingleSpaProductResponse.fromJson(response.data);

    var spaActivityResponse = SingleSpaResponse.fromJson(response.data);

    activity.clear();

    spaSingleProduct.clear();

    spaSingleProduct.addAll(spaProductResponse.spa_product);

    activity.addAll(spaActivityResponse.spa);
    singleActivityProductLoaded.value = true;
  }
}
