import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



String translate(String word) {
  return word.tr();
}
class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      this.textStyle,
      required this.text,
      this.textAlign,
      this.overflow,
      this.maxLines})
      : super(key: key);
  final String? text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? textStyle;


  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.titleSmall,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
