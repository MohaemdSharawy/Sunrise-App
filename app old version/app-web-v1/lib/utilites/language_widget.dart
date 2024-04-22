import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/const/app_constant.dart';
import 'package:tucana/controller/Resturan_Controller.dart';
import 'package:tucana/controller/categories_controller.dart';
import 'package:tucana/controller/hotel_controller.dart';
import 'package:tucana/controller/ticket_controller.dart';
import 'package:tucana/screens/category_screen.dart';
import 'dart:html' as htmls;

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.language,
        color: Colors.white,
      ),
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: Colors.black,
          descTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          body: LangDialogBody(),
          btnCancelOnPress: () {},
        ).show();
      },
    );
  }
}

class LangDialogBody extends StatelessWidget {
  const LangDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 4, right: 4),
      child: Column(children: [
        Text(
          "Select Language",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Flag(img: 'united-states.png', lang: AppConstant.EN_LOCAL),
            Flag(img: 'germany.png', lang: AppConstant.GR_LOCAL),
            Flag(img: 'russia.png', lang: AppConstant.RU_LOCAL),
            Flag(img: 'eg.png', lang: AppConstant.AR_LOCAL),
            Flag(img: 'cz.png', lang: AppConstant.CZ_LOCAL),
            Flag(img: 'du.png', lang: AppConstant.DU_LOCAL),
            Flag(img: 'it.png', lang: AppConstant.IT_LOCAL),
            Flag(img: 'pl.png', lang: AppConstant.PL_LOCAL),
            Flag(img: 'ro.png', lang: AppConstant.RO_LOCAL),
            Flag(img: 'ua.png', lang: AppConstant.UA_LOCAL),
            Flag(img: 'fr.png', lang: AppConstant.FR_LOCAL),
          ],
        ),
        // Row(),
        // // Row(),
      ]),
    );
  }
}

class Flag extends StatefulWidget {
  String img;
  var lang;
  Flag({required this.img, required this.lang, super.key});

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  void updateLang(lang) {
    context.locale = lang;
    GetStorage().write(
      'lang',
      context.locale.toString(),
    );
    htmls.window.location.reload();
  }

  @override
  Widget build(BuildContext context) {
    if (GetStorage().read('lang') == widget.lang.toString()) {
      return Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.blue, width: 5),
        ),
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: InkWell(
          child: Image.asset(
            'assets/icons/${widget.img}',
            height: 80,
            width: 80,
          ),
          onTap: () {
            print(widget.lang);
            Navigator.pop(context);
            updateLang(widget.lang);
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: InkWell(
          child: Image.asset(
            'assets/icons/${widget.img}',
            height: 80,
            width: 80,
          ),
          onTap: () {
            Navigator.pop(context);
            updateLang(widget.lang);
          },
        ),
      );
    }
  }
}

// class Flag extends StatelessWidget {
//   String img;
//   String lang;
//   Flag({required this.img, required this.lang, super.key});
//   MyLocaleController localeController = Get.put(MyLocaleController());

//   @override
//   Widget build(BuildContext context) {
//     if (GetStorage().read('lang') == lang) {
//       return Container(
//         height: 100,
//         width: 80,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(color: Colors.blue, width: 5),
//         ),
//         margin: EdgeInsets.only(top: 10, bottom: 20),
//         child: InkWell(
//           child: Image.asset(
//             'assets/icons/${img}',
//             height: 80,
//             width: 80,
//           ),
//           onTap: () {
//             GetStorage().write('lang', lang);
//             localeController.changeLanguage(lang);
//             // Navigator.pop(context);
//             // Navigator.pop(context);
//             Get.back();
//           },
//         ),
//       );
//     } else {
//       return Container(
//         margin: EdgeInsets.only(top: 10, bottom: 20),
//         child: InkWell(
//           child: Image.asset(
//             'assets/icons/${img}',
//             height: 80,
//             width: 80,
//           ),
//           onTap: () {
//             GetStorage().write('lang', lang);
//             localeController.changeLanguage(lang);

//             Navigator.pop(context);

//             // Navigator.pop(context);
//           },
//         ),
//       );
//     }
//   }
// }
