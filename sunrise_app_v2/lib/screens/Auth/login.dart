import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/screens/Auth/forget_password.dart';
import 'package:sunrise_app_v2/screens/Auth/register.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      InkWell(
                        child: Text(
                          'Skip',
                          // style: AppFont.smallBlack,
                        ),
                        onTap: () => Get.to(
                          () => MainScree(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 400),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Image.asset('assets/sunrise_logo.png'),
                ),
                CustomTextInput(
                  hintText: 'Enter Your Email',
                  icon: Icons.email,
                ),
                SizedBox(height: 15),
                CustomTextInput(
                  hintText: 'Enter Your Email',
                  icon: Icons.lock,
                  isPassword: true,
                ),
                Container(
                  margin: EdgeInsets.only(right: 22, top: 10),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.s[],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      InkWell(
                        onTap: () => Get.to(() => ForgetPasswordScreen()),
                        child: Text(
                          'Forget Password?',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: CustomBtn(
                    color: AppColor.second,
                    height: 50,
                    title: Text(
                      'Login',
                      style: const TextStyle(fontSize: 18),
                    ),
                    action: () {
                      Get.to(
                        () => MainScree(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 400),
                      );
                    },
                  ),
                ),
                // Container(
                //   child: Divider(),
                //   padding: EdgeInsets.all(15),
                // ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        " OR ",
                        style: TextStyle(color: AppColor.primary),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: CustomBtn(
                    // color: AppColor.second,
                    height: 50,
                    title: Text(
                      'Create an Account',
                      style: const TextStyle(fontSize: 18),
                    ),
                    action: () {
                      Get.to(() => RegisterScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
