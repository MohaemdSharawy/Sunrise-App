import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/utilites/animated_loader.dart';
import 'package:sunrise_app_v2/utilites/general/booking_btn_footer.dart';
import 'package:sunrise_app_v2/utilites/general/custom_drawer.dart';
import 'package:sunrise_app_v2/utilites/general/home_app_bar.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class HotelGallery extends StatefulWidget {
  int hotel_id;
  HotelGallery({required this.hotel_id, super.key});

  @override
  State<HotelGallery> createState() => _HotelGalleryState();
}

class _HotelGalleryState extends State<HotelGallery> {
  final GlobalKey<ScaffoldState> galleryScaffold = GlobalKey<ScaffoldState>();
  final hotelController = Get.put(HotelController());

  List images = [
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
    // 'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
  ];

  int check({required int input}) {
    int count = input % 2;
    return count;
  }

  int get_cell_count() {
    return 10;
  }

  double getMainAxisCellCount({required int number}) {
    if (check(input: number) == 0) {
      if (images.length == number) {
        return 1.5;
      }
      return 4;
    }
    return 2;
  }

  // double getCrossAxisCellCount({required int index}) {
  //   if (images.length % 3 == 0 && images.length == index + 1) {
  //     return 2.0;
  //   }

  // }

  _getData() async {
    await hotelController.hotel_view(hotel_id: widget.hotel_id);
    await hotelController.get_gallery(hotel_id: widget.hotel_id);
    images = hotelController.gallery;
    print(images);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hotelController.load_gallery.value = false;
      _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: galleryScaffold,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        toolbarHeight: 150,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 15),
          child: HomeAppBar(
            scaffoldKey: galleryScaffold,
          ),
        ),
        leading: Container(),
      ),
      body: Obx(
        () => (hotelController.load_gallery.value)
            ? SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 55),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2 / 9,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      images.length,
                      (index) => StaggeredGridTile.count(
                        crossAxisCellCount: (index + 1 == images.length &&
                                check(input: index + 1) == 0)
                            ? 4
                            : 2,
                        mainAxisCellCount:
                            getMainAxisCellCount(number: index + 1),
                        child: Container(
                          padding: EdgeInsets.only(left: 5, bottom: 5),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ImageCustom(
                              image: images[index],
                              fit: BoxFit.cover,
                              height: 300,
                              width: 100,
                            ),
                          ),
                        ),
                        // Image.network(images[index]),
                      ),
                    ),
                  ),
                ),
              )
            : AnimatedLoader(),
      ),
      drawer: CustomDrawer(
        scaffoldKey: galleryScaffold,
      ),
      bottomSheet: BookingFooterBtn(),
    );
  }
}
