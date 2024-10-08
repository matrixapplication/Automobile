import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  final bool isSliver;

  const VerticalSpace(this.height, {Key? key})
      : isSliver = false,
        super(key: key);

  const VerticalSpace.sliver(this.height, {Key? key})
      : isSliver = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSliver
        ? SliverToBoxAdapter(child: SizedBox(height: height.h))
        : SizedBox(height: height.h);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double width;
  final bool isSliver;

  const HorizontalSpace(this.width, {Key? key})
      : isSliver = false,
        super(key: key);

  const HorizontalSpace.sliver(this.width, {Key? key})
      : isSliver = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSliver
        ? SliverToBoxAdapter(child: SizedBox(width: width.w))
        : SizedBox(width: width.w);
  }
}
