import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../presentation/component/components.dart';
import '../resources/resources.dart';
import 'app_dialog.dart';
class Alerts {
  static void showSnackBar(
      BuildContext context,
      String message, {
        bool forError = true,
        Duration duration = Time.t2000,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: forError ? Colors.red : ColorManager.white,
        content: CustomText(text:message,textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: ColorManager.white, fontSize: FontSize.s14
        ), )/*CustomText(message,
            color: ColorManager.white, fontSize: FontSize.s14)*/,
      ),
    );
  }

  static void showActionSnackBar(
      BuildContext context, {
        required String message,
        required String actionLabel,
        required VoidCallback onActionPressed,
        Duration duration = Time.longTime,
      })

  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: duration,
            backgroundColor: ColorManager.black,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(AppPadding.p16.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s8.r)),
            action: SnackBarAction(
                label: actionLabel,
                onPressed: onActionPressed,
                textColor: ColorManager.white),
            content:

            CustomText(text:message,textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ColorManager.white, fontSize: FontSize.s14
            ),
            )
        ));
  }

  static void showToast(
      String message, [
        Toast length = Toast.LENGTH_SHORT,
        ToastGravity toastGravity = ToastGravity.BOTTOM,
      ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s16.sp,
    );
  }

  static void showAppDialog(
      BuildContext context, {
        String? alertDescription,
        String? alertTitle,
        required VoidCallback onConfirm,
        required String confirmText,
        IconData? icon,
        required Color? confirmTextColor,
        bool? withClose = true,
      }) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
          alertDescription: alertDescription,
          alertTitle:  alertTitle,
          withClose: withClose!,
          confirmTextColor: confirmTextColor,
          icon: icon,
          confirmText: confirmText,
          onConfirm: onConfirm),
    );
  }

}
