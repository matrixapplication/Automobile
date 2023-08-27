import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';

class HomeCarsCategoriesComponent extends StatelessWidget {
  HomeCarsCategoriesComponent({
    Key? key,
  }) : super(key: key);
  final List<String> carStatus = [translate(LocaleKeys.newCars), translate(LocaleKeys.usedCars), translate(LocaleKeys.guaranteCars)];
  final List<String> carStatusIcons = [
    AssetsManager.wheelIcon,
    AssetsManager.wheelIcon,
    AssetsManager.sedanIcon
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          height: 90.h,
          //  color: ColorManager.greyColorCBCBCB,
          child: Row(
            children: [
              CarTypesTap(carStatus: carStatus, index: 0),
              CarTypesTap(carStatus: carStatus, index: 1),
              CarTypesTap(carStatus: carStatus, index: 2),
            ],
          )),
    );
  }
}

class CarTypesTap extends StatelessWidget {
  const CarTypesTap({
    Key? key,
    required this.carStatus,
    required this.index,
  }) : super(key: key);

  final List<String> carStatus;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: TapEffect(
          onClick: () {
            if (index == 0) {
              NavigationService.push(context, Routes.latestNewCarPage);
            } else if (index == 1) {
              NavigationService.push(context, Routes.usedCarsPage);
            } else {
              NavigationService.push(context, Routes.guaranteeCarPage);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: index == 0
                    ? ColorManager.orange
                    : index == 1
                    ? Colors.blue
                    : ColorManager.orangeFEA31B,
                borderRadius: BorderRadius.circular(12.r)),
            width: deviceWidth * 0.31,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 3.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvgImage(
                      color: ColorManager.white,
                      image: index == 2
                          ? AssetsManager.hatchbackIcon
                          : AssetsManager.wheelIcon,
                    ),
                    CustomText(
                      text: carStatus[index],
                      textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorManager.white,
                          fontWeight: FontWeightManager.semiBold),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
