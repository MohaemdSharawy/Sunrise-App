import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tucana/screens/history_scrren.dart';
import 'package:tucana/screens/welcome_screen.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return (GetStorage().read('room_num') != '')
        ? PopupMenuButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            color: Colors.black,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Text(
                      "${GetStorage().read('title')} ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      GetStorage().read('full_name'),
                      style: TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "room : ${GetStorage().read('room_num').toString()}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: Row(
                  children: [
                    Text(
                      "History",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Text(
                        "Log out",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ],
            onSelected: (result) {
              if (result == 3) {
                GetStorage().remove('firstname');
                GetStorage().remove('lastname');
                GetStorage().remove('title');
                GetStorage().remove('room_num');
                GetStorage().remove('lang');
                GetStorage().remove('departure');
                Get.to(WelcomeScreen());
              }
              if (result == 5) {
                var hotel = GetStorage().read('h_id');
                Navigator.pushNamed(context, '/history/${hotel}');
              }
            },
          )
        : Container();
  }
}
