import 'dart:math';
import 'dart:typed_data';
import 'package:rive_common/rive_text.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/controller/base_controller.dart';
import 'package:tucana/routes.dart';
import 'package:tucana/screens/login_screen.dart';
import 'package:tucana/screens/splash_screen.dart';
import 'package:tucana/screens/welcome_screen.dart';
import 'package:tucana/services/api.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';

import 'const/app_constant.dart';
import 'languages/codegen_loader.g.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  // Api.initializeInterceptors();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundMessage);

  // runApp(MyApp());
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        AppConstant.EN_LOCAL,
        AppConstant.AR_LOCAL,
        AppConstant.RU_LOCAL,
        // AppConstant.DU_LOCAL,
        AppConstant.GR_LOCAL,
        AppConstant.CZ_LOCAL,
        AppConstant.FR_LOCAL,
        AppConstant.IT_LOCAL,
        AppConstant.PL_LOCAL,
        AppConstant.RO_LOCAL,
        // AppConstant.UA_LOCAL
      ],
      // fallbackLocale: AppConstant.EN_LOCAL,
      path: AppConstant.LANG_PATH,
      // assetLoader: CodegenLoader(),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        //Extra
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.trackpad
        // etc.
      };
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseController {
  @override
  void initState() {
    super.initState();
    Flurorouter.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    Locale _locale;

    changeLanguage(Locale locale) {
      setState(() {
        _locale = locale;
      });
    }

    return GetMaterialApp(
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      title: 'Sunrise App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      // locale: context.locale,
      locale: Locale('en'), // This forces LTR layout

      // localeResolutionCallback: (locale, supportedLocales) {
      //   for (var supportedLocale in supportedLocales) {
      //     if (supportedLocale.languageCode == locale?.languageCode &&
      //         supportedLocale.countryCode == locale?.countryCode) {
      //       return supportedLocale;
      //     }
      //   }
      //   return supportedLocales.first;
      // },

      // locale: AppConstant.EN_LOCAL,
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(

//       scrollBehavior: MyCustomScrollBehavior(),
//       title: 'Sunrise App',
//       debugShowCheckedModeBanner: false,
//       darkTheme: ThemeData(
//         appBarTheme: AppBarTheme(
//           centerTitle: true,
//           iconTheme: IconThemeData(color: Colors.white),
//           backgroundColor: Colors.grey[700],
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: Colors.black,
//             statusBarIconBrightness: Brightness.light,
//           ),
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//           // iconTheme: IconThemeData(color: Colors.black),
//           // color: Colors.blue,
//         ),
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           primary: Colors.blue,
//           secondary: Colors.blue,
//           brightness: Brightness.dark,
//         ),
//       ),
//       // themeMode: ThemeMode.light,

//       ///Custom Dark Mode
//       // theme: ThemeData.dark().copyWith(
//       //   scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
//       // ),
//       ///End

//       // translations: Translation(),
//       locale: Locale('en'), //Get.deviceLocale
//       fallbackLocale: Locale('en'),
//       // defaultTransition: Transition.fade,
//       transitionDuration: Duration(milliseconds: 100),
//       // initialRoute: 'example/path',
//       home: Scaffold(body: SplashScreen()),
//     );
//   }
