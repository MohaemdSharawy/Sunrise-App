import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/meal_model.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/models/yourcard/workingDaysModel.dart';
import 'package:sunrise_app_v2/response/yourcard/meal_response.dart';
import 'package:sunrise_app_v2/response/yourcard/restaurant_response.dart';
import 'package:sunrise_app_v2/response/yourcard/workingDaysResponse.dart';
import 'package:sunrise_app_v2/services/yourcart.dart';

class WorkingDayController extends GetxController {
  var workingDay = <WorkingDay>[].obs;
  var isLoaded = false.obs;
  var allow_dates = <String>[].obs;
  final restaurantController = Get.put(RestaurantController());

  Future<void> getWorkingDays({required int restaurant_id}) async {
    var response = await ApiYourCard.workingDay(restaurant_id: restaurant_id);

    var workingDayResponse = WorkingDayResponse.fromJson(response.data);

    workingDay.clear();

    workingDay.addAll(workingDayResponse.workingDay);
    setAllowDates();
    isLoaded.value = true;
  }

  void setAllowDates() {
    List open_days = [];
    late String from;
    for (var element in workingDay) {
      if (!open_days.contains(element.day)) {
        open_days.add(element.day.toLowerCase());
      }
    }
    if (restaurantController.restaurant.value.book_today == "1") {
      from = DateTime.now().toString().split(' ')[0];
    } else {
      from = DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
    }
    print(from);
    getDates(
      from,
      '2024-09-01',
      // GetStorage().read('departure'),
      open_days,
    );

    print(allow_dates);
  }

  void getDates(String fromDate, String toDate, List openDays) {
    var from = DateTime.parse(fromDate);
    var to = DateTime.parse(toDate);
    var list = <String>[];

    for (int i = 0; i <= to.difference(from).inDays; i++) {
      var date = from.add(Duration(days: i));
      var weekday = DateFormat('EEEE').format(date).toLowerCase();

      if (openDays.contains(weekday)) {
        list.add(DateFormat('yyyy-MM-dd').format(date));
      }
    }

    allow_dates.value = list;
  }
  // getDates(
  //     from,
  //     // '2023-12-01',
  //     GetStorage().read('departure'),
  //     open_days,
  //   );
}
