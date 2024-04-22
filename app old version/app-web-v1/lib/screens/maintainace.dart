// ignore: unused_import
// ignore_for_file: deprecated_member_use

// import 'package:e_signatrue/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutx/flutx.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  // late ThemeData theme;

  @override
  void initState() {
    super.initState();
    // customTheme = AppTheme.customTheme;
    // theme = AppTheme.theme;
  }

  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor: theme.backgroundColor,
        body: Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/maintenance.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: Text("We will be back soon"),
          ),
          Container(
            margin: EdgeInsets.only(left: 56, right: 56, top: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                    "This Module Under Maintenance . We'll be back soon, Thanks for your patience!"),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
