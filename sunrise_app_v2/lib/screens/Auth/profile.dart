import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/auth_controller.dart';
import 'package:sunrise_app_v2/screens/language_screen.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authController = Get.put(AuthController());

  @override
  var user_data;
  var check_in_data;
  void initState() {
    user_data = jsonDecode(GetStorage().read('user_data'));
    check_in_data = jsonDecode(GetStorage().read('check_id_data'));
    print(check_in_data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user_data['name'],
                              style: AppFont.midBlack,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                user_data['email'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.tinyGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Complete Your Profile!',
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColor.third,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              LinearPercentIndicator(
                                barRadius: Radius.circular(12),
                                width: MediaQuery.of(context).size.width / 1.3,
                                lineHeight: 10.0,
                                percent: 0.33,
                                backgroundColor: AppColor.second,
                                progressColor: AppColor.third,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.third,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, top: 4),
                            child: Text(
                              '(1/3 Add interests and preferences)',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.third,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (user_data['checked_in'] == 1) ...[
                      Text(
                        'Current Stay',
                        style: AppFont.smallBoldBlack,
                      ),
                      CurrentStayCard(
                        title: 'Check-in Date: ${check_in_data['arrival']}',
                        show_icon: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CurrentStayCard(
                        title: 'Check-out Date: ${check_in_data['departure']}',
                        show_icon: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                    Text(
                      'Setting',
                      style: AppFont.smallBoldBlack,
                    ),
                    CurrentStayCard(
                      title: 'Preference & Interest',
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                    CurrentStayCard(
                      title: 'Previous Stay',
                      icon: Icon(Icons.history_edu_outlined),
                    ),
                    CurrentStayCard(
                      title: 'Profile Setting ',
                      icon: Icon(Icons.settings_outlined),
                    ),
                    CurrentStayCard(
                      title: 'Language ',
                      action: () => Get.to(LanguageScreen()),
                      icon: Icon(Icons.language_outlined),
                    ),
                    CurrentStayCard(
                      title: 'Log out ',
                      action: () => authController.logout(),
                      icon: Icon(Icons.logout_outlined),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentStayCard extends StatelessWidget {
  String title;
  bool show_icon;
  Icon? icon;
  void Function()? action;
  CurrentStayCard({
    required this.title,
    this.show_icon = false,
    this.action,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Card(
        color: AppColor.background_card,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              if (show_icon) ...[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Icon(
                    Icons.circle,
                    color: AppColor.third,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: icon!,
                )
              ],
              Text(
                title,
                style: AppFont.profileFont,
              )
            ],
          ),
        ),
      ),
    );
  }
}
