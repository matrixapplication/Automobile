import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationChecker {
  static changeLanguage(BuildContext context) {
    Locale? currentLocal = context.locale;
    if (currentLocal == const Locale('en', 'US')) {
      context.setLocale(const Locale("ar" , "EG")) ;
    } else {
      context.setLocale(const Locale("en" , "US")) ;

    }
  }
}