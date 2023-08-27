import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final double? size  ;

  const MyProgressIndicator(
      {super.key,
       this.width,
       this.height,
       this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height?.h,
        width: width?.h,
        child:  LoadingAnimationWidget.staggeredDotsWave(
          color: color  ?? ColorManager.primaryColor,
          size: size ?? 60,

        ),);
  }
}
