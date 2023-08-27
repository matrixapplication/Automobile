import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/resources/app_values.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:flutter/material.dart';


class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:  MyAppbar(
          title: "Settings",
          centerTitle: true,
          titleColor: ColorManager.white,
          backgroundColor: ColorManager.primaryColor,
          leading: TapEffect(
              onClick: () {
                NavigationService.goBack(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.white,
              )),
        ),

      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ) ,
          SizedBox(
            width: deviceWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: "Language: " , textStyle: Theme.of(context).textTheme.titleLarge,) ,
                CustomButton(
                  buttonText: "Ar",
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorManager.white),
                  height: 40.h,
                  padding: EdgeInsets.all(15.h) ,
                  radius: 15.r,
                  width: 150.w,
                  backgroundColor: ColorManager.primaryColor,
                ) ,
                CustomButton(
                  buttonText: "En",
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorManager.white),
                  height: 40.h,
                  padding: EdgeInsets.all(15.h) ,
                  width: 150.w,
                  radius: 15.r,
                  backgroundColor: ColorManager.primaryColor,
                ) ,
              ],
            ),
          )
        ],
      ),
    );
  }
}
