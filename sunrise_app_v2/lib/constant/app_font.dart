import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';

class AppFont {
  static const TextStyle tinyBlack = TextStyle(
    fontSize: 12,
    color: Colors.black,
  );
  static const TextStyle smallBlack = TextStyle(
    fontSize: 17,
    color: Colors.black,
  );
  static const TextStyle profileFont = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle midBlack = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  static const TextStyle boldBlack = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Raleway-bold-black',
  );
  // static const TextStyle midBoldBlack = TextStyle(
  //   fontSize: 20,
  //   color: Colors.black,
  //   fontWeight: FontWeight.bold,
  // );

  static const TextStyle smallBoldBlack = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Raleway-bold',
  );

  static const TextStyle tinyGrey = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    // fontFamily: 'Raleway-Thin',
  );

  static const TextStyle midThird = TextStyle(
    color: AppColor.third,
    fontFamily: 'Raleway-medium',
    fontSize: 17,
  );

  static const TextStyle largeBoldSecond = TextStyle(
    color: AppColor.second,
    fontFamily: 'Raleway-bold-black',
    fontSize: 20,
  );

  static const TextStyle largeSecond = TextStyle(
    color: AppColor.second,
    fontFamily: 'Raleway-medium',
    fontSize: 20,
  );
  static const TextStyle midBoldSecond = TextStyle(
    color: AppColor.second,
    fontFamily: 'Raleway-bold-black',
    fontSize: 15,
  );

  static const TextStyle midSecond = TextStyle(
    color: AppColor.second,
    fontFamily: 'Raleway-medium',
    fontSize: 15,
  );

  static const TextStyle primarySecond = TextStyle(
    color: AppColor.primary,
    fontFamily: 'Raleway-medium',
    fontSize: 15,
  );

  static const TextStyle thirdSecond = TextStyle(
    color: AppColor.third,
    fontFamily: 'Raleway-medium',
    fontSize: 15,
  );
  static const TextStyle midTinSecond = TextStyle(
    color: AppColor.second,
    fontFamily: 'Raleway-medium',
    fontSize: 12,
  );
}
