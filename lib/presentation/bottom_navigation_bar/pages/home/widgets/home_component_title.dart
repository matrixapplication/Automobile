import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/font_manager.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../component/components.dart';

class HomeComponentTitle extends StatelessWidget {
  final String title;
  final bool isSeeAll;
  final VoidCallback? onTap;

  const HomeComponentTitle({
    required this.title,
    this.isSeeAll = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      color: ColorManager.white,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r) ,
              border: Border.all(color: ColorManager.primaryColor) ,
            ),
            child: CustomText(
              text: title,
              textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: ColorManager.primaryColor
              ),
            ),
          ),
          isSeeAll ? const Spacer() : const SizedBox(),
          isSeeAll
              ? TapEffect(
                  onClick: () {
                    onTap!();
                  },
                  child: CustomText(
                    text: translate(LocaleKeys.seeAll),
                    textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: ColorManager.red,
                        fontWeight: FontWeightManager.medium),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
