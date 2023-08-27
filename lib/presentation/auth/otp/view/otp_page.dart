import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/resources/resources.dart';
import '../../../../translations/local_keys.g.dart';
import '../../../component/components.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const VerticalSpace(AppSize.s75),
          Center(
            child: CustomAssetsImage(
              image: AssetsManager.appLogo,
              //height: 120.h,
              boxFit: BoxFit.fill,
              width: deviceWidth * 0.55,
            ),
          ),
          const VerticalSpace(AppSize.s75),
          CustomText(
            text:  translate(LocaleKeys.verification),
            textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                  height: 0.8,
                  color: ColorManager.lightBlack,
                  fontWeight: FontWeightManager.light,
                  fontSize: FontSize.s28.sp,
                ),
          ),
          const VerticalSpace(AppSize.s75),
          CustomText(
            text:  translate(LocaleKeys.ConfirmationCodeHasBeenSentTo),
            textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                  height: 0.8,
                  color: ColorManager.greyColor919191,
                  fontWeight: FontWeightManager.light,
                  //fontSize: FontSize.s28.sp,
                ),
          ),
          const VerticalSpace(AppSize.s20),
          CustomText(
            text: "0100 0000 000",
            textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                  height: 0.8,
                  color: ColorManager.lightBlack,
                  fontWeight: FontWeightManager.light,
                  //fontSize: FontSize.s28.sp,
                ),
          ),
          const VerticalSpace(AppSize.s75),
          OTPTextField(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: ColorManager.greyColorF4F4F4,
                borderColor: ColorManager.greyColorF4F4F4,
                focusBorderColor: ColorManager.red,
              ),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: ColorManager.red),
              onChanged: (pin) {
                print("Changed: $pin");
              },
              onCompleted: (pin) {
               NavigationService.push(context, Routes.bottomNavigationBar);
              }),
        ],
      ),
    );
  }
}
