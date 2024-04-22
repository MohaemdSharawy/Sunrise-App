import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/screens/login_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class CruisesScreen extends StatefulWidget {
  const CruisesScreen({super.key});

  @override
  State<CruisesScreen> createState() => _CruisesScreenState();
}

class _CruisesScreenState extends State<CruisesScreen> with BaseController {
  final hotelController = Get.put(HotelsController());
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    hotelController.guestHotel();
    end_session();
    // npsQuestion(context);
    super.initState();
  }

  void selectHotel(index) {
    // hotelController.selectHotel = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sunrise Resorts & Cruises'),
      ),
      body: Obx(() {
        return (hotelController.isloaded.value == true)
            ? mainBody()
            : LoadingScreen(img_name: 'home_cover.jpg');
        // : Container(
        //     child: Center(child: CircularProgressIndicator()),
        //   );
      }),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.asset(Img.get('home_cover.jpg'),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(30.0)),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Center(
            child: SizedBox(
              // height: 250.0 * hotelController.hotels.length,
              // width: 450,

              child: AnimationLimiter(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  // padding: EdgeInsets.all(20),
                  // physics: BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  itemCount: hotelController.cruises.length,
                  itemBuilder: (BuildContext c, int i) {
                    return AnimationConfiguration.staggeredList(
                      position: i,
                      delay: Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: 30,
                        verticalOffset: 300.0,
                        child: FlipAnimation(
                            duration: Duration(milliseconds: 3000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            flipAxis: FlipAxis.y,
                            child: ItemHotel(
                              index: i,
                              items: hotelController.cruises,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
        //
      ],
    );
  }
}

class ItemHotel extends StatelessWidget {
  final hotelController = Get.put(HotelsController());

  var index;
  var items;
  ItemHotel({this.index, this.items, Key? key});

  @override
  Widget build(BuildContext context) {
    hotelAuthCheck() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        dialogBackgroundColor: Colors.black,
        body: Center(
          child: Text(
            tr('You Are Login in Another Hotel!!'),
            style: TextStyle(color: Colors.white),
          ),
        ),
        btnCancelOnPress: () {
          GetStorage().remove('room_num');
          GetStorage().remove('departure');
          GetStorage().remove('birthday');
          GetStorage().remove('h_id');
          GetStorage().remove('full_name');
          GetStorage().remove('title');
          Navigator.pushNamed(context, '/login/${items[index].id}');
        },
        btnOkOnPress: () {},
        btnCancelText: tr('Logout'),
        btnOkText: tr('cancel'),
      ).show();
    }

    return Container(
      // width: ,
      // height: 250,
      // padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: InkWell(
        onTap: (() {
          // hotelController.selectHotel.value = index;
          // Get.to(LoginScreen(
          //   hotel: items[index],
          // ));

          if (GetStorage().read('room_num') != '' &&
              GetStorage().read('room_num') != null) {
            if (items[index].id == GetStorage().read('h_id')) {
              Navigator.pushNamed(context, '/home/${items[index].id}');
            } else {
              hotelAuthCheck();
            }
          } else {
            Navigator.pushNamed(context, '/login/${items[index].id}');
          }

          // Navigator.pushNamed(context, '/home/${items[index].id}');
        }),
        child: Container(
          child: Card(
            color: Colors.grey,
            // margin: EdgeInsets.only(top: 20),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${items[index].image}',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover),
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.60)),
                      Center(
                        child: SizedBox(
                          // height: 150,
                          width: 150,
                          child: Center(
                            child: Image.network(
                                'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${items[index].logo_white}',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
