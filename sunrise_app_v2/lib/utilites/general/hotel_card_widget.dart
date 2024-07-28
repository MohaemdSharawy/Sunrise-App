import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_icons.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/models/hotel_cards_model.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_facilities_screen.dart';
import 'package:sunrise_app_v2/screens/hotel/hotel_gallery.dart';
import 'package:sunrise_app_v2/screens/my_stay/dining_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/entertainment_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/hotel_info_screen.dart';
import 'package:sunrise_app_v2/screens/my_stay/wellness_screen.dart';

class HotelCardWidget extends StatefulWidget {
  HotelCard hotel_card;
  int hotel_id;
  HotelCardWidget({
    required this.hotel_card,
    required this.hotel_id,
    super.key,
  });

  @override
  State<HotelCardWidget> createState() => _HotelCardWidgetState();
}

class _HotelCardWidgetState extends State<HotelCardWidget> {
  @override
  Widget build(BuildContext context) {
    Map links = {
      'Hotel Info': HotelInfoScreen(hotel_id: widget.hotel_id),
      'Entertainment': EntertainmentScreen(hotel_id: widget.hotel_id),
      'Facilities': HotelFacilitiesScreen(hotel_id: widget.hotel_id),
      'About City': HotelInfoScreen(hotel_id: widget.hotel_id),
      'Dining': DinningScreen(hotel_id: widget.hotel_id),
      'Wellness': WellnessScreen(hotel_id: widget.hotel_id),
      'Gallery': HotelGallery(hotel_id: widget.hotel_id)
    };
    return InkWell(
      onTap: () => Get.to(links[widget.hotel_card.link]),
      child: Container(
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            // alignment: Alignment.center,
            children: [
              Image.network(
                '${AppUrl.main_domain}uploads/hotel_cards_image/${widget.hotel_card.image}',
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 190,
                color: Colors.black.withOpacity(0.4),
              ),
              Positioned(
                // right: 150,
                // bottom: 100,
                child: Container(
                  height: 40,
                  width: 40,
                  color: AppColor.card_label_back_ground,
                  child: AppIcons.icons[widget.hotel_card.icon],
                  // child: Icon(
                  //   Icons.abc,
                  //   color: Colors.white,
                  // ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 4.5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.hotel_card.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
