import 'dart:ui';

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/utilites/img.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  List items = [
    {
      "link": '/resorts',
      'title': "Our Resorts",
      "img": 'https://app.sunrise-resorts.com/resorts.jpg',
      "sub_title": "Discover More About Our Hotels"
    },
    {
      "link": '/cruises',
      'title': "Our cruises",
      "img": 'https://app.sunrise-resorts.com/crusies.jpg',
      "sub_title": "Discover More About Our Boats"
    },
    {
      "link": '/g_posh_club',
      'title': "Posh Club",
      "img": 'https://app.sunrise-resorts.com/posh_club.jpg',
      "sub_title": "Discover More About Our Boats"
    },
    {
      "link": '/art_of_food',
      'title': "Art Of Food",
      "img": 'https://app.sunrise-resorts.com/art_of_food.jpg',
      "sub_title": "Discover More About Our Boats"
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sunrise Resorts & Cruises'),
      ),
      body: mainBody(),
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
            color: Colors.black.withOpacity(0.9)),
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
                  physics: NeverScrollableScrollPhysics(),
                  // padding: EdgeInsets.all(20),
                  // physics: BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  itemCount: items.length,
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
                          child: ItemGroupHotel(
                            index: i,
                            items: items,
                          ),
                        ),
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

class ItemGroupHotel extends StatefulWidget {
  // final hotelController = Get.put(HotelsController());

  var index;
  var items;
  ItemGroupHotel({this.index, this.items, super.key});

  @override
  State<ItemGroupHotel> createState() => _ItemGroupHotelState();
}

class _ItemGroupHotelState extends State<ItemGroupHotel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, widget.items[widget.index]['link']);
      }),
      child: Card(
        color: Colors.grey,
        // margin: EdgeInsets.only(top: 20),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height / 4) - 24,
              child: Stack(
                children: [
                  Image.network(widget.items[widget.index]['img'],
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
                      // width: 300,
                      child: Center(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //
                            primary: Colors.white.withOpacity(0.6),
                            elevation: 0),
                        onPressed: (() {
                          Navigator.pushNamed(
                              context, widget.items[widget.index]['link']);
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                          child: Text(widget.items[widget.index]['title']),
                          // child: AnimatedTextKit(
                          //     onTap: (() {
                          //       Navigator.pushNamed(
                          //           context, items[index]['link']);
                          //     }),
                          //     repeatForever: true,
                          //     isRepeatingAnimation: true,
                          //     animatedTexts: [
                          //       TypewriterAnimatedText(items[index]['title'],
                          //           textStyle: TextStyle(
                          //               color: Colors.white, fontSize: 25)),
                          //       TypewriterAnimatedText(
                          //           items[index]['sub_title'],
                          //           textStyle: TextStyle(
                          //               color: Colors.white, fontSize: 25))
                          //     ]),
                        ),
                      )
                          // child: Image.network(
                          //     'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/AD-hall.jpg',
                          //     fit: BoxFit.cover),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, items[index]['link']);
      }),
      child: Card(
        color: Colors.grey,
        // margin: EdgeInsets.only(top: 20),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 40,
              child: Stack(
                children: [
                  Image.network(items[index]['img'],
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
                      // width: 300,
                      child: Center(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //
                            primary: Colors.white.withOpacity(0.6),
                            elevation: 0),
                        onPressed: (() {
                          Navigator.pushNamed(context, items[index]['link']);
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                          child: Text(items[index]['title']),
                          // child: AnimatedTextKit(
                          //     onTap: (() {
                          //       Navigator.pushNamed(
                          //           context, items[index]['link']);
                          //     }),
                          //     repeatForever: true,
                          //     isRepeatingAnimation: true,
                          //     animatedTexts: [
                          //       TypewriterAnimatedText(items[index]['title'],
                          //           textStyle: TextStyle(
                          //               color: Colors.white, fontSize: 25)),
                          //       TypewriterAnimatedText(
                          //           items[index]['sub_title'],
                          //           textStyle: TextStyle(
                          //               color: Colors.white, fontSize: 25))
                          //     ]),
                        ),
                      )
                          // child: Image.network(
                          //     'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/AD-hall.jpg',
                          //     fit: BoxFit.cover),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   return Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.black,
//     title: Text('Sunrise Resorts & Cruises'),
//   ),
//   body: Stack(
//     children: [
//       Column(
//         children: [
//           Image.network(
//               'https://yourcart.sunrise-resorts.com/assets/uploads/logos/rr.jpg',
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height / 2,
//               fit: BoxFit.cover),
//           Image.network(
//               'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/AD-hall.jpg',
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height / 2,
//               fit: BoxFit.cover),
//         ],
//       ),
//       Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.black.withOpacity(0.60)),
//       Container(
//         margin: EdgeInsets.only(top: 35),
//         child: Center(
//           child: Text(
//             'sx',
//             style: TextStyle(color: Colors.white, fontSize: 25),
//           ),
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.only(
//             top: (MediaQuery.of(context).size.height / 2) + 35),
//         child: Center(
//           child: Text(
//             'sx',
//             style: TextStyle(color: Colors.white, fontSize: 25),
//           ),
//         ),
//       ),
//     ],
//   ),
// );
