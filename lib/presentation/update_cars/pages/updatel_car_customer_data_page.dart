import 'dart:io';

import 'package:automobile_project/core/resources/spaces.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/custom_text.dart';
import 'package:automobile_project/presentation/component/custom_text_field.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../domain/entities/add_car_entity/add_car_entity.dart';


class UpdateCarCustomerDataPage extends StatefulWidget {
  final SellCarEntity carData;
  final List<File?> images;
  final File? mainImage;

  const UpdateCarCustomerDataPage(
      {Key? key,
      required this.carData,
      required this.mainImage,
      required this.images})
      : super(key: key);

  @override
  State<UpdateCarCustomerDataPage> createState() =>
      _UpdateCarCustomerDataPageState();
}

class _UpdateCarCustomerDataPageState extends State<UpdateCarCustomerDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: "Update Your Car",
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.black,
            )),
      )),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    topLeft: Radius.circular(30.r)),
                color: ColorManager.greyColorF4F4F4),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(20),
                  CustomText(
                      text: "Name",

                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeightManager.semiBold)),

                  const VerticalSpace(10),
                  //Name
                  CustomTextField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return StringsManager.required;
                      }
                      return null;
                    },
                    contentVerticalPadding: 17.h,

                    // controller: _emailController,
                    hintText: "Name",
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    borderColor: ColorManager.greyColorCBCBCB,
                    borderRadius: 15.r,
                  ),

                  const VerticalSpace(20),
                  CustomText(
                      text: "Mobile Number",
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeightManager.semiBold)),
                  const VerticalSpace(10),
                  //Mobile Number
                  CustomTextField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return StringsManager.required;
                      }
                      return null;
                    },

                    contentVerticalPadding: 17.h,


                    // controller: _emailController,
                    hintText: "Mobile Number",
                    textInputType: TextInputType.phone,
                    maxLine: 1,
                    borderColor: ColorManager.greyColorCBCBCB,
                    borderRadius: 15.r,
                  ),

                  const VerticalSpace(20),
                  CustomText(
                      text: "Your email (Optional)",
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeightManager.semiBold)),
                  const VerticalSpace(10),
                  //Your email
                  CustomTextField(
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return StringsManager.required;
                      }
                      return null;
                    },
                    contentVerticalPadding: 17.h,


                    // controller: _emailController,
                    hintText: "Your email",
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    borderColor: ColorManager.greyColorCBCBCB,
                    borderRadius: 15.r,
                  ),

                  const VerticalSpace(30),
                  Center(
                      child: CustomButton(
                        buttonText: "Post Ad",
                        onTap: () {
                          if(kDebugMode){
                            print(widget.carData);
                            print(widget.images);
                            print(widget.mainImage!);
                          }
                          Provider.of<ShowRoomSellCarViewModel>(context,
                              listen: false)
                              .sellCar(
                              context: context,
                              carData: widget.carData,
                              images: widget.images,
                              mainImage: widget.mainImage!);
                           NavigationService.push(context, Routes.bottomNavigationBar);
                        },
                      )),
                  const VerticalSpace(30),
                ],
              ),
            )),
      ),
    );
  }
}
