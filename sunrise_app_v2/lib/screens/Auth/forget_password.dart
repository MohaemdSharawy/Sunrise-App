import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Image.asset('assets/sunrise_logo.png'),
                ),
                CustomTextInput(
                  hintText: 'Enter Your Email',
                  icon: Icons.email,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: CustomBtn(
                    color: AppColor.primary,
                    height: 50,
                    title: Text(
                      'Forget Password',
                      style: const TextStyle(fontSize: 18),
                    ),
                    action: () {
                      print('Done');
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
