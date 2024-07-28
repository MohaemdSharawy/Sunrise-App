import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/controllers/hotel_info_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/custom_carousel_slider.dart';
import 'package:sunrise_app_v2/utilites/general/custom_mystay_header.dart';
import 'package:sunrise_app_v2/utilites/general/doted_fade.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class HotelInfoScreen extends StatefulWidget {
  int hotel_id;
  HotelInfoScreen({required this.hotel_id, super.key});

  @override
  State<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends State<HotelInfoScreen> {
  final info_controller = Get.put(HotelInfoController());
  final hotel_controller = Get.put(HotelController());

  _getData() async {
    await hotel_controller.getSlider(
      type_name: 'Hotel Info Screen',
      hotel_id: widget.hotel_id,
    );
    await hotel_controller.hotel_view(hotel_id: widget.hotel_id);
    await info_controller.getHotelInfo(hotel_id: widget.hotel_id);
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
      body: Obx(
        () => (info_controller.hotel_info_loaded.value)
            ? SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            // width: double.infinity,
                            // height: double.infinity,
                          ),
                          SliderWidget(),
                          Positioned(
                            // top: 5,
                            child: Container(
                              // height: 150,
                              decoration: BoxDecoration(
                                color: AppColor.background_card,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: CustomStayHeader(
                                title: Text(
                                  hotel_controller.hotel.value.hotel_name,
                                  style: AppFont.boldBlack,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height /
                                  3, //minimum height
                            ),
                            margin: EdgeInsets.only(top: 350),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Hotel Information',
                                      style: AppFont.midBlack,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: info_controller.info.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      InfoImage(
                                          images: info_controller
                                              .info[index].images),
                                      HtmlWidget(
                                          info_controller.info[index].content),
                                      SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
    );
  }
}

class InfoImage extends StatelessWidget {
  List images;

  InfoImage({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return Container(
        padding: EdgeInsets.only(left: 15, bottom: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ImageCustom(
            image: "${AppUrl.main_domain}/uploads/hotel_info/${images[0]}",
            fit: BoxFit.cover,
            height: 150,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      );
    } else if (images.length < 4) {
      return StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          for (int i = 0; i < images.length; i++)
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: Container(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ImageCustom(
                    image:
                        "${AppUrl.main_domain}/uploads/hotel_info/${images[i]}",
                    fit: BoxFit.cover,
                    height: 150,
                    width: 100,
                  ),
                ),
              ),
            )
        ],
      );
    } else {
      int i = 0;
      return StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          for (int i = 0; i < images.length; i++)
            // for (String img in images)
            (i == 2)
                ? StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 4,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ImageCustom(
                          image:
                              "${AppUrl.main_domain}/uploads/hotel_info/${images[i]}",
                          fit: BoxFit.cover,
                          height: 150,
                          width: 100,
                        ),
                      ),
                    ),
                  )
                : StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ImageCustom(
                          image:
                              "${AppUrl.main_domain}/uploads/hotel_info/${images[i]}",
                          fit: BoxFit.cover,
                          height: 150,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
        ],
      );
    }
  }
}
