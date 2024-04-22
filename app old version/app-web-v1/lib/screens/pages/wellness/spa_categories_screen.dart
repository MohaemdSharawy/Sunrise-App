import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/spa_category_controller.dart';
import 'package:tucana/screens/pages/wellness/spa_product.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class SpaCategories extends StatefulWidget {
  var hotel;
  var actvity;
  var category_code;
  SpaCategories({this.category_code, this.hotel, this.actvity, super.key});

  @override
  State<SpaCategories> createState() => _SpaCategoriesState();
}

class _SpaCategoriesState extends State<SpaCategories> with BaseController {
  final spaController = Get.put(SpaController());
  final hotelController = Get.put(HotelsController());
  _getData() async {
    await hotelController.getBackGround(
      search_key: widget.category_code,
      api_type: 'restaurant_code',
    );
    spaController.spaCategoriesLoaded.value = false;
    await spaController.getSpaCategories(spa_code: widget.category_code);
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
      npsQuestion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (spaController.spaCategoriesLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].wellness_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(top: 100),
            // margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                HeaderScreen(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Spa.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: 750,
                    height: 600,
                    child: spaCategories(spaController.spaCategories),
                  ),
                )
              ],
            ),
          ),
        ),

        //
        // HeaderScreen()
      ],
    );
  }

  Widget spaCategories(spa) {
    return GridView.builder(
      itemCount: spaController.spaCategories.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 35,
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
              // print(spa[index].id);
              // Get.to(SpaProductScreen(
              //   hotel: widget.hotel,
              //   actvity: widget.actvity,
              //   category: spa[index],
              // ));
              Navigator.pushNamed(
                  context, '/activity-products/${spa[index].id}');
            },
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (spaController.spaCategories[index].logo != '')
                      ? Container(
                          // margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: Image.network(
                              'https://yourcart.sunrise-resorts.com/assets/uploads/categories/${spa[index].logo}',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: Image.network(
                              'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${widget.actvity.logo}',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(spa[index].category_name,
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
