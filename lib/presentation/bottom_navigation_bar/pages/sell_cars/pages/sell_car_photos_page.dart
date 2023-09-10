import 'dart:io';

import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../data/provider/local_auth_provider.dart';
import '../../../../../domain/entities/add_car_entity/add_car_entity.dart';
import '../../../../component/app_widgets/my_app_bar.dart';
import '../../../../component/components.dart';
import '../../../../component/custom_button.dart';
import '../view_model/show_room_sell_car_view_model.dart';

class SellCarPhotosPage extends StatefulWidget {
  final SellCarEntity carData;

  const SellCarPhotosPage({Key? key, required this.carData}) : super(key: key);

  @override
  State<SellCarPhotosPage> createState() => _SellCarPhotosPageState();
}

class _SellCarPhotosPageState extends State<SellCarPhotosPage> {
  File? mainImage;
  List<File?> images = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final localAuthProvider =
        Provider.of<LocalAuthProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.sellCar),
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,

        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: Icon(
              Icons.arrow_forward_ios ,
              color: ColorManager.white,
              textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: translate(LocaleKeys.photosMax),
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.greyColor919191)),
              const VerticalSpace(15),
              CustomText(
                  text: translate(LocaleKeys.addMainImage),
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.greyColor919191)),
              const VerticalSpace(5),
              TapEffect(
                onClick: () async {
                  final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      mainImage = File(pickedFile.path);
                      print("courseImage =>${pickedFile.path.split("/").last}");
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: deviceHeight * 0.15,
                  decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: mainImage != null
                      ? Image.file(
                          File(
                            mainImage!.path,
                          ),
                          fit: BoxFit.cover)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(Icons.image,
                                  color: ColorManager.blueColor, size: 100.h),
                              CustomText(
                                  text: translate(LocaleKeys.addMainImage),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                          color: ColorManager.blueColor)),
                            ]),
                ),
              ),
              const VerticalSpace(20),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2 / 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                    ),
                    itemCount: images.length + 1,
                    itemBuilder: (ctx, index) {
                      if (index < images.length) {
                        return Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Container(
                                  height: 200.h,
                                  width : double.infinity ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: ColorManager.blueColor,
                                    ),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.file(
                                          File(
                                            images[index]?.path ?? "",
                                          ),
                                          fit: BoxFit.fill))),
                            ) ,
                            Align(
                              alignment: Alignment.topRight,
                              child: TapEffect(onClick: (){
                                setState(() {
                                  images.removeAt(index) ;
                                });

                              }  , child:  Container(
                                height :40.h ,
                                width : 40.h ,
                                decoration: const BoxDecoration(
                                  color: ColorManager.primaryColor ,
                                  shape: BoxShape.circle ,

                                ),
                                child: Icon(Icons.delete , size: 30.h, color: ColorManager.white,),
                              )),
                            )
                          ],
                        );
                      } else {
                        return TapEffect(
                          onClick: () async {
                            final XFile? pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              setState(() {
                                //firstImage = File(pickedFile.path);
                                images.add(File(pickedFile.path));
                                if (kDebugMode) {
                                  print(
                                    "courseImage =>${pickedFile.path.split("/").last}");
                                }
                              });
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Container(
                                height: 100.h,
                                width: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: ColorManager.blueColor,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 50.h,
                                  color: ColorManager.blueColor,
                                )),
                          ),
                        );
                      }
                    }),
              ),
              const VerticalSpace(10),
              Center(
                  child: CustomButton(
                      buttonText:translate(LocaleKeys.postAd),
                      onTap: () {
                        if (images.isEmpty || mainImage ==null) {
                          Alerts.showAppDialog(context,
                              alertTitle:translate(LocaleKeys.alert) ,
                              alertDescription:
                                  translate(LocaleKeys.carImageMissData),
                              onConfirm: () {},
                              confirmText: translate(LocaleKeys.ok),
                              withClose: false,
                              confirmTextColor: ColorManager.white);
                        } else {
                          Provider.of<ShowRoomSellCarViewModel>(context,
                              listen: false)
                              .sellCar(
                              context: context,
                              carData: widget.carData,
                              images: images,
                              mainImage: mainImage!);
                         NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
                          Alerts.showAppDialog(context,
                              alertTitle: translate(LocaleKeys.alert),
                              alertDescription: translate(LocaleKeys.adSuccess),
                              onConfirm: () {},
                              confirmText: translate(LocaleKeys.ok),
                              withClose: false,
                              confirmTextColor: ColorManager.white);

                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
