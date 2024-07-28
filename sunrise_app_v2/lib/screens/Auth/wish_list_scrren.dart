import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/wish_list_controller.dart';
import 'package:sunrise_app_v2/models/wish_list_model.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final wishListController = Get.put(WishListController());

  var selectedOption;

  _getData() async {
    await wishListController.get_wish_list();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishListController.wishListLoaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Obx(
        () => SafeArea(
          child: (wishListController.wishListLoaded.value)
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Wish List',
                              style: AppFont.smallBoldBlack,
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              child: IconButton(
                                icon: Icon(Icons.display_settings_sharp),
                                onPressed: () {
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
                                                    leading: Radio(
                                                      value: 'all',
                                                      groupValue:
                                                          selectedOption,
                                                      splashRadius:
                                                          20, // Change the splash radius when clicked
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedOption =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text('Hotels'),
                                                    leading: Radio(
                                                      value: 'hotel',
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
                                                  ListTile(
                                                    title: Text('Restaurants'),
                                                    leading: Radio(
                                                      value: 'restaurant',
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
                                                  ListTile(
                                                    title: Text('Roms'),
                                                    leading: Radio(
                                                      value: 'room',
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

                                                        print(selectedOption);
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
                                                        title: Text('Change '),
                                                        color: AppColor.primary,
                                                        action: () async {
                                                          Navigator.pop(
                                                              context);

                                                          await wishListController
                                                              .get_wish_list(
                                                            type: (selectedOption ==
                                                                    'all')
                                                                ? null
                                                                : selectedOption,
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 35,
                                                      ),
                                                      CustomBtn(
                                                        title: Text('Close'),
                                                        height: 40,
                                                        color: AppColor.second,
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      (wishListController.wishList.isEmpty)
                          ? Container(
                              padding: EdgeInsets.only(top: 25),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/search-result-not-found-2130355-1800920.webp',
                                    ),
                                    Text(
                                      'There Is No Data',
                                      style: AppFont.smallBoldBlack,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: wishListController.wishList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return WishListCard(
                                  wish: wishListController.wishList[index],
                                );
                              },
                            ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                )
              : AnimatedLoader(),
        ),
      ),
    );
  }
}

class WishListCard extends StatelessWidget {
  WishListModel wish;
  WishListCard({required this.wish, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: wish.wish_date['action'],
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        child: Card(
          color: AppColor.background_card,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  wish.wish_date['image'],
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                  // bottom: 2,
                ),
                width: MediaQuery.of(context).size.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wish.wish_date['name'],
                      style: AppFont.midBoldSecond,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
