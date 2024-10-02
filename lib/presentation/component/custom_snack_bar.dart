import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../config/navigation/navigation_services.dart';
import '../../config/navigation/routes.dart';
import '../../core/resources/app_assets.dart';
import '../../core/resources/app_colors.dart';
import '../../translations/local_keys.g.dart';
import 'custom_button.dart';
import 'custom_text.dart';

void showCustomSnackBar( {required String message,required BuildContext context,bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    content: Text(message,style: const TextStyle(color: Colors.white),),
  ));
}
void loginDialog(BuildContext context){
  showDialog(context: context, builder: (context){
    return   AlertDialog(
        content:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Image.asset(AssetsManager.appLogo),
            SizedBox(
              height: 35.h,
            ),
            CustomText(
                text: 'Please Login',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: ColorManager.black,fontWeight: FontWeight.bold,fontSize: 20)),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
              buttonText: translate(LocaleKeys.login),
              textColor: ColorManager.white,
              backgroundColor: ColorManager.primaryColor,
              onTap: () {
                NavigationService.push(context, Routes.loginScreen);
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(
              buttonText: translate(LocaleKeys.cancel),
              textColor: ColorManager.white,
              backgroundColor: ColorManager.primaryColor,
              onTap: () {
                Navigator.of(context).pop() ;
              },
            ),


          ],
        ),
    );
  });

}