
import 'package:automobile_project/presentation/component/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/resources/resources.dart';

class CustomShimmerImage extends StatelessWidget {
  const CustomShimmerImage({
    Key? key,
    this.height,
    this.width,
    this.boxFit,
    this.topRight = 0,
    this.topLeft = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
    required this.image,
  }) : super(key: key);

  final String image;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final double topRight;
  final double topLeft;
  final double bottomLeft;
  final double bottomRight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(topRight),
        topLeft: Radius.circular(topLeft),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),

      ),

      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.cover,
        imageUrl: image,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[600]!,
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: ColorManager.greyColorCBCBCB,
              // shape: BoxShape.circle
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            const CustomAssetsImage(image: AssetsManager.appLogo,boxFit: BoxFit.contain),
      ),
    );
  }
}
