import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sunrise_app_v2/constant/app_colors.dart';

class ImageCustom extends StatefulWidget {
  String image;
  double height;
  double width;
  BoxFit? fit;
  int radius;
  bool openImage;
  ImageCustom({
    required this.image,
    required this.height,
    required this.width,
    this.fit,
    this.radius = 0,
    this.openImage = true,
    super.key,
  });

  @override
  State<ImageCustom> createState() => _ImageCustomState();
}

class _ImageCustomState extends State<ImageCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.openImage) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(
              image: widget.image,
            );
          }));
        }
      },
      child: Image.network(
        widget.image,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        // alignment: Alignment.center,
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.width - 150,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: AppColor.primary,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? image;
  DetailScreen({required this.image, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: PhotoView(
              imageProvider: NetworkImage(image!),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.second,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.close, size: 20.0, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
