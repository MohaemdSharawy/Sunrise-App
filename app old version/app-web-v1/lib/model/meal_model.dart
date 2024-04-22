class Meal {
  late String id;

  late String restaurant_id;

  late String main_category_name;

  late String start;

  late String end;

  Meal.fromJson(json) {
    id = json['id'];
    restaurant_id =
        (json['restaurant_id'] != null) ? json['restaurant_id'] : '';
    main_category_name =
        (json['main_category_name'] != null) ? json['main_category_name'] : '';
    start = (json['start'] != null) ? json['start'] : '';
    end = (json['end'] != null) ? json['end'] : '';
  }
}
