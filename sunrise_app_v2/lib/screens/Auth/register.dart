import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: App,
      body: SafeArea(
        child: SingleChildScrollView(
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
              Text(
                'Create an account to enjoy unlimited features and offers',
                style: AppFont.boldBlack,
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 25,
              ),
              component1(
                  Icons.account_circle_outlined, 'User name...', false, false),
              SizedBox(
                height: 15,
              ),
              component1(Icons.email, 'Enter Your Email...', false, false),
              SizedBox(
                height: 15,
              ),
              component1(Icons.phone_android_rounded, 'Mobile Number...', false,
                  false),
              SizedBox(
                height: 15,
              ),
              component1(
                  Icons.account_circle_outlined, 'Password...', false, false),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: MaterialButton(
                  height: 60,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Get.to(page)
                    // Get.to(CheckInScreen());
                  },
                  textColor: Colors.white,
                  color: AppColor.second,
                  child: Text(
                    'Register',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(c)
              Container(
                padding: EdgeInsets.all(10),
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: MaterialButton(
                  height: 60,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Get.to(page)
                    Get.to(LoginScreen());
                  },
                  textColor: Colors.white,
                  color: AppColor.primary,
                  child: Text(
                    'Already have an Account',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: MaterialButton(
                        height: 30,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Get.to(page)
                          // Get.to(CheckInScreen());
                        },
                        textColor: Colors.white,
                        color: Colors.black,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Image.asset('assets/icons/facebook.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: MaterialButton(
                        height: 30,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Get.to(page)
                          // Get.to(CheckInScreen());
                        },
                        textColor: Colors.white,
                        color: Colors.black,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Image.asset('assets/icons/google.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: size.width / 1.1,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}
