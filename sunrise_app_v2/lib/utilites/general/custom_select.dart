import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';
import 'package:sunrise_app_v2/constant/app_font.dart';

class CustomDropdownSelect extends StatefulWidget {
  var valid;
  SingleValueDropDownController controller;
  List<DropDownValueModel> option;
  CustomDropdownSelect(
      {required this.controller, required this.option, this.valid, super.key});

  @override
  State<CustomDropdownSelect> createState() => _CustomDropdownSelectState();
}

class _CustomDropdownSelectState extends State<CustomDropdownSelect> {
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      validator: widget.valid,
      listTextStyle: AppFont.smallBoldBlack,
      controller: widget.controller,
      textFieldDecoration: InputDecoration(
        hintText: 'Select Your Resort',
        hintStyle: AppFont.smallBoldBlack,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppColor.second,
          ),
        ),
      ),
      enableSearch: true,
      searchDecoration: InputDecoration(
        hintText: "Find Your Hotel",
        hintStyle: AppFont.tinyGrey,
      ),
      dropDownItemCount: 5,
      dropDownList: widget.option,
    );
  }
}