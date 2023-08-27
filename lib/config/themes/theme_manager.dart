import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/resources/resources.dart';
import '../../core/resources/styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primaryColor,
    fontFamily: FontConstants.fontFamily,
    canvasColor: ColorManager.white,

    //splashColor: ColorManager.w,
    // ripple effect color
    iconTheme: IconThemeData(
      color: ColorManager.black,
      size: 25.w,
    ),
    // card view theme
    cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.colorCode343434,
        elevation: AppSize.s4),
    // app bar theme
    appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.canvasColorFBFBFB,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: ColorManager.colorCode343434,
        ),
        centerTitle: true,
        color: ColorManager.canvasColorFBFBFB,
        elevation: 0,
        shadowColor: ColorManager.colorCode343434,
        titleTextStyle: getBoldStyle(
          fontSize: FontSize.s22,
          color: ColorManager.primaryColor,
        )),
    // button theme
    buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        // disabledColor: ColorManager.colorCode3434341,
        buttonColor: ColorManager.primaryColor,
        splashColor: ColorManager.colorCode343434),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s17), backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    textTheme: TextTheme(
      //As the largest text on the screen, display styles are reserved for short,
      // important text or numerals. They work best on large screens.
      displayLarge: getLightStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s22,
      ),
      //Extremely large text.
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s20,
      ),
      headlineMedium: getSemiBoldStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s18,
      ),
      //text
      //Titles are smaller than headline styles and should be used for shorter, medium-emphasis text.
      titleLarge: getSemiBoldStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s18,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s16,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s14,
      ),
      //label
      //Used for text on ElevatedButton, TextButton and OutlinedButton.
      //Label styles are smaller, utilitarian styles, used for areas of the UI such as text inside of components
      // or very small supporting text in the content body, like captions.
      labelLarge: getMediumStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s14,
      ),
      labelMedium: getMediumStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s12,
      ),
      labelSmall: getMediumStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s11,
      ),
      //body
      // Body styles are used for longer passages of text.
      bodyLarge: getRegularStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.colorCode343434,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.colorCode343434,
      ),
    ),

    backgroundColor: ColorManager.white,

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(

        iconColor: ColorManager.primaryColor,
        // content padding
        // hint style
        hintStyle: getRegularStyle(
            color: ColorManager.colorCode343434, fontSize: FontSize.s17),
        labelStyle: getMediumStyle(
            color: ColorManager.greyColorCBCBCB, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: Colors.red),

        // enabled border style
/*        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(
            Radius.circular(RadiusManager.s14),
          ),
        ),*/

        // focused border style
       /* focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.colorCode343434, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),*/

        // error border style
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.primaryColor, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
