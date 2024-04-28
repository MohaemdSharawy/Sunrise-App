import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextInput extends StatelessWidget {
  bool isPassword;
  bool isEmail;
  IconData icon;
  String hintText;
  CustomTextInput({
    required this.hintText,
    required this.icon,
    this.isEmail = false,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
