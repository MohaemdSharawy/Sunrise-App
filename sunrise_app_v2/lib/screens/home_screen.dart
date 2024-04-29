import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int? current_brand;

  List<String> brand_list = [
    'Sunrise',
    'Grand Select',
    'Lavish',
    'Meraki',
    'Cruise'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CustomHeader(), destinations(), brand(), offers()],
          ),
        ),
      ),
    );
  }

  Widget destinations() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Destinations',
            style: AppFont.smallBoldBlack,
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 250,
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
                          ),
                          fit: BoxFit.cover,
                          height: 250,
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Zanzibar',
                            style: AppFont.smallBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/2.%20HO%20Pool%20Overview%202.png',
                          ),
                          fit: BoxFit.cover,
                          height: 250,
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Hurghada',
                            style: AppFont.smallBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: 200,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.2_Lobby_Terrace.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: 250,
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Sharm',
                            style: AppFont.smallBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget brand() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Brands',
                style: AppFont.smallBoldBlack,
              ),
              InkWell(
                onTap: () => setState(() {
                  current_brand = null;
                }),
                child: Text(
                  'View All',
                  style: TextStyle(fontSize: 12),
                  // style: AppFont.smallBlack,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // padding: const EdgeInsets.all(8),
                    itemCount: brand_list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          child: Card(
                            color: (current_brand == index)
                                ? AppColor.primary
                                : AppColor.white,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                brand_list[index].toUpperCase(),
                                style: (current_brand != index)
                                    ? AppFont.tinyGrey
                                    : AppFont.tinyBlack,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => setState(() {
                          current_brand = index;
                        }),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
                          ),
                          fit: BoxFit.cover,
                          height: 130,
                          width: MediaQuery.of(context).size.width / 1.6,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        //   child: Icon(Icons.favorite),
                        // )

                        Positioned(
                          left: MediaQuery.of(context).size.width / 2.1,
                          top: 108,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 232, 232),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 25.0,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 8.0, top: 7.0),
                                child: Text(
                                  'Aqua joy Resort',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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

                //Second Start
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
                          ),
                          fit: BoxFit.cover,
                          height: 130,
                          width: MediaQuery.of(context).size.width / 1.6,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(10),
                        //   child: Icon(Icons.favorite),
                        // )

                        Positioned(
                          left: MediaQuery.of(context).size.width / 2.1,
                          top: 108,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 232, 232),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 25.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 8.0, top: 7.0),
                                child: Text(
                                  'Aqua joy Resort',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                //Second End
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget offers() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offers & Deals',
            style: AppFont.smallBoldBlack,
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                // padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width - 40,
                height: 140,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 120,
                        width: 120,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
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
                            child: Text('40% off Anjum Resorts'),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Marsa Alam '),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Text('260 / night'),
                                SizedBox(
                                  width: 90,
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
              ),

              // Second Offer

              Container(
                // padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width - 40,
                height: 140,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 120,
                        width: 120,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
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
                            child: Text('40% off Anjum Resorts'),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Marsa Alam '),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Text('260 / night'),
                                SizedBox(
                                  width: 90,
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
              ),

              //End Second
              //Start THird

              Container(
                // padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width - 40,
                height: 140,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        height: 120,
                        width: 120,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                'https://yourcart.sunrise-resorts.com/assets/uploads/logos/1.Meraki%20Girl.png',
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
                            child: Text('40% off Anjum Resorts'),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text('Marsa Alam '),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              children: [
                                Text('260 / night'),
                                SizedBox(
                                  width: 90,
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
              ),

              //Edn Third
            ],
          ),
        ],
      ),
    );
  }
}
