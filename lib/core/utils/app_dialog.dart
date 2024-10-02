import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/navigation/navigation.dart';
import '../../presentation/component/custom_button.dart';
import '../../presentation/component/custom_text.dart';
import '../resources/resources.dart';
import '../resources/spaces.dart';
import 'base_platform_widget.dart';

class AppDialog extends BasePlatformWidget<AlertDialog, CupertinoAlertDialog> {
  final IconData? icon;
  final Color? confirmTextColor;
  final String? alertDescription;
  final String? alertTitle;
  final VoidCallback onConfirm;
  final String confirmText;
  final bool withClose;

  const AppDialog({
    this.icon,
    required this.confirmTextColor,
    required this.withClose,
    this.alertTitle,
    this.alertDescription,
    required this.onConfirm,
    required this.confirmText,
    Key? key,
  }) : super(key: key);

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    print(withClose);
    return CupertinoAlertDialog(
      content: Column(
        children: [
          Icon(icon, size: 50.h, color: confirmTextColor),
          const VerticalSpace(16),
          CustomText(
              text: alertDescription,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorManager.black)),
          const VerticalSpace(32),
          CustomButton(
            buttonText: confirmText,
            textColor: confirmTextColor,
            backgroundColor: ColorManager.primaryColor,
            onTap: () {
              NavigationService.goBack(context);
              onConfirm();
            },
          ),
          const VerticalSpace(AppSize.s14),
          withClose
              ? CustomButton(
            buttonText: confirmText,
            textColor: confirmTextColor,
            backgroundColor: ColorManager.primaryColor,
            onTap: () {
              NavigationService.goBack(context);
              onConfirm();
            },
          )
              : const SizedBox(),
        ],
      ),
    );
  }

  AlertDialog createOfferRequestWidget(BuildContext context) {
    print(withClose);
    return
      AlertDialog(
      content: Column(
        children: [
          Icon(icon, size: 50.h, color: confirmTextColor),
          const VerticalSpace(16),
          CustomText(
              text: alertDescription,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorManager.black)),
          const VerticalSpace(32),
          CustomButton(
            buttonText: confirmText,
            textColor: confirmTextColor,
            backgroundColor: ColorManager.primaryColor,
            onTap: () {
              NavigationService.goBack(context);
              onConfirm();
            },
          ),
          const VerticalSpace(AppSize.s14),
          withClose
              ? CustomButton(
            buttonText: confirmText,
            textColor: confirmTextColor,
            backgroundColor: ColorManager.primaryColor,
            onTap: () {
              NavigationService.goBack(context);
              onConfirm();
            },
          )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(icon, size: 50.h, color: ColorManager.primaryColor)
              : const SizedBox(),
          icon != null ? const VerticalSpace(AppSize.s16) : const SizedBox(),
          alertTitle != null
              ? Align(
            alignment: shared!.getString("lang") == "ar" ? Alignment.centerRight  : Alignment.centerLeft,
            child: CustomText(
                text: alertTitle,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.black)),
          )
              : const SizedBox(),

          const VerticalSpace(20),

          alertDescription != null
              ? CustomText(
              text: alertDescription,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.black),textAlign: TextAlign.center,)
              : const SizedBox(),
          const VerticalSpace(20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  height: 50.h,
                  radius: 8.r,
                  buttonText: confirmText,
                  textColor: confirmTextColor ?? ColorManager.white,
                  backgroundColor: ColorManager.primaryColor,
                  onTap: () {
                    NavigationService.goBack(context);
                    onConfirm();
                  },
                ),
              ),
              const HorizontalSpace(15),
              withClose
                  ? Expanded(
                child: CustomButton(
                  height: 50.h,
                  radius: 8.r,
                  buttonText: "إلغاء",
                  textColor: ColorManager.white,
                  backgroundColor: ColorManager.primaryColor,
                  onTap: () {
                    NavigationService.goBack(context);
                    onConfirm();
                  },
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
