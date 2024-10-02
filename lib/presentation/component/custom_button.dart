import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../core/resources/resources.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double paddingV = 6;
  final double paddingH = 6;
  final double marginV = 6;
  final double marginH = 6;
  final bool loading;
  final TextStyle? textStyle;

  final bool fullWidth = false;
  final bool shadow = false;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? radius;
 final double? fontSize;
  final VoidCallback? onTap;

  const CustomButton(
      {Key? key,
      this.buttonText,
      this.width,
      this.height,
      this.fontSize,
      this.radius,
      this.textStyle,
      this.borderColor,
      this.padding,
      this.margin,
      this.loading = false,
      this.backgroundColor,
      this.textColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      print(loading) ;
    }
    return TapEffect(
      isClickable: !loading,
      onClick: loading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50.h,
        width: width,
        // padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
          margin: margin,
        decoration: BoxDecoration(

          border: borderColor !=null
              ? Border.all(
                  color: borderColor ??
                      backgroundColor ??
                      Theme.of(context).primaryColor)
              : null,
          boxShadow: const [
            BoxShadow(
                color: ColorManager.greyColorD6D6D6,
                spreadRadius: 1,
                blurRadius: 5), // changes position of shadow
          ],
          color: backgroundColor ?? ColorManager.primaryColor,
          //     gradient: LinearGradient(
          //                         colors: [Color(0xffFD4A51), ColorManager.red, Colors.red],
          //                         begin: Alignment.topCenter,
          //                         end: Alignment.bottomCenter,
          //                       ),
          borderRadius:  BorderRadius.all(
            Radius.circular(radius ?? 14.r),
          ),
        ),
        child:  CustomText(
          textStyle: textStyle ??
              Theme.of(context).textTheme.labelMedium!.copyWith(
                color: textColor ?? Colors.white,
                fontSize:fontSize?? FontSize.s14.sp,
                fontWeight: FontWeightManager.medium,
              ),
          textAlign: TextAlign.center,
          text: buttonText ?? "",
        ),
      ),
    );
  }
}
