import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/pages/wellness/spa_categories_screen.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class GemScreen extends StatefulWidget {
  var h_code;
  GemScreen({this.h_code, super.key});

  @override
  State<GemScreen> createState() => _GemScreenState();
}

class _GemScreenState extends State<GemScreen> with BaseController {
  final gymController = Get.put(RestaurantController());
  final hotelsController = Get.put(HotelsController());

  _getData() async {
    hotelsController.backGroundLoaded.value = false;
    await hotelsController.getBackGround(
      search_key: widget.h_code,
      screen_type: 'wellness_screen',
      api_type: 'hotel_code',
    );
    await gymController.getGym(
      hotel_code: widget.h_code,
    );

    hotelAuth(gymController.hotel[0].id, context);
    npsQuestion(context);
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gymController.gymLoaded.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return (gymController.gymLoaded.value == true)
            ? mainBody()
            : BackGroundWidget();
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelsController.back_ground[0].wellness_screen}',
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
                      'assets/icons/Gym.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Gym Menu',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                Center(
                  child: SizedBox(
                    height: 600,
                    width: 750,
                    child: gymMenu(gymController.gym),
                  ),
                )
              ],
            ),
          ),
        ),

        //
      ],
    );
  }

  Widget gymMenu(gym) {
    return GridView.builder(
      itemCount: gymController.gym.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2,
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
              Navigator.pushNamed(context, '/activities/${gym[index].code}');
            },
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.network(
                        'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${gym[index].logo}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(gymController.gym[index].restaurant_name,
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
