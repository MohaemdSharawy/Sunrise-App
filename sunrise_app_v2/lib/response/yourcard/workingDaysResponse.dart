import 'dart:convert';

import 'package:sunrise_app_v2/models/yourcard/workingDaysModel.dart';

class WorkingDayResponse {
  List<WorkingDay> workingDay = [];

  WorkingDayResponse.fromJson(json) {
    json['working']
        .forEach((data) => workingDay.add(WorkingDay.fromJson(data)));
  }
}

class SingleWorkingDayResponse {
  List<WorkingDay> workingDay = [];
  SingleWorkingDayResponse.fromJson(json) {
    json['working']
        .forEach((data) => workingDay.add(WorkingDay.fromJson(data)));
  }
}

class BookingMealResponse {
  List<BookingMeals> booking_meals = [];
  BookingMealResponse.fromJson(json) {
    json['meals']
        .forEach((data) => booking_meals.add(BookingMeals.fromJson(data)));
  }
}
