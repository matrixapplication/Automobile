import 'package:automobile_project/core/services/responsive/num_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart' as localized;



import '../../../core/resources/resources.dart';
import '../components.dart';

class MyAppbar extends StatelessWidget  {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? titleColor;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final bool isDarkStatusBar;
  final bool hasTitleSpacing;
  final Color backgroundColor;

  const MyAppbar({
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.titleColor,
    this.flexibleSpace,
    this.backgroundColor = ColorManager.white,
    this.centerTitle = false,
    this.isDarkStatusBar = false,
    this.hasTitleSpacing = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomText(
            text: title,
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color:titleColor ?? ColorManager.black,
                fontWeight: FontWeightManager.bold,
                fontSize:  FontSize.s22.sp
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
      shadowColor: ColorManager.primaryColor,
      actions: actions ,

      backgroundColor: backgroundColor ,
      elevation: 0,
      centerTitle: centerTitle,
      titleSpacing: hasTitleSpacing ? AppPadding.p8.w : 0,

      automaticallyImplyLeading: false,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
        isDarkStatusBar ? Brightness.dark : Brightness.light,
        statusBarBrightness:
        isDarkStatusBar ? Brightness.light : Brightness.dark,
      ),
    );

  }

  @override
    Size get preferredSize => Size.fromHeight(70.h);
}
