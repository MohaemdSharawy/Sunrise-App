import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/model/hotel_model.dart';
import 'package:tucana/screens/chat_screen.dart';
import 'package:tucana/screens/dining_screen.dart';
import 'package:tucana/screens/main_screen.dart';
import 'package:tucana/screens/pages/dining/restaurant_screen.dart';
import 'package:tucana/screens/rating_screen.dart';
import 'package:tucana/screens/room_screen.dart';
import 'package:tucana/screens/weather_screen.dart';
import 'package:tucana/screens/wellness_screen.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var hotel = <Hotels>[].obs;
  var setHotel = false.obs;
  var h_id = 0.obs;
  var hide_bottom = false.obs;
  // final hotelController =  Get.put(HotelsController());
  // @override
  // void onInit() async {

  //  await hotelController.getHotel(hid: GetStorage().read('h_id'));
  //  if(hotelController.hotel.value.out_side == "1"){

  //  }
  //   super.onInit();
  // }

  var screens = [
    MainScreen(),
    WeatherScreen(),
    // RoomScreen(),
    // DiningScreen(),
    RestaurantScreen(),
    WellnessScreen(),
    // ChatScreen()
    RatingScreen(),
    MainScreen(),
  ];

  var cover = [
    'home_cover.jpg',
    'roomCover.png',
    'dining.jpg',
    'wellness.jpg',
    'home_cover.jpg',
    'home_cover.jpg',
    'home_cover.jpg',
  ];

  var links = ['home', '', 'dining', 'wellness', 'ticket'];

  var guest_links = ['home', 'dining', 'wellness'];

  // var imgCover = [
  //   '',
  //   '',
  //   '',
  //   '',
  // ];
}
