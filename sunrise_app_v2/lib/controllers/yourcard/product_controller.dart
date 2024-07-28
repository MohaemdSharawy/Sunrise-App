import 'package:get/get.dart';
import 'package:sunrise_app_v2/controllers/yourcard/category_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/product_model.dart';
import 'package:sunrise_app_v2/response/yourcard/product_response.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class ProductController extends GetxController {
  final categoryController = Get.put(CategoryController());

  var product = <Product>[].obs;
  var loaded = false.obs;

  Future<void> get_products({required int category_id}) async {
    loaded.value = false;

    var response = await ApiYourCard.getProduct(
      category_id: category_id,
    );
    product.clear();
    var productResponse = ProductResponse.fromJson(response.data);
    product.addAll(productResponse.product);
  }
}
