import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/controllers/auth_controller.dart';
import 'package:sunrise_app_v2/controllers/hotels_controller.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/screens/check_reservation_screen.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';
import 'package:sunrise_app_v2/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final authController = Get.put(AuthController());
  late AnimationController controller1;
  late Animation<double> animation1;

  late AnimationController controller2;
  late Animation<double> animation2;

  getToken() async {
    print('===================');
    var mytoken = await FirebaseMessaging.instance.getToken();
    print(mytoken);
  }

  checkPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  _getData() async {
    await authController.get_user_data();
    Future.delayed(Duration(seconds: 1)).then((value) {
      Get.off(
        () => check_onBoarding(),
        preventDuplicates: false,
      );
    });
    // Get.to(check_onBoarding());
  }

  Widget check_onBoarding() {
    if (GetStorage().read('open_before') != null) {
      if (GetStorage().read('user_token') == null) {
        return LoginScreen();
      } else {
        var user_data = jsonDecode(GetStorage().read('user_data'));
        if (user_data['checked_in'] == 1) {
          return MainScree();
        } else {
          return CheckHaveReservation();
        }
      }
    }
    return OnboardingScreen();
  }

  @override
  void initState() {
    getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.snackbar(
          message.notification!.title ?? '',
          message.notification!.body ?? '',
        );
      }
    });

    checkPermission();

    super.initState();

    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation1 = Tween<double>(begin: .0, end: .5)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
          controller2.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation2 = Tween<double>(begin: .0, end: .5)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller1.forward();
    _getData();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 70,
          width: 70,
          child: CustomPaint(
            painter: MyPainter(animation1.value, animation2.value),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double Radius_1;
  final double Radius_2;

  MyPainter(this.Radius_1, this.Radius_2);

  @override
  void paint(Canvas canvas, Size size) {
    Paint Circle_1 = Paint()..color = AppColor.primary;

    Paint Circle_2 = Paint()..color = AppColor.second;

    canvas.drawCircle(Offset(size.width * .5, size.height * .5),
        size.width * Radius_1, Circle_1);

    canvas.drawCircle(Offset(size.width * .5, size.height * .5),
        size.width * Radius_2, Circle_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
