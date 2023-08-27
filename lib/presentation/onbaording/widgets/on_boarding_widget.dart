import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/resources.dart';
import '../../component/components.dart';

class OnBoardingWidget extends StatelessWidget {
  final String image, title, subtitle;

  const OnBoardingWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: ColorManager.red,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),



            CustomText(
              text: subtitle,
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorManager.greyColor919191,
                  fontSize: 18.sp,
                  fontWeight: FontWeightManager.medium),
            ),
            SizedBox(
              height: 14.h,
            ),
            CustomAssetsImage(
              image: image,
              boxFit: BoxFit.cover,
              height: deviceHeight * 0.40,
              width: double.infinity,
            ),


            //   customText(text: title),
          ],
        ),
      ),
    );
  }
}
