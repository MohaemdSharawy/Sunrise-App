import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sunrise_app_v2/utilites/general/image_handel.dart';

class CustomGalleryView extends StatelessWidget {
  List images;
  CustomGalleryView({required this.images, super.key});

  int check({required int input}) {
    int count = input % 2;
    return count;
  }

  int get_cell_count() {
    return 10;
  }

  double getMainAxisCellCount({required int number}) {
    if (check(input: number) == 0) {
      if (images.length == number) {
        return 1.5;
      }
      return 4;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 2 / 9,
      crossAxisSpacing: 4,
      children: List.generate(
        images.length,
        (index) => StaggeredGridTile.count(
          crossAxisCellCount:
              (index + 1 == images.length && check(input: index + 1) == 0)
                  ? 4
                  : 2,
          mainAxisCellCount: getMainAxisCellCount(number: index + 1),
          child: Container(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ImageCustom(
                image: images[index],
                fit: BoxFit.cover,
                height: 300,
                width: 100,
              ),
            ),
          ),
          // Image.network(images[index]),
        ),
      ),
    );
  }
}
