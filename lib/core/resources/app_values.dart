import 'package:flutter/material.dart';

final Size size =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
final double deviceHeight = size.height;
final double deviceWidth = size.width;

class AppMargin {
  static const double m2 = 2.0;
  static const double m4 = 4.0;
  static const double m6 = 6.0;
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double p1 = 1.0;
  static const double p2 = 2.0;
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
}

class AppSize {
  static const double s1_3 = 1.3;
  static const double s1 = 1;
  static const double s1_5 = 1.5;
  static const double s2 = 2;
  static const double s3 = 3;
  static const double s4 = 4.0;
  static const double s5 = 5.0;
  static const double s8 = 8.0;
  static const double s7 = 7.0;
  static const double s12 = 12.0;
  static const double s10 = 10.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s25 = 25.0;
  static const double s30 = 30.0;
  static const double s42 = 42.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s75 = 75.0;
  static const double s100 = 100.0;
}

class RadiusManager {

  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s10 = 10.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s25 = 25.0;
  static const double s50 = 50.0;
}

class Time {
  static const Duration t300 = Duration(milliseconds: 300);
  static const Duration t700 = Duration(milliseconds: 700);
  static const Duration t2000 = Duration(milliseconds: 2000);
  static const Duration longTime = Duration(minutes: 10);
}
