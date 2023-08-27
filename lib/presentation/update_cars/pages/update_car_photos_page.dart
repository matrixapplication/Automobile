import 'dart:io';

import 'package:automobile_project/core/resources/spaces.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/custom_snack_bar.dart';
import 'package:automobile_project/presentation/component/custom_text.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../data/provider/local_auth_provider.dart';
import '../../../../../domain/entities/add_car_entity/add_car_entity.dart';


class UpdateCarPhotosPage extends StatefulWidget {
  final SellCarEntity carData;
  final List? oldImages ;
  final String? oldMainImage  ;
  final int id ;

  const UpdateCarPhotosPage({Key? key, required this.carData, this.oldImages, this.oldMainImage, required this.id}) : super(key: key);

  @override
  State<UpdateCarPhotosPage> createState() => _UpdateCarPhotosPageState();
}

class _UpdateCarPhotosPageState extends State<UpdateCarPhotosPage> {
  File? mainImage;
  List<File?> images = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final localAuthProvider =
        Provider.of<LocalAuthProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.uploadCar),
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,

        centerTitle: true,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.white,
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
                            mainImage!.path ?? "",
                          ),
                          fit: BoxFit.cover)
                      : widget.oldMainImage != null ? Stack(
                    children: [
                      CustomShimmerImage(image: widget.oldMainImage! , width: 400.w,) ,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50.h,
                          width: 180.w,
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor.withOpacity(0.3) ,
                            borderRadius: BorderRadius.circular(15.r) ,

                          ),
                          child: Center(
                            child: Text("Change Main Image" , style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorManager.white
                            ),),
                          ),

                        ),
                      )
                    ],
                  )   :Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(Icons.image,
                                  color: ColorManager.blueColor, size: 100.h),
                              CustomText(
                                  text: "Image Here",
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
              widget.oldImages == null ||widget.oldImages!.isEmpty ?
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
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Container(
                              height: 100.h,
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
                                print(
                                    "courseImage =>${pickedFile.path.split("/").last}");
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
              ) : Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2 / 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                    ),
                    itemCount: widget.oldImages!.length + 1,
                    itemBuilder: (ctx, index) {
                      if (index < widget.oldImages!.length) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: ColorManager.blueColor,
                                ),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.network(
                                      widget.oldImages![index]?.image ?? "",
                                      fit: BoxFit.fill))),
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
                                print(
                                    "courseImage =>${pickedFile.path.split("/").last}");
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
                      buttonText: translate(LocaleKeys.postAd)
                          ,
                      onTap: () {
                        try{
                          Provider.of<ShowRoomSellCarViewModel>(context,
                              listen: false)
                              .editCar(
                              context: context,
                              carData: widget.carData,
                              images: images,
                              id:widget.id,
                              mainImage: mainImage );
                          NavigationService.pushReplacement(context, Routes.bottomNavigationBar);
                          showCustomSnackBar(message: "Your Ads has been updated successfully", context: context) ;
                        }catch (e){
                          print(e);
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
