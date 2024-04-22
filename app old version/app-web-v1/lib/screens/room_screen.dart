import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucana/utilites/img.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  List tap_name = ['Room Controls', 'Room Requests'];
  List tap_icon = [
    'assets/icons/Room Controls.png',
    'assets/icons/Room Requests.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Img.get('roomCover.png'),
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7)),
        Container(
          padding: const EdgeInsets.only(left: 11, right: 11, top: 150),
          child: GridView.builder(
            itemCount: 2,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 35,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    // print(tap_screen[index]);
                    // Get.to(LetUsKnowScreen());
                  },
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text('test', style: TextStyle(fontSize: 19)),
                        Image.asset(
                          tap_icon[index],
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(tap_name[index],
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Container(
          padding: EdgeInsets.only(top: 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/Room.png',
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Rooms & Suites',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),

        //
        Container(
            height: kToolbarHeight,
            child: AppBar(
                backgroundColor: Colors.transparent,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ]))
      ],
    );
  }
}
