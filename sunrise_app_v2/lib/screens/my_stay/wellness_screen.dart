import 'package:flutter/material.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WellnessScreen'),
    );
  }
}
