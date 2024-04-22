import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/art_of_food_controller.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';

class ArtOfFoodView extends StatefulWidget {
  var art_id;
  ArtOfFoodView({this.art_id, super.key});

  @override
  State<ArtOfFoodView> createState() => _ArtOfFoodViewState();
}

class _ArtOfFoodViewState extends State<ArtOfFoodView> with BaseController {
  final art_of_food_controller = Get.put(ArtOfFoodController());

  TextStyle header = TextStyle(color: Colors.white, fontSize: 25);
  TextStyle sub_text = TextStyle(color: Colors.white, fontSize: 15);

  _getData() async {
    await art_of_food_controller.getViewArtOfFood(
      art_of_food_id: widget.art_id,
    );
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (art_of_food_controller.art_of_food_loaded.value == true)
              ? mainBody()
              : BackGroundWidget();
        },
      ),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        // BackGroundWidget(),
        Image.network(
          'https://app.sunrise-resorts.com/art_of_food.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),

        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              HeaderScreen(),
              //TODO
              //ADD LOGO FROM API
              // Image.network(
              //   'https://hotelguide.sunrise-resorts.com/attach/${hotel_guide_controller.posh_club_logo.value.logo}',
              //   width: 150,
              //   height: 150,
              //   color: Colors.white,
              // ),
              // SizedBox(
              //   height: 300,
              //   width: 750,
              //   child: SliderWidget(),
              // ),

              Center(
                child: Text(
                  art_of_food_controller
                      .art_of_food_restaurant_view.value.restaurant_name,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),

              Image.network(
                'https://yourcart.sunrise-resorts.com/assets/uploads/restaurants/${art_of_food_controller.art_of_food_restaurant_view.value.white_logo}',
                width: 150,
                height: 150,
              ),
              Center(
                child: Text(
                  art_of_food_controller.art_of_food_restaurant_view.value.type,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Wrap(
                children: [
                  for (int i = 0;
                      i <
                          art_of_food_controller
                              .art_of_restaurant_hotels.length;
                      i++)
                    Container(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          clearData();
                          Navigator.pushNamed(context,
                              '/categories/${art_of_food_controller.art_of_restaurant_hotels[i].code}');
                        },
                        child: Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${art_of_food_controller.art_of_restaurant_hotels[i].hotel_logo}',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    )
                ],
              ),

              // for (var elemnet in art_of_food_controller.art_of_food)
              SizedBox(
                width: 750,
                child: Center(
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    title: Text(
                      art_of_food_controller
                          .art_of_food_restaurant_view.value.header,
                      style: header,
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        color: Colors.black,
                        child: Html(
                          data: art_of_food_controller
                              .art_of_food_restaurant_view.value.description,
                          style: {
                            "body": Style(color: Colors.white),
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // end to do
            ],
          ),
        ),
      ],
    );
  }
}
