import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_urls.dart';
import 'package:sunrise_app_v2/models/offer_model.dart';

class OfferCard extends StatelessWidget {
  Offers offer;
  OfferCard({required this.offer, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background_card,
      // padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width - 40,
      height: 140,
      child: Card(
        color: AppColor.background_card,
        elevation: 0,
        // color: Colors.white,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 120,
              width: 120,
              child: Card(
                color: AppColor.background_card,
                elevation: 0,
                // surfaceTintColor: Color(0xFFfefefe),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.network(
                      '${AppUrl.main_domain}uploads/offers/${offer.image}',
                      fit: BoxFit.cover,
                      height: 200,
                      width: 97,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text(offer.name),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(offer.hotel.group.name),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: [
                      Text('${offer.price}/night'),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text('4.9'),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                      )
                      // Text('USD'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
