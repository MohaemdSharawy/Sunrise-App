import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/categories_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/product_controller.dart';
import 'package:tucana/screens/pages/dining/bar_screen.dart';
import 'package:tucana/screens/pages/dining/booking_screen.dart';
import 'package:tucana/screens/pages/dining/meal_screen.dart';
import 'package:tucana/screens/pages/dining/restaurant_screen.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/categoryList.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/navigationButtom.dart';
import 'package:recase/recase.dart';

class RestaurantCategoryByType extends StatefulWidget {
  var restaurant_code;
  var type_id;
  RestaurantCategoryByType({this.restaurant_code, this.type_id, super.key});

  @override
  State<RestaurantCategoryByType> createState() =>
      RestaurantCategoryByTypeState();
}

class RestaurantCategoryByTypeState extends State<RestaurantCategoryByType>
    with BaseController, SingleTickerProviderStateMixin {
  final categoriesController = Get.put(CategoriesController());
  final hotelController = Get.put(HotelsController());
  final productController = Get.put(ProductController());
  TabController? _tabController;

  String updateName(str) {
    ReCase rc = ReCase(str);
    print(rc.constantCase);
    return rc.constantCase.toString();
  }

  String allWordsCapitilize(str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  int tab_count = 1;
  List meal_ids = [];
  final List<DropdownMenuItem> list = [
    DropdownMenuItem(value: "Monday", child: Text("Monday")),
    DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
    DropdownMenuItem(value: "Wednesday", child: Text("Wednesday")),
    DropdownMenuItem(value: "Thursday", child: Text("Thursday")),
    DropdownMenuItem(value: "Friday", child: Text("Friday")),
    DropdownMenuItem(value: "Saturday", child: Text("Saturday")),
    DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
  ];

  String? day_selected;
  int today_id() {
    final today = DateTime.now();
    return today.weekday;
  }

  String today_name() {
    var date = DateTime.now();
    return DateFormat('EEEE').format(date);
  }

  _getData() async {
    day_selected = today_name();
    await categoriesController.getMails(
        restaurant_code: widget.restaurant_code);

    for (var element in categoriesController.meal) {
      if (await check_meal_length(element.id)) {
        Map meal = {'id': element.id, 'meal': element.main_category_name};
        meal_ids.add(meal);
      }
    }

    _tabController = TabController(length: meal_ids.length + 1, vsync: this);
    await hotelController.getBackGround(
      search_key: widget.restaurant_code,
      api_type: 'restaurant_code',
    );
    await categoriesController.guestCategories(
        restaurant_code: widget.restaurant_code, type: widget.type_id);
    productController.categoryScreenHight.value =
        categoriesController.categories.length * 85.0;
    hotelAuth(categoriesController.hotel[0].id, context);

    // print(categoriesController.restaurant[0].hid);
  }

  check_meal_length(meal_id) async {
    var data = await categoriesController.mealCategory(
      restaurant_code: widget.restaurant_code,
      type_id: widget.type_id,
      meal_id: meal_id,
      day: today_name(),
    );
    if (categoriesController.meal_category.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  view_alert({required String message}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      dialogBackgroundColor: Colors.black,
      body: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: tr('cancel'),
    ).show();
  }

  bool active_alert_category = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoriesController.isloaded.value = false;
      _getData();
      int current_category_type_index = categoriesController.category_type
          .indexWhere((e) => e.id.toString() == widget.type_id.toString());

      if (categoriesController
              .category_type[current_category_type_index].active_alert ==
          '1') {
        active_alert_category = false;
        view_alert(
            message: categoriesController
                .category_type[current_category_type_index].description);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (categoriesController.isloaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    const select_Text = TextStyle(color: Colors.white, fontSize: 15);

    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].dining_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        Center(
          child: SizedBox(
            width: 750,
            child: Container(
              child: Column(
                children: [
                  AppBarWidget(
                    h_id: categoriesController.restaurant[0].hid,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  (categoriesController.restaurant[0].white_logo != '')
                      ? Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].white_logo}',
                          height: 80,
                        )
                      : Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].logo}',
                          height: 80,
                        ),
                  if (categoriesController.hotel[0].out_side != "1") ...[
                    Container(
                      padding: EdgeInsets.only(top: 8, bottom: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0.6)),
                        child: Text('Info').tr(),
                        onPressed: () {
                          Navigator.pushNamed(context,
                              '/restaurant_info/${widget.restaurant_code}');
                        },
                      ),
                    ),
                  ],
                  (GetStorage().read('room_num') != '')
                      ? (categoriesController.restaurant[0].ordering == "1")
                          ? Container(
                              padding: EdgeInsets.only(top: 8, bottom: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white.withOpacity(0.6)),
                                child: Text('Book Now').tr(),
                                onPressed: () {
                                  // Get.to(BookingScreen(
                                  //   hotel: widget.hotel,
                                  //   restaurant: widget.restaurant,
                                  // ));
                                  Navigator.pushNamed(context,
                                      '/book-restaurant/${widget.restaurant_code}');
                                },
                              ),
                            )
                          : Container()
                      : Container(),
                  if (meal_ids.length > 0) ...[
                    DropdownButton<dynamic>(
                      dropdownColor: Colors.black,
                      style: select_Text,
                      value: day_selected,
                      items: list,
                      onChanged: (newValue) {
                        setState(() async {
                          day_selected = newValue;
                        });
                        if (_tabController?.index != null) {
                          if (_tabController!.index > 0) {
                            categoriesController.meal_category_loaded.value =
                                false;
                            categoriesController.selectedTile_meal = -1;
                            categoriesController.mealCategory(
                              restaurant_code: widget.restaurant_code,
                              type_id: widget.type_id.toString(),
                              meal_id: meal_ids[_tabController!.index - 1]
                                  ['id'],
                              day: day_selected.toString(),
                            );
                          }
                        }
                      },
                    ),
                  ],
                  TabBar(
                    isScrollable: true,
                    indicatorWeight: 2,
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Order Now',
                      ),
                      for (var i = 0; i < meal_ids.length; i++)
                        Tab(
                          text: meal_ids[i]['meal'],
                        )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SizedBox(
                          // width: 750,
                          // height: productController.categoryScreenHight.value,
                          child: CategoryList(
                            categories: categoriesController.categories,
                            restaurant: categoriesController.restaurant,
                            active_alert: active_alert_category,
                          ),
                        ),
                        for (var i = 0; i < meal_ids.length; i++)
                          MealScreen(
                            restaurant_code: widget.restaurant_code,
                            meal_id: meal_ids[i]['id'],
                            type_id: widget.type_id.toString(),
                            day_name: day_selected.toString(),
                          )
                        // Text(
                        //   'x ${i}',
                        //   style: TextStyle(color: Colors.white, fontSize: 25),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),

        // SingleChildScrollView(
        //   child: Container(
        //     child: Column(
        //       children: [
        //         AppBarWidget(
        //           h_id: categoriesController.restaurant[0].hid,
        //         ),
        //         SizedBox(
        //           height: 40,
        //         ),
        //         (categoriesController.restaurant[0].white_logo != '')
        //             ? Image.network(
        //                 'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].white_logo}',
        //                 height: 150,
        //               )
        //             : Image.network(
        //                 'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].logo}',
        //                 height: 150,
        //               ),
        //         Container(
        //           padding: EdgeInsets.only(top: 8, bottom: 15),
        //           child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //                 primary: Colors.white.withOpacity(0.6)),
        //             child: Text('Info').tr(),
        //             onPressed: () {
        //               Navigator.pushNamed(context,
        //                   '/restaurant_info/${widget.restaurant_code}');
        //             },
        //           ),
        //         ),
        //         (GetStorage().read('room_num') != '')
        //             ? (categoriesController.restaurant[0].ordering == "1")
        //                 ? Container(
        //                     padding: EdgeInsets.only(top: 8, bottom: 15),
        //                     child: ElevatedButton(
        //                       style: ElevatedButton.styleFrom(
        //                           primary: Colors.white.withOpacity(0.6)),
        //                       child: Text('Book Now').tr(),
        //                       onPressed: () {
        //                         // Get.to(BookingScreen(
        //                         //   hotel: widget.hotel,
        //                         //   restaurant: widget.restaurant,
        //                         // ));
        //                         Navigator.pushNamed(context,
        //                             '/book-restaurant/${widget.restaurant_code}');
        //                       },
        //                     ),
        //                   )
        //                 : Container()
        //             : Container(),
        //         SizedBox(
        //           width: 750,
        //           height: productController.categoryScreenHight.value,
        //           child: CategoryList(
        //             categories: categoriesController.categories,
        //             restaurant: categoriesController.restaurant,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // restaurantItem(),
      ],
    );
  }
}
