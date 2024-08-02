import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/models/hotel_model.dart';
import 'package:sunrise_app_v2/screens/hotel_book_home.dart';

class HotelHomeCardWidget extends StatefulWidget {
  Hotels hotel;
  HotelHomeCardWidget({required this.hotel, super.key});

  @override
  State<HotelHomeCardWidget> createState() => _HotelHomeCardWidgetState();
}

class _HotelHomeCardWidgetState extends State<HotelHomeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          HotelHomeBookingScreen(
            hotel_id: widget.hotel.id,
          ),
        );
      },
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width / 1.6,
        child: Card(
          color: Colors.white,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Ink.image(
                image: NetworkImage(
                  "${AppUrl.main_domain}uploads/hotels/${widget.hotel.hotel_image}",
                ),
                fit: BoxFit.cover,
                height: 130,
                width: MediaQuery.of(context).size.width / 1.6,
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2.1,
                top: 108,
                child: InkWell(
                  onTap: () {
                    // wishListHandel(widget.hotel.hotel_code);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 130.0, bottom: 10, left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, top: 7.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          widget.hotel.hotel_name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text("${widget.hotel.group.name} "),
                        Text(widget.hotel.group.country)
                      ],
                    ),
                    // Row(
                    //   children: [Text('USD ,'), Text('Egypt')],
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
