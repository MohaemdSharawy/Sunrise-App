import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/screens/maintainace.dart';

import '../../../controller/Resturan_Controller.dart';
import '../../../controller/card_controller.dart';
import '../../../controller/hotel_controller.dart';
import '../../../utilites/appbar.dart';
import '../../../utilites/img.dart';
import '../../../utilites/loading.dart';

class BarScreen extends StatefulWidget {
  var hotel_id;
  BarScreen({this.hotel_id, super.key});

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> with BaseController {
  final restaurantController = Get.put(RestaurantController());
  final cardController = Get.put(CardController());
  final hotelsController = Get.put(HotelsController());

  _getData() async {
    await hotelsController.getBackGround(search_key: widget.hotel_id);
    restaurantController.barsLoaded.value = false;
    await restaurantController.getBars(hotel_id: widget.hotel_id);
    hotelAuth(widget.hotel_id, context);
    npsQuestion(context);
  }

  void redirectToMyRestaurant() {
    // int restaurant_index = restaurantController.restaurant
    //     .indexWhere((e) => e.code == cardController.my_order[0]['res_code']);
    // Get.to(CategoriesScreen(
    //   hotel: hotelsController.hotels[hotelsController.selectHotel.value],
    //   restaurant: restaurantController.restaurant[restaurant_index],
    // ));
  }

  orderCheck(index) {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            dialogBackgroundColor: Colors.black,
            body: Center(
              child: Text(
                'You Already Have Orders in an other Bar Clear Your Orders!',
                style: TextStyle(color: Colors.white),
              ),
            ),
            btnCancelOnPress: () {
              cardController.clearItem();
              // Get.to(CategoriesScreen(
              //   hotel: widget.hotel,
              //   restaurant: restaurantController.restaurant[index],
              // ));
            },
            btnOkOnPress: () {
              redirectToMyRestaurant();
            },
            btnCancelText: 'Clear',
            btnOkText: 'GO To My Bar')
        .show();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (restaurantController.barsLoaded.value == true)
            ? mainBody()
            : LoadingScreen(img_name: 'lucian.jpg');
      }),
      // bottomNavigationBar: CustomBottomBar(
      //   h_id: widget.hotel_id,
      // ),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelsController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                AppBarWidget(
                  h_id: widget.hotel_id,
                ),
                SizedBox(height: 20),
                // SizedBox(
                //     height: 200,
                //     width: 750,
                //     child: Container(
                //         padding: EdgeInsets.all(20),
                //         child: dishOFDay(restaurantController.bars))),
                SizedBox(
                  width: 750,
                  height: 550.0 * (restaurantController.bars.length / 2),
                  child: restaurantItem(),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        // restaurantItem(),
      ],
    );
  }

  Widget restaurantItem() {
    return Container(
      // margin: EdgeInsets.only(top: 100),
      padding: const EdgeInsets.only(left: 11, right: 11, top: 0),
      child: GridView.builder(
        itemCount: restaurantController.bars.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                if (GetStorage().read('room_num') != '' &&
                    GetStorage().read('room_num') != null) {
                  if (cardController.my_order.length > 0) {
                    if (cardController.my_order[0]['res_code'] ==
                        restaurantController.bars[index].code) {
                      // Get.to(CategoriesScreen(
                      //   hotel: hotelsController
                      //       .hotels[hotelsController.selectHotel.value],
                      //   restaurant: restaurantController.restaurant[index],
                      // ));
                      Navigator.pushNamed(context,
                          '/categories/${restaurantController.bars[index].code}');
                    } else {
                      orderCheck(index);
                    }
                  } else {
                    // Get.to(CategoriesScreen(
                    //   hotel: hotelsController
                    //       .hotels[hotelsController.selectHotel.value],
                    //   restaurant: restaurantController.restaurant[index],
                    // ));
                    Navigator.pushNamed(context,
                        '/categories/${restaurantController.bars[index].code}');
                  }
                } else {
                  login_dialog(context, widget.hotel_id);
                }
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Text('test', style: TextStyle(fontSize: 19)),
                    (restaurantController.bars[index].white_logo != '')
                        ? Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.bars[index].white_logo}',
                            // 'assets/restaurant/${restaurantController.restaurant[index].logo}',
                            width: 200,
                            height: 100,
                          )
                        : Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.bars[index].logo}',
                            // 'assets/restaurant/${restaurantController.restaurant[index].logo}',
                            width: 200,
                            height: 100,
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    // Expanded(
                    //   child: Text(
                    //       restaurantController.bars[index].restaurant_name +
                    //           restaurantController.bars[index].code,
                    //       style: TextStyle(fontSize: 15, color: Colors.white)),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dishOFDay(restaurant) {
    return Swiper(
      itemCount: restaurant.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (() {
            if (restaurant[index].dish_day == '' ||
                restaurant[index].dish_day == '0') {
              Get.snackbar(
                'Message',
                // '${error}',
                'Today there is No Dish Of Day For ${restaurant[index].restaurant_name}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } else {
              Navigator.pushNamed(context,
                  '/dinning-product-details/${restaurant[index].dish_day}');
            }
          }),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Color.fromARGB(255, 190, 146, 109),
            child: Container(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Dish Of Day In ${restaurant[index].restaurant_name}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: (restaurant[index].dish_day_img == '')
                        ? Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurant[index].logo}',
                            fit: BoxFit.fill,
                            width: 150,
                            height: 150,
                          )
                        : Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/products/${restaurant[index].dish_day_img}',
                            fit: BoxFit.fill,
                            width: 150,
                            height: 150,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
        // return Image.network(
        //   'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurant[index].logo}',
        //   fit: BoxFit.fill,
        // );
      },
      viewportFraction: 0.8,
      scale: 0.9,
    );
  }
}
