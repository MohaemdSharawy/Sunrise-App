import 'package:tucana/model/ResturanModel.dart';
import 'package:tucana/model/categories_model.dart';
import 'package:tucana/model/category_type_model.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/model/meal_model.dart';
import 'package:tucana/response/Resturan_response.dart';
import 'package:tucana/response/categories_response.dart';
import 'package:tucana/response/category_type_response.dart';
import 'package:tucana/response/hotel_response.dart';
import 'package:tucana/response/meal_response.dart';
import 'package:tucana/services/api.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var categories = <Categories>[].obs;
  var restaurant = <Restaurant>[].obs;
  var category_type = <CategoryType>[].obs;
  var hotel = <Hotels>[].obs;
  var isloaded = false.obs;
  var meal = <Meal>[].obs;
  var meal_loaded = false.obs;
  var meal_category = <Categories>[].obs;
  var meal_category_loaded = false.obs;
  var categories_item_load = true.obs;
  var selectedTile_meal = -1.obs;

  Future<void> guestCategories(
      {required String restaurant_code, String? type}) async {
    var response = await Api.restaurantCategories(
        restaurant_code: restaurant_code, type: type);
    var categoriesResponse = CategoriesResponse.fromJson(response.data);

    // print(response);
    var restaurantResponse = RestaurantCategory.fromJson(response.data);
    var hotelResponse = HotelResponse.fromJson(response.data);

    hotel.clear();
    restaurant.clear();
    categories.clear();

    restaurant.addAll(restaurantResponse.restaurant);
    categories.addAll(categoriesResponse.categories);
    hotel.addAll(hotelResponse.hotel);

    guestCategoriesType(restaurant_code: restaurant_code);
  }

  Future<void> guestCategoriesType({required String restaurant_code}) async {
    var response =
        await Api.getDiningCategoryType(restaurant_code: restaurant_code);
    var categoryTypeResponse = CategoryTypeResponse.fromJson(response.data);

    category_type.clear();

    category_type.addAll(categoryTypeResponse.categoryType);

    isloaded.value = true;
  }

  Future<void> getMails({required String restaurant_code}) async {
    var response = await Api.get_meal(restaurant_code: restaurant_code);

    var mealResponse = MealResponse.fromJson(response.data);

    meal.clear();

    meal.addAll(mealResponse.meal);

    meal_loaded.value = true;
  }

  Future<void> mealCategory({
    required String restaurant_code,
    required String type_id,
    required String meal_id,
    required String day,
  }) async {
    var response = await Api.meal_category(
      restaurant_code: restaurant_code,
      type_id: type_id,
      meal_id: meal_id,
      day: day,
    );

    var categoryResponse = CategoriesResponse.fromJson(response.data);

    meal_category.clear();

    meal_category.addAll(categoryResponse.categories);

    meal_category_loaded.value = true;
  }
}
