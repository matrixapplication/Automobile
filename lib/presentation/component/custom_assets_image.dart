import 'package:flutter/material.dart';


class CustomAssetsImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const CustomAssetsImage(
      {required this.image, this.height, this.width, this.boxFit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      // color: Colors.amberAccent,
      image,
      height: height,
      width: width,
      fit: boxFit ,
    );
  }
}
