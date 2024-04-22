import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/pms_controller.dart';

class LoginConfirmation extends StatefulWidget {
  var confirmation;
  var h_id;
  LoginConfirmation({this.confirmation, this.h_id, super.key});

  @override
  State<LoginConfirmation> createState() => _LoginConfirmationState();
}

class _LoginConfirmationState extends State<LoginConfirmation> {
  final pmsController = Get.put(PmsController());
  @override
  check_confirmation() async {
    await pmsController.login_confirmation(
      hotel_id: widget.h_id.toString(),
      confirmation_no: widget.confirmation.toString(),
      context: context,
    );
  }

  void initState() {
    check_confirmation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
