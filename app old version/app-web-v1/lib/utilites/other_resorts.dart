import 'package:flutter/material.dart';
import 'package:tucana/utilites/my_toast.dart';
import 'package:flutter_html/flutter_html.dart';

class OtherResorts {
  List itemsTile = <ItemTile>[];

  var item;

  OtherResorts(this.item) {
    for (var i = 0; i < this.item.length; i++) {
      itemsTile.add(ItemTile(index: i, object: this.item));
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

  ItemTile({
    Key? key,
    required this.index,
    required this.object,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            object[index]['name']!,
            style: TextStyle(color: Colors.white),
          ),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(45))),
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.black,
                child: InkWell(
                  child: Text(object[index]['name']),
                  onTap: () {
                    // print(object[index].id);
                  },
                ))
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
