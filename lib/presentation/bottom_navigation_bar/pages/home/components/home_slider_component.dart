import 'package:automobile_project/core/resources/resources.dart';
import 'package:flutter/material.dart';

import '../widgets/slider_widget.dart';

class HomeSliderComponent extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const HomeSliderComponent({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      height: deviceHeight * 0.40,
      width: double.infinity,
      child: BuildSliderComponent(drawerKey: drawerKey),
    );
  }
}
