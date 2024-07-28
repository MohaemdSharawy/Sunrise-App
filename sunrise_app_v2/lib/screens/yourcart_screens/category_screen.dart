import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/yourcard/category_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/product_controller.dart';
import 'package:sunrise_app_v2/controllers/yourcard/restaurant_controller.dart';
import 'package:sunrise_app_v2/models/yourcard/category_model.dart';
import 'package:sunrise_app_v2/models/yourcard/restaurant_model.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';
import 'package:sunrise_app_v2/utilites/general/view_basket_btn.dart';
import 'package:sunrise_app_v2/utilites/yourcard/product_details.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

class CategoryScreen extends StatefulWidget {
  String code;
  CategoryScreen({required this.code, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());
  final restaurantController = Get.put(RestaurantController());
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  TabController? _tabController;
  double alignment = 0;
  int selectedOption = 0;

  Future<void> _getData({String? type}) async {
    await categoryController.get_categories_with_product(
        code: widget.code, type: type);
    _tabController = TabController(
        length: categoryController.categories.length, vsync: this);
  }

  void scrollTo(int index) => itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
        alignment: alignment,
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.loaded.value = false;
      _getData();
    });
    super.initState();
  }

  // int selectedOption = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => (categoryController.loaded.value)
            ? RefreshIndicator(
                onRefresh: _getData,
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColor.background_card,
                          // color: Color.fromARGB(255, 240, 232, 232),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: CustomStayHeader(
                          title: Text(
                            restaurantController.hotel_name.value,
                            style: AppFont.boldBlack,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryController
                                  .restaurant.value.restaurant_name,
                              style: AppFont.smallBoldBlack,
                            ),
                            (categoryController.type_loaded.value)
                                ? Container(
                                    height: 35,
                                    width: 35,
                                    child: IconButton(
                                      icon: Icon(Icons.display_settings_sharp),
                                      onPressed: () async {
                                        await categoryController
                                            .get_categories_type(
                                          code: widget.code,
                                        );
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return SingleChildScrollView(
                                                  child: Center(
                                                    child: Column(
                                                      children: <Widget>[
                                                        ListTile(
                                                          title: Text('All'),
                                                          leading: Radio<int>(
                                                            value: 0,
                                                            groupValue:
                                                                selectedOption,
                                                            splashRadius:
                                                                20, // Change the splash radius when clicked
                                                            onChanged: (value) {
                                                              print(value);
                                                              setState(() {
                                                                selectedOption =
                                                                    value!;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        for (var types
                                                            in categoryController
                                                                .category_type)
                                                          ListTile(
                                                            title: Text(types
                                                                .categoryName),
                                                            leading: Radio<int>(
                                                              value: int.parse(
                                                                  types.id),
                                                              groupValue:
                                                                  selectedOption,
                                                              splashRadius:
                                                                  20, // Change the splash radius when clicked
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedOption =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomBtn(
                                                              height: 40,
                                                              title: Text(
                                                                  'Change '),
                                                              color: AppColor
                                                                  .primary,
                                                              action: () async {
                                                                Navigator.pop(
                                                                    context);
                                                                _getData(
                                                                    type: selectedOption
                                                                        .toString());
                                                                // await categoryController.get_categories_with_product(
                                                                //     code: widget
                                                                //         .code,
                                                                //     type: selectedOption
                                                                //         .toString());
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: 35,
                                                            ),
                                                            CustomBtn(
                                                              title:
                                                                  Text('Close'),
                                                              height: 40,
                                                              color: AppColor
                                                                  .second,
                                                              action: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      color: AppColor.primary,
                                    ),
                                  )
                          ],
                        ),
                      ),
                      TabBar(
                        tabAlignment: TabAlignment.start,
                        tabs: categoryController.categories.map((tab) {
                          return Container(
                              padding: EdgeInsets.only(top: 10),
                              height: 40.0,
                              width: MediaQuery.of(context).size.width / 4.5,
                              child: new Text(
                                overflow: TextOverflow.ellipsis,
                                tab.category_name,
                                style: AppFont.tinyBlack,
                              ));
                        }).toList(),
                        onTap: (value) => scrollTo(value),
                        unselectedLabelColor: const Color(0xffacb3bf),
                        indicatorColor: AppColor.primary,
                        labelColor: AppColor.second,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3.0,
                        isScrollable: true,
                        controller: _tabController,
                      ),
                      Expanded(child: list(categoryController.categories)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 17,
                      )
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
      bottomSheet: ViewBasketBtn(),
    );
  }

  Widget list(orientation) => ScrollablePositionedList.builder(
        itemCount: categoryController.categories.length,
        itemBuilder: (context, index) => CategoryWithProduct(
          categories: categoryController.categories[index],
          restaurant: categoryController.restaurant.value,
        ),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetController: scrollOffsetController,
        // scrollDirection: orientation == Orientation.portrait
        //     ? Axis.vertical
        //     : Axis.horizontal,
      );
}

class CategoryWithProduct extends StatelessWidget {
  Categories categories;
  Restaurant restaurant;
  CategoryWithProduct(
      {required this.categories, required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categories.category_name,
            style: AppFont.boldBlack,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.product.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // showFlexibleBottomSheet(
                //   minHeight: 0,
                //   initHeight: 0.85,
                //   maxHeight: 1,
                //   context: context,
                //   builder: (
                //     BuildContext context,
                //     ScrollController scrollController,
                //     double bottomSheetOffset,
                //   ) {
                //     return ProductDetails(
                //         product: categories.product[index]);
                //   },
                //   anchors: [0, 0.5, 1],
                //   isSafeArea: true,
                // );
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50.0)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.35,
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return ProductDetails(
                            product: categories.product[index],
                          );

                          // return DraggableScrollableSheet(
                          //   initialChildSize: 1, //set this as you want
                          //   maxChildSize: 1, //set this as you want
                          //   minChildSize: 1, //set this as you want
                          //   expand: true,
                          //   builder: (context, scrollController) {
                          //     return ProductDetails(
                          //       product: categories.product[index],
                          //     ); //whatever you're returning, does not have to be a Container
                          //   },
                          // );
                        },
                      ),
                    );
                  },
                );
              },
              child: Card(
                color: AppColor.background_card,
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Text(
                              categories.product[index].product_name,
                              style: AppFont.smallBoldBlack,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Text(
                              categories.product[index].description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 6),
                                child: Text(
                                  restaurant.currency,
                                ),
                              ),
                              Text(
                                categories.product[index].price,
                              ),
                            ],
                          ),
                        ],
                      ),
                      (categories.product[index].logo != '')
                          ? Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              //   child: ImageCustom(
                              //       image:
                              //           '${AppUrl.restaurant_domain}assets/uploads/products/${categories.product[index].logo}',
                              //       height: 150,
                              //       width: 150),
                              // )
                              child: CircleAvatar(
                                radius: 52, // Image radius
                                backgroundImage: NetworkImage(
                                  '${AppUrl.restaurant_domain}assets/uploads/products/${categories.product[index].logo}',
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/no_image.png',
                              height: 150,
                              width: 150,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
