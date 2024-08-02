class WorkingDay {
  late String id;

  late String restaurant_id;

  late String day;

  late String work;

  late String from_time;

  late String to_time;

  late String day_number;

  late String timestamp;

  late int availability;

  WorkingDay.fromJson(json) {
    id = json['id'];

    day = (json['day'] != null) ? json['day'] : '';

    work = (json['work'] != null) ? json['work'] : '';

    from_time = (json['from_time'] != null) ? json['from_time'] : '';

    to_time = (json['to_time'] != null) ? json['to_time'] : '';

    day_number = (json['day_number'] != null) ? json['day_number'] : '';

    timestamp = (json['timestamp'] != null) ? json['timestamp'] : '';

    availability = (json['availability'] != null) ? json['availability'] : 0;
  }
}

class BookingMeals{
  late String id;

  late String meal_id;

  late String main_category_name;

  BookingMeals.fromJson(json){

    id =  json['id'];

    meal_id = json['meal_id'];

    main_category_name = json['main_category_name'] ?? '--';

  }

}


