import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/auth_controller.dart';
import 'package:sunrise_app_v2/screens/Auth/forget_password.dart';
import 'package:sunrise_app_v2/screens/Auth/register.dart';
import 'package:sunrise_app_v2/screens/home_screen.dart';
import 'package:sunrise_app_v2/screens/main_scrren.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        TextButton(
                          onPressed: () => Get.to(
                            () => MainScree(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 400),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(color: AppColor.primary),
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                    child: Image.asset(
                      'assets/sunrise_logo.png',
                      width: MediaQuery.of(context).size.width / 1.2,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 8),
                    child: Column(
                      children: [
                        Container(
                          // height: 55,
                          child: CustomTextInput(
                            controller: _emailController,
                            hintText: 'Enter Your Email',
                            icon: Icons.email,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return ('Email is required');
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          // height: 55,
                          child: CustomTextInput(
                            controller: _passwordController,
                            hintText: 'Password Your Email',
                            icon: Icons.lock,
                            isPassword: true,
                            valid: (value) {
                              if (value == null || value.isEmpty) {
                                return ('Password is required');
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.s[],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => ForgetPasswordScreen()),
                                child: Text(
                                  'Forget Password?',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => (authController.tryLogin.value)
                        ? Container(
                            padding:
                                EdgeInsets.only(left: 25, right: 25, top: 8),
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: CustomBtn(
                              color: AppColor.second,
                              height: 60,
                              title: Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'Raleway-Thin-medium',
                                    fontSize: 15),
                              ),
                              action: () {
                                if (_formKey.currentState!.validate()) {
                                  authController.login(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                                // Get.to(
                                //   () => MainScree(),
                                //   transition: Transition.rightToLeft,
                                //   duration: Duration(milliseconds: 400),
                                // );
                              },
                            ),
                          )
                        : Center(
                            child: CustomBtn(
                              color: AppColor.second,
                              action: () => print('s'),
                              title: CircularProgressIndicator(
                                color: AppColor.background_card,
                              ),
                            ),
                          ),
                  ),
                  // Container(
                  //   child: Divider(),
                  //   padding: EdgeInsets.all(15),
                  // ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 50, right: 50, top: 15, bottom: 8),

                    // padding: EdgeInsets.all(15),
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
                    padding: EdgeInsets.only(left: 25, right: 25, top: 8),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: CustomBtn(
                      // color: AppColor.second,
                      height: 60,
                      title: Text(
                        'Create an Account',
                        style: TextStyle(
                            fontFamily: 'Raleway-Thin-medium', fontSize: 15),
                      ),
                      action: () {
                        Get.to(() => RegisterScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
