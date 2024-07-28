import 'package:get/get.dart';
import 'package:sunrise_app_v2/models/brand_model.dart';
import 'package:sunrise_app_v2/models/hotel_model.dart';
import 'package:sunrise_app_v2/response/brands_reposne.dart';
import 'package:sunrise_app_v2/response/hotel_response.dart';
import 'package:sunrise_app_v2/services/api.dart';

class BrandsController extends GetxController {
  var brand_loaded = false.obs;
  var brand = <Brands>[].obs;
  var hotel_brand = <Hotels>[].obs;
  var hotel_brand_loaded = false.obs;

  Future<void> getBrands() async {
    brand_loaded.value = false;
    var response = await Api.brands();
    brand.clear();
    var brandsResponse = BrandsResponse.fromJson(response.data);
    brand.addAll(brandsResponse.brands);
    brand_loaded.value = true;
  }

  Future<void> hotelsBrand({required int brand_id}) async {
    hotel_brand_loaded.value = false;
    var response = await Api.hotel_brand(brand_id: brand_id);
    hotel_brand.clear();
    var hotelBrandsResponse = HotelsResponse.fromJson(response.data);
    hotel_brand.addAll(hotelBrandsResponse.hotels);
    hotel_brand_loaded.value = true;
  }

  Future<void> viewAllBrandHotels() async {
    hotel_brand_loaded.value = false;
    var response = await Api.hotel_list();
    hotel_brand.clear();
    var hotelBrandsResponse = HotelsResponse.fromJson(response.data);
    hotel_brand.addAll(hotelBrandsResponse.hotels);
    hotel_brand_loaded.value = true;
  }
}
