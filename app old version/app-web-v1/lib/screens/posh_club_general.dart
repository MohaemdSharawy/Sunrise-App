import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/hotel_guide_controller.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/slider_widget.dart';

class PoshClubGeneral extends StatefulWidget {
  const PoshClubGeneral({super.key});

  @override
  State<PoshClubGeneral> createState() => _PoshClubGeneralState();
}

class _PoshClubGeneralState extends State<PoshClubGeneral> with BaseController {
  // final hotel_guide_controller = Get.put(HotelGuideController());

  final hotel_controller = Get.put(HotelsController());

  _getData() async {
    await hotel_controller.getPoshClubGeneral();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  TextStyle header = TextStyle(color: Colors.white, fontSize: 25);
  TextStyle sub_text = TextStyle(color: Colors.white, fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return (hotel_controller.posh_club_general_loaded.value == true)
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
          'https://app.sunrise-resorts.com/posh_club.jpg',
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
              HeaderScreen(
                  // h_id: widget.h_id,
                  ),
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
                  'Posh Club',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),

              Wrap(
                children: [
                  for (int i = 0;
                      i < hotel_controller.posh_club_hotels.length;
                      i++)
                    Container(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          clearData();
                          Navigator.pushNamed(context,
                              '/home/${hotel_controller.posh_club_hotels[i].id}');
                        },
                        child: Image.network(
                          'https://yourcart.sunrise-resorts.com/assets/uploads/logos/${hotel_controller.posh_club_hotels[i].logo_white}',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    )
                ],
              ),

              for (var elemnet in hotel_controller.posh_club_general)
                SizedBox(
                  width: 750,
                  child: Center(
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        elemnet.header,
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
                            data: elemnet.description,
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
