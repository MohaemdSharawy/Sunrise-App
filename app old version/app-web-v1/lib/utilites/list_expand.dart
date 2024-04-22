import 'package:flutter/material.dart';
import 'package:tucana/utilites/my_toast.dart';
import 'package:flutter_html/flutter_html.dart';

class ListExpandAdapter {
  List itemsTile = <ItemTile>[];

  var item;

  var hotel_service;

  ListExpandAdapter(this.item, this.hotel_service) {
    for (var i = 0; i < this.item.length; i++) {
      itemsTile.add(ItemTile(
        index: i,
        object: this.item,
        hotel_service: this.hotel_service,
      ));
    }
  }
  Widget getView() {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => itemsTile[index],
        itemCount: itemsTile.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  var object;
  var index;
  var hotel_service;
  ItemTile({
    Key? key,
    required this.index,
    required this.object,
    this.hotel_service,
  }) : super(key: key);

  Map icon_list = {
    'wifi': Icons.wifi,
    'person': Icons.person_pin_rounded,
    'room_service': Icons.room_service_rounded,
    'menu_outlined': Icons.menu_outlined,
    'laundry': Icons.local_laundry_service_rounded,
    'multiline_chart': Icons.multiline_chart,
    'car_rental': Icons.car_rental,
    'atm': Icons.local_atm_outlined,
    'parking': Icons.local_parking,
    'gift': Icons.card_giftcard,
  };

  @override
  Widget build(BuildContext context) {
    print(this.hotel_service);
    return Column(
      children: <Widget>[
        ExpansionTile(
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          // leading: Container(
          //     child: CircleAvatar(
          //       backgroundImage: AssetImage(object.image),
          //     ),
          //     width: 35,
          //     height: 35),
          key: PageStorageKey<int>(index),
          title: Text(
            object[index].info!,
            style: TextStyle(color: Colors.white),
          ),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(45))),
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: (object[index].id != "0")
                    ? Html(
                        data: object[index].description,
                        style: {
                          "body": Style(color: Colors.white),
                        },
                      )
                    : Column(
                        children: [
                          for (var service in hotel_service)
                            HotelService(
                              icon: Icon(
                                icon_list[service.icon] ?? Icons.menu_open,
                                // Icons.menu,
                                color: Colors.white,
                                size: 20,
                              ),
                              text: service.name,
                            )
                        ],
                      )
                //   textAlign: TextAlign.justify,
                // ),
                )
          ],
        ),
        Divider(height: 0)
      ],
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
    MyToast.show(action + " clicked", context);
  }
}

class HotelService extends StatelessWidget {
  Icon icon;
  String text;
  HotelService({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(children: [
        icon,
        Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
      ]),
    );
  }
}
