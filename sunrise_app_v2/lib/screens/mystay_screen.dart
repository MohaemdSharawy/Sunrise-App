import 'package:flutter/material.dart';

class MyStayScreen extends StatefulWidget {
  const MyStayScreen({super.key});

  @override
  State<MyStayScreen> createState() => _MyStayScreenState();
}

class _MyStayScreenState extends State<MyStayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('My Stay Screen'),
        ),
      ),
    );
  }
}
