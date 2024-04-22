import 'package:tucana/model/meal_model.dart';

class MealResponse {
  List<Meal> meal = [];

  MealResponse.fromJson(json) {
    json['types'].forEach((data) => meal.add(Meal.fromJson(data)));
  }
}
