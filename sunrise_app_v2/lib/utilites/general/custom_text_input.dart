import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';

class CustomTextInput extends StatefulWidget {
  bool isPassword;
  bool isEmail;
  bool only_number;
  bool read_only;
  IconData icon;
  String hintText;
  var valid;
  var controller;
  void Function(String)? onChanged;
  void Function()? onTap;
  CustomTextInput({
    required this.hintText,
    required this.icon,
    this.isEmail = false,
    this.isPassword = false,
    this.only_number = false,
    this.read_only = false,
    this.valid,
    this.controller,
    this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  late bool show_password;
  @override
  void initState() {
    show_password = widget.isPassword;
    super.initState();
  }

  void show_password_toggle() {
    // show_password = widget.isPassword;
    setState(() {
      if (show_password) {
        show_password = false;
      } else {
        show_password = true;
      }
    });
    print(show_password);
  }

  TextInputType get_keyboardType() {
    if (widget.isEmail) {
      return TextInputType.emailAddress;
    }
    if (widget.only_number) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      readOnly: widget.read_only,
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.valid,
      style: TextStyle(color: Colors.black.withOpacity(.8)),
      obscureText: show_password,
      keyboardType: get_keyboardType(),
      decoration: InputDecoration(
        suffixIcon: (widget.isPassword)
            ? IconButton(
                onPressed: () => show_password_toggle(),
                icon: Icon(
                  (show_password) ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppColor.second,
          ),
        ),
        prefixIcon: Icon(
          widget.icon,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintMaxLines: 1,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(.5)),
      ),
      onTap: widget.onTap,
    );
  }
}

// class CustomTextInput extends StatelessWidget {
//   bool isPassword;
//   bool isEmail;
//   IconData icon;
//   String hintText;
//   var valid;
//   var controller;
//   void Function(String)? onChanged;

//   CustomTextInput({
//     required this.hintText,
//     required this.icon,
//     this.isEmail = false,
//     this.isPassword = false,
//     this.valid,
//     this.controller,
//     this.onChanged,
//     super.key,
//   });

//   bool show_password = false;

//   void show_password_toggle() {
//     show_password = !show_password;
//     print(show_password);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return TextFormField(
//       onChanged: onChanged,
//       controller: controller,
//       validator: valid,
//       style: TextStyle(color: Colors.black.withOpacity(.8)),
//       obscureText: isPassword,
//       keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//       decoration: InputDecoration(
//         suffixIcon: (isPassword)
//             ? IconButton(
//                 onPressed: () => show_password_toggle(),
//                 icon: Icon(
//                   Icons.visibility,
//                   color: Colors.grey,
//                 ),
//               )
//             : null,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: AppColor.second,
//           ),
//         ),
//         prefixIcon: Icon(
//           icon,
//           color: Colors.grey,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintMaxLines: 1,
//         hintText: hintText,
//         hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(.5)),
//       ),
//     );
//     // return Container(
//     //   height: 60,
//     //   width: size.width / 1.1,
//     //   alignment: Alignment.center,
//     //   padding: EdgeInsets.only(right: size.width / 30),
//     //   decoration: BoxDecoration(
//     //     color: AppColor.background_card,
//     //     // color: Colors.black.withOpacity(.05),
//     //     borderRadius: BorderRadius.circular(10),
//     //     border: Border.all(
//     //       color: Colors.black.withOpacity(0.3),
//     //     ),
//     //   ),
//     //   child: TextFormField(
//     //     onChanged: onChanged,
//     //     controller: controller,
//     //     validator: valid,
//     //     style: TextStyle(color: Colors.black.withOpacity(.8)),
//     //     obscureText: isPassword,
//     //     keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//     //     decoration: InputDecoration(
//     //       prefixIcon: Icon(
//     //         icon,
//     //         color: Colors.grey,
//     //       ),
//     //       border: InputBorder.none,
//     //       hintMaxLines: 1,
//     //       hintText: hintText,
//     //       hintStyle:
//     //           TextStyle(fontSize: 14, color: Colors.grey.withOpacity(.5)),
//     //     ),
//     //   ),
//     // );
//   }
// }
