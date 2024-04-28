import 'package:flutter/material.dart';
import 'package:sunrise_app_v2/utilites/general/custom_header.dart';

class ResortsScreen extends StatefulWidget {
  const ResortsScreen({super.key});

  @override
  State<ResortsScreen> createState() => _ResortsScreenState();
}

class _ResortsScreenState extends State<ResortsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(),
              Center(
                child: Text('Booking Screen'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
