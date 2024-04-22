import 'package:flutter/material.dart';
import 'package:tucana/utilites/img.dart';

class LoadingScreen extends StatelessWidget {
  String img_name;
  LoadingScreen({required this.img_name, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Img.get(img_name),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
        Center(
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
