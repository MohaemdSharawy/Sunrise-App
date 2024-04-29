import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ResortsScreen extends StatefulWidget {
  const ResortsScreen({super.key});

  @override
  State<ResortsScreen> createState() => _ResortsScreenState();
}

class _ResortsScreenState extends State<ResortsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      '36 Destination Found',
                      style: AppFont.smallBoldBlack,
                    ),
                    Container(
                      // padding: EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      height: 35,
                      width: 35,
                      child: Icon(Icons.map),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 270,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
                          fit: BoxFit.cover,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 1.25,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 232, 232),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.favorite,
                            size: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 232, 232),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              '-40%',
                              style: AppFont.smallBoldBlack,
                            )),
                      ),
                      Positioned(
                        top: 155,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 7.0),
                              child: Text(
                                'Aqua joy Resort',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Hurgada ,'),
                                Text('Egypt')
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: 5,
                                  size: 25.0,
                                  // filledIconData: Icons.blur_off,
                                  halfFilledIconData: Icons.blur_on,
                                  color: Colors.amber,
                                  borderColor: Colors.amber,
                                  spacing: 0.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' (4.9)',
                                  style: AppFont.tinyGrey,
                                )
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
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 270,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/01-34_12.jpg',
                          fit: BoxFit.cover,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 1.25,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 232, 232),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.favorite,
                            size: 25.0,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 232, 232),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              '-40%',
                              style: AppFont.smallBoldBlack,
                            )),
                      ),
                      Positioned(
                        top: 155,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 7.0),
                              child: Text(
                                'Aqua joy Resort',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Hurgada ,'),
                                Text('Egypt')
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: 5,
                                  size: 25.0,
                                  // filledIconData: Icons.blur_off,
                                  halfFilledIconData: Icons.blur_on,
                                  color: Colors.amber,
                                  borderColor: Colors.amber,
                                  spacing: 0.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' (4.9)',
                                  style: AppFont.tinyGrey,
                                )
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
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 270,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.%20GB%20Beach%20Overview%202.png',
                          fit: BoxFit.cover,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 1.25,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 232, 232),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.favorite,
                            size: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 232, 232),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              '-40%',
                              style: AppFont.smallBoldBlack,
                            )),
                      ),
                      Positioned(
                        top: 155,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8.0, top: 7.0),
                              child: Text(
                                'Aqua joy Resort',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 9),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Hurgada ,'),
                                Text('Egypt')
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: 5,
                                  size: 25.0,
                                  // filledIconData: Icons.blur_off,
                                  halfFilledIconData: Icons.blur_on,
                                  color: Colors.amber,
                                  borderColor: Colors.amber,
                                  spacing: 0.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' (4.9)',
                                  style: AppFont.tinyGrey,
                                )
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
            ],
          ),
        ),
      ),
    );
  }
}
