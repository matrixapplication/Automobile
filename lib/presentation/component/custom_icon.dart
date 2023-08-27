

import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../core/resources/resources.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double size;

  const CustomIcon(
      this.icon, {
        this.color,
        this.size = AppSize.s42,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size.sp,
    );
  }
}
