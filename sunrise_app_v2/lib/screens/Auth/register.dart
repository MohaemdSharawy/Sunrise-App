import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';
import 'package:sunrise_app_v2/controllers/auth_controller.dart';
import 'package:sunrise_app_v2/screens/Auth/login.dart';
import 'package:sunrise_app_v2/utilites/general/custom_btn.dart';
import 'package:sunrise_app_v2/utilites/general/custom_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    height: 35,
                  ),
                  Text(
                    'Create an account to enjoy unlimited features and offers',
                    style: AppFont.boldBlack,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: CustomTextInput(
                      controller: _nameController,
                      hintText: 'Enter Your Name',
                      icon: Icons.person,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Name is required');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: CustomTextInput(
                      controller: _emailController,
                      hintText: 'Enter Your Email',
                      icon: Icons.mail,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Email is required');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: CustomTextInput(
                      controller: _phoneController,
                      hintText: 'Enter Your Phone Number',
                      icon: Icons.phone,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Password is required');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: CustomTextInput(
                      controller: _passwordController,
                      hintText: 'Enter Your Password',
                      icon: Icons.lock,
                      isPassword: true,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Password is required');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => (authController.registerLoading.value)
                        ? Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: MaterialButton(
                              height: 60,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await authController.register(
                                    email: _emailController.text,
                                    name: _nameController.text,
                                    password: _passwordController.text,
                                    phone: _phoneController.text,
                                  );
                                }
                                // Get.to(page)
                                // Get.to(CheckInScreen());
                              },
                              textColor: Colors.white,
                              color: AppColor.second,
                              child: Text(
                                'Register',
                                style: AppFont.midThird,
                              ),
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
                        style: AppFont.midThird,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    // margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.6,
                          child: CustomBtn(
                            color: AppColor.second,
                            title: Container(
                              padding: EdgeInsets.all(8),
                              child: Image.asset('assets/icons/facebook.png'),
                            ),
                            action: () => print('faceBook'),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2.6,
                          child: CustomBtn(
                            color: AppColor.second,
                            title: Container(
                              padding: EdgeInsets.all(8),
                              child: Image.asset('assets/icons/google.png'),
                            ),
                            action: () => print('Google'),
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
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword,
      bool isEmail, var valid, var controller) {
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
      child: TextFormField(
        validator: valid,
        controller: controller,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return ('Room Number is required');
        //   }
        // },
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
