import 'dart:convert';

import 'package:tucana/model/workingDaysModel.dart';

class WorkingDayResponse {
  List<WorkingDay> workingDay = [];

  WorkingDayResponse.fromJson(json) {
    // final data_type = jsonDecode(json);
    // print(json['restaurants']);
    json['working']
        .forEach((data) => workingDay.add(WorkingDay.fromJson(data)));
  }
}

class SingleWorkingDayResponse {
  List<WorkingDay> workingDay = [];

  SingleWorkingDayResponse.fromJson(json) {
    // final data_type = jsonDecode(json);
    // print(json['restaurants']);
    json['working']
        .forEach((data) => workingDay.add(WorkingDay.fromJson(data)));
  }
}



class BookingMealResponse{
  List<BookingMeals> booking_meals = [];
  BookingMealResponse.fromJson(json) {
    json['meals']
        .forEach((data) => booking_meals.add(BookingMeals.fromJson(data)));
  }

}

