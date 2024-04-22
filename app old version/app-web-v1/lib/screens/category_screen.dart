import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/product_controller.dart';
import 'package:tucana/screens/pages/dining/booking_screen.dart';
import 'package:tucana/screens/product_screen.dart';
import 'package:tucana/controller/categories_controller.dart';
import 'package:tucana/utilites/appbar.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/categoryList.dart';
import 'package:tucana/utilites/categoryListExpand.dart';
import 'package:tucana/utilites/img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilites/loading.dart';
import 'package:recase/recase.dart';

class CategoriesScreen extends StatefulWidget {
  var hotel;
  var restaurant;
  var h_id;
  var restaurant_code;
  CategoriesScreen({
    this.h_id,
    this.restaurant_code,
    this.hotel,
    this.restaurant,
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with BaseController {
  final categoriesController = Get.put(CategoriesController());
  final hotelController = Get.put(HotelsController());
  final productController = Get.put(ProductController());
  // String updateName(str) {
  //   ReCase rc = ReCase(str);
  //   print(rc.constantCase);
  //   return rc.constantCase.toString();
  // }

  // String allWordsCapitilize(str) {
  //   return str.toLowerCase().split(' ').map((word) {
  //     String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
  //     return word[0].toUpperCase() + leftText;
  //     return '';
  //   }).join(' ');
  // }

  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.restaurant_code,
      api_type: 'restaurant_code',
    );
    await categoriesController.guestCategories(
        restaurant_code: widget.restaurant_code, type: '');
    productController.categoryScreenHight.value =
        categoriesController.categories.length * 85.0;
    hotelAuth(categoriesController.hotel[0].id, context);
    npsQuestion(context);
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(Uri.parse(
        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].pdf_menu}'))) {
      await launchUrl(
          Uri.parse(
              'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${categoriesController.restaurant[0].pdf_menu}'),
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

  Future<void> _rate_restaurant(link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoriesController.isloaded.value = false;
      _getData();
      visitApp();
    });
    super.initState();
  }

  visitApp() {
    // return AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.warning,
    //   animType: AnimType.rightSlide,
    //   dialogBackgroundColor: Colors.black,
    //   body: Center(
    //     child: Text(
    //       'Open Mobile App',
    //       style: TextStyle(color: Colors.white, fontSize: 15),
    //     ),
    //   ),
    //   btnCancelOnPress: () {},
    //   btnCancelText: tr('cancel'),
    //   btnOkText: tr('Open App'),
    //   btnOkOnPress: () async {
    //     if (await canLaunchUrl(Uri.parse(
    //         'https://hotels.sunrise-resorts.com/?restaurant_code=${widget.restaurant_code}'))) {
    //       await launchUrl(
    //           Uri.parse(
    //               'https://hotels.sunrise-resorts.com/?restaurant_code=${widget.restaurant_code}'),
    //           mode: LaunchMode.externalApplication);
    //     }
    //   },
    // ).show();
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
        Container(
          child: Column(
            children: [
              AppBarWidget(
                h_id: (widget.h_id != null)
                    ? widget.h_id
                    : categoriesController.restaurant[0].hid,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(
                      width: 20,
                    ),
                    (categoriesController.restaurant[0].pdf_menu != '')
                        ? Container(
                            padding: EdgeInsets.only(top: 8, bottom: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white.withOpacity(0.6)),
                              child: Text('PDF Menu').tr(),
                              onPressed: () {
                                _launchUrl();
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
                if (categoriesController.restaurant[0].survey != '') ...[
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.6)),
                      child: Text('Rate This Restaurant').tr(),
                      onPressed: () {
                        Navigator.pushNamed(context,
                            '/restaurant_survey/${widget.restaurant_code}');
                        // _rate_restaurant(
                        //     categoriesController.restaurant[0].survey);
                      },
                    ),
                  ),
                ],
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
              (categoriesController.restaurant[0].room_service == "1" ||
                      categoriesController.restaurant[0].bar == "1" ||
                      categoriesController.restaurant[0].shisha == "1")
                  ? Expanded(
                      // width: 750,
                      // height: productController.categoryScreenHight.value,
                      child: CategoryList(
                        categories: categoriesController.categories,
                        restaurant: categoriesController.restaurant,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: SizedBox(
                          width: 750, height: 800, child: buildCategoryType()),
                    ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        // restaurantItem(),
      ],
    );
  }

  Widget buildCategoryType() {
    return GridView.builder(
      itemCount: categoriesController.category_type.length,
      physics: BouncingScrollPhysics(),
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
            onTap: () async {
              Navigator.pushNamed(context,
                  '/restaurant_category_by_type/${widget.restaurant_code}/${categoriesController.category_type[index].id}');
            },
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text('test', style: TextStyle(fontSize: 19)),
                  // Image.asset(
                  //   tapIcon[index],
                  //   width: 80,
                  //   height: 80,
                  //   color: Colors.white,
                  // ),

                  Image.asset(
                    'assets/icons/${categoriesController.category_type[index].logo}',
                    width: 80,
                    height: 80,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(categoriesController.category_type[index].category_name,
                          style: TextStyle(fontSize: 17, color: Colors.white))
                      .tr(),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   categoriesController.category_type[index].category_name,
                  //   style: TextStyle(color: Colors.white),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoryList(categories) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          height: 55,
          padding: EdgeInsets.only(left: 50, right: 50),
          width: double.infinity,
          child: InkWell(
            onTap: (() {
              // Get.to(ProductScreen(
              //   category: categories[index],
              //   restaurant: widget.restaurant,
              //   hotel: widget.hotel,
              // ));
              // print(categories[index].id);
              Navigator.pushNamed(
                context,
                '/category-products/${categories[index].id}',
              );
            }),
            child: Card(
              color: Colors.grey.withOpacity(0.5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  // allWordsCapitilize(
                  categories[index].category_name,
                  // ),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Sans-bold',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
