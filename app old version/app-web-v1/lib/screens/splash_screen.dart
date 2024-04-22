import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/screens/welcome_screen.dart';
import 'package:tucana/utilites/img.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin, BaseController {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 1, milliseconds: 10)).then((value) {
    //   Navigator.pushNamed(context, '/hotels');
    // }).catchError((error) {
    //   // print('${error.toString()}');
    // });
    end_session();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(Img.get('home_cover.jpg'),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        Center(
          child: InkWell(
              onTap: () {
                // Get.to(() => WelcomeScreen());
                Navigator.pushNamed(context, '/hotels');
              },
              child: AnimatedSize(
                  vsync: this,
                  duration: Duration(seconds: 1),
                  child: Container(
                    height: double.infinity,
                    child: Image.asset(
                      'assets/icons/SUNRISE White Logo.png',
                    ),
                  ))
              // child: Icon(
              //   Icons.home,
              //   color: Colors.amber,
              //   size: 100,
              // ),
              ),
        )
        //
      ],
    ));
  }
}
