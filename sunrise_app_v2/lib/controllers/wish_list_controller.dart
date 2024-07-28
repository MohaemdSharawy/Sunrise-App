import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/wish_list_model.dart';
import 'package:sunrise_app_v2/response/wish_list_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class WishListController extends GetxController {
  var wishList = <WishListModel>[].obs;

  var wishListLoaded = false.obs;

  Future<void> get_wish_list({String? type}) async {
    wishListLoaded.value = false;
    var response = await Api.get_wish_list(type: type);
    var wishListResponse = WishListResponse.fromJson(response.data);
    wishList.clear();
    wishList.addAll(wishListResponse.wishList);
    wishListLoaded.value = true;
  }

  Future<void> remove_wish_list({required int wish_id}) async {
    try {
      var response = await Api.remove_wish_list(wish_id: wish_id);
      Get.snackbar('Message', 'Add To Wish List Successfully');
    } on DioException catch (e) {}
  }

  Future<void> add_wish_list({
    required String wish_code,
    required String type,
  }) async {
    try {
      var response = await Api.add_wish_list(
          data: {'wished_code': wish_code, 'type': type});
      Get.snackbar('Message', 'Add To Wish List Successfully');
    } on DioException catch (e) {}
  }

  bool isCodeInWishList(String codeToCheck) {
    for (var item in wishList) {
      if (item.code == codeToCheck) {
        return true;
      }
    }
    return false;
  }
}
