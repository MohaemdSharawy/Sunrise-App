import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/interface_controller.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingRestaurantList extends StatefulWidget {
  var hotel_id;
  BookingRestaurantList({this.hotel_id, super.key});

  @override
  State<BookingRestaurantList> createState() => _BookingRestaurantListState();
}

class _BookingRestaurantListState extends State<BookingRestaurantList>
    with BaseController {
  final restaurantController = Get.put(RestaurantController());
  final hotelsController = Get.put(HotelsController());
  final interfaceController = Get.put(InterfaceController());

  @override
  _getData() async {
    await restaurantController.getRestaurantBooking(hotel_id: widget.hotel_id);
    print('-----------');
    print(restaurantController.restaurant.length);
    hotelAuth(widget.hotel_id, context);
    npsQuestion(context);
    _getInterface();
  }

  _getInterface() async {
    await interfaceController.getInterface(
      hotel_id: widget.hotel_id,
      interfaceType: 'RSR',
    );
    if (restaurantController.restaurant.isEmpty) {
      getLink('RSR');
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelsController.getBackGround(search_key: widget.hotel_id);
      restaurantController.isLoaded.value = false;
      _getData();
      print('hereeeee');
    });
    super.initState();
  }

  getLink(type) async {
    showLoading();
    _launchUrl();
    hideLoading();
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(interfaceController.interfaceVal.value))) {
      await launchUrl(Uri.parse(interfaceController.interfaceVal.value),
          mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Message',
        // '${error}',
        'Sorry This Not Available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (restaurantController.isLoaded.value == true)
            ? mainBody()
            : Center(
                child: CircularProgressIndicator(),
              );
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
                if (interfaceController.interfaceVal.value != null &&
                    interfaceController.interfaceVal.value != '') ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.6)),
                    child: Text(tr('Book Now')),
                    onPressed: () {
                      getLink('RSR');
                    },
                  ),
                ],
                SizedBox(height: 20),

                // SizedBox(
                //     height: 200,
                //     width: 750,
                //     child: Container(
                //         padding: EdgeInsets.all(20),
                //         child: dishOFDay(restaurantController.restaurant))),
                SizedBox(
                  width: 750,
                  height: 550.0 * (restaurantController.restaurant.length / 2),
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
        itemCount: restaurantController.restaurant.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
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
                  Navigator.pushNamed(context,
                      '/book-restaurant/${restaurantController.restaurant[index].code}');
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
                    (restaurantController.restaurant[index].white_logo != '')
                        ? Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.restaurant[index].white_logo}',
                            // 'assets/restaurant/${restaurantController.restaurant[index].logo}',
                            width: 200,
                            height: 100,
                          )
                        : Image.network(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${restaurantController.restaurant[index].logo}',
                            // 'assets/restaurant/${restaurantController.restaurant[index].logo}',
                            width: 200,
                            height: 100,
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    // Expanded(
                    //   child: Text(
                    //       restaurantController
                    //               .restaurant[index].restaurant_name +
                    //           restaurantController.restaurant[index].code,
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
}
