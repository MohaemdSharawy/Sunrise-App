import 'package:flutter/material.dart';

class CustomValidateInput extends StatelessWidget {
  const CustomValidateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) {
          if (value != null && value.trim().length < 3) {
            return 'This field requires a minimum of 3 characters';
          }

          return null;
        },
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            labelText: 'Enter Your Name',

            // This is the normal border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            // This is the error border
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 3))),
      ),
    );
  }
}
