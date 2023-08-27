import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/resources/resources.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';

class ShowUserProfile extends StatelessWidget {
  final CarModel carModel ;
  const ShowUserProfile({Key? key, required this.carModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    launchWhatsAppUri(String phone) async {
      // The "launch" method is part of "url_launcher".
      await launchUrl(Uri.parse('https://wa.me/phone=+2$phone?text=is your car available?'),
          mode: LaunchMode.externalApplication);
    }


    telePhone(String phone) async {
      // The "launch" method is part of "url_launcher".
      await launchUrl(Uri.parse('tel://+20$phone'),
          mode: LaunchMode.externalApplication);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Center(
              child: Container(
                width: deviceWidth * 0.30,
                height: deviceWidth * 0.30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100.r)),
                  child:  CustomShimmerImage(
                      image:
                          "${carModel.modelObject?.image}"),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
             ProfileUserDataWidget(
              title: "Name",
              value: "${carModel.modelObject?.name}",
            ),

             ProfileUserDataWidget(
              title: "Phone",
              value: "${carModel.modelObject?.phone}",
            ),
            const VerticalSpace(50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: TapEffect(
                        onClick: () {telePhone(carModel.modelObject!.phone!) ; },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorManager.greyColorCBCBCB.withOpacity(0.6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.call,
                                  color: ColorManager.primaryColor),
                              HorizontalSpace(10.w),
                              CustomText(
                                text: "Call Dealer",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontWeight: FontWeightManager.semiBold,
                                        color: ColorManager.primaryColor),
                              )
                            ],
                          ),
                        )),
                  ),
                  HorizontalSpace(10.w),
                  Expanded(
                    child: TapEffect(
                        onClick: () {launchWhatsAppUri(carModel.modelObject!.whatsApp!);},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorManager.primaryColor,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomSvgImage(
                                  image: AssetsManager.whatsAppIcon,
                                  color: Colors.white),
                              HorizontalSpace(10.w),
                              CustomText(
                                text: "Whatsapp",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontWeight: FontWeightManager.semiBold,
                                        color: ColorManager.white),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileUserDataWidget extends StatelessWidget {
  final String title;
  final String value;

  const ProfileUserDataWidget({
    required this.value,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "$title :",
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeightManager.semiBold),
              ),
              const HorizontalSpace(15),
              Expanded(
                child: CustomText(
                  text: value,
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeightManager.medium,
                      ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Divider(
            height: 5.h,
            color: ColorManager.primaryColor,
            thickness: 0.6,
          ),
        ),
      ],
    );
  }
}
