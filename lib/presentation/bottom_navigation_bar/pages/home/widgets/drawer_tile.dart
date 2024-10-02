import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../../../../component/custom_icon.dart';

class DrawerTile extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
  final String title;
  final VoidCallback onTap;
 final Color? color;
  const DrawerTile(
      { this.icon,
      required this.title,
      required this.onTap,
       this.color,
       this.svgIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
      Container(
        decoration: BoxDecoration(
          color: color,
         border:color!=null? Border.all(color: Colors.red):null
        ),
        child:  Padding(
          padding: EdgeInsets.all(8.h),
          child: Row(
            children: [
              svgIcon==null? CustomIcon(icon, color: ColorManager.primaryColor,size: 30.w,):CustomSvgImage(image: svgIcon!,color: ColorManager.primaryColor,width: 30.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomText(
                  text: title,
                ),)
            ],
          ),
        ),
      )


    );
  }
}
