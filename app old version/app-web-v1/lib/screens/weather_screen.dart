import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/weather_controller.dart';
import 'package:tucana/model/weather_model.dart';
import 'package:tucana/utilites/background.dart';
import 'package:tucana/utilites/header_screen.dart';
import 'package:tucana/utilites/img.dart';
import 'package:tucana/utilites/loading.dart';

class WeatherScreen extends StatefulWidget {
  var h_id;
  var city;
  WeatherScreen({this.city, this.h_id, super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // final hotelController = Get.find<HotelsController>();
  // @override
  // void initState() {
  //   weatherController.getWeather(location: 'hurghada');
  //   super.initState();
  // }

  final hotelController = Get.put(HotelsController());

  _getData() async {
    hotelController.backGroundLoaded.value = false;
    await hotelController.getBackGround(search_key: widget.h_id);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    // data = await client.getCurrentWeather(
    //     hotelController.hotels[hotelController.selectHotel.value].hotel_group);
    data = await client.getCurrentWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((() {
        return (hotelController.backGroundLoaded.value == true)
            ? mainBody()
            : Container();
      })),
    );
  }

  Widget mainBody() {
    return Stack(
      children: [
        Image.network(
            'https://yourcart.sunrise-resorts.com/assets/uploads/back_grounds/${hotelController.back_ground[0].weather_screen}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        HeaderScreen(),
        Container(
          padding: EdgeInsets.only(top: 170),
          child: Center(
            child: SizedBox(
              width: 750,
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (widget.h_id != "17")
                              ? currentWeather(Icons.wb_sunny_rounded,
                                  "${data!.temp}", "${data!.cityName}")
                              : currentWeather(Icons.wb_sunny_rounded,
                                  "${data!.temp}", "Sokhna"),
                          additionalInformation(
                            "${data!.wind}",
                            "${data!.humidity}",
                            "${data!.pressure}",
                            "${data!.feels_like}",
                          )
                        ],
                      );
                    }
                    return Center(
                      child: Container(),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }

  Widget currentWeather(IconData icon, String temp, String location) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.orange,
            size: 64.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$temp",
            style: TextStyle(fontSize: 46.0, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$location",
            style: TextStyle(
                fontSize: 18.0, color: Color.fromARGB(255, 247, 244, 244)),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Additional Information ',
            style: TextStyle(
                fontSize: 24.0,
                color: Color.fromARGB(221, 247, 243, 243),
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  Widget additionalInformation(
    String wind,
    String humidity,
    String pressure,
    String feels_like,
  ) {
    TextStyle titleFont = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white);
    TextStyle infoFont = const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 18.0, color: Colors.white);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wind",
                    style: titleFont,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "Pressure",
                    style: titleFont,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$wind",
                    style: infoFont,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "$pressure",
                    style: infoFont,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Humidity",
                    style: titleFont,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "Feels Like",
                    style: titleFont,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$humidity",
                    style: infoFont,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "$feels_like",
                    style: infoFont,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
