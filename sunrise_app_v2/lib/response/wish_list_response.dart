import 'package:sunrise_app_v2/models/wish_list_model.dart';

class WishListResponse {
  List<WishListModel> wishList = [];
  WishListResponse.fromJson(json) {
    json['data'].forEach((data) => wishList.add(WishListModel.fromJson(data)));
  }
}
