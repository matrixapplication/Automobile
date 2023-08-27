// ignore_for_file: prefer_null_aware_operators


import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/custom_svg_image.dart';
import 'package:automobile_project/presentation/component/custom_text.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/indicator.dart';
import 'package:automobile_project/presentation/component/tap_effect.dart';

import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import 'view_model/sort_by_model_view.dart';


class SortPage extends StatefulWidget {
  final String? name ;
  final int? id ;
  final String? status ;
  const SortPage({Key? key, this.name, this.id, this.status}) : super(key: key);

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  final _contoller = ScrollController() ;
  int tabsIndex = 0;
  List<String> tabs = [
    "Price",
    "Classes",
  ];


  String? order = "desc" ;


  launchWhatsAppUri(String phone) async {
    // The "launch" method is part of "url_launcher".
    await launchUrl(
        Uri.parse('https://wa.me/phone=+2$phone?text=is your car available?'),
        mode: LaunchMode.externalApplication);
  }

  telePhone(String phone) async {
    // The "launch" method is part of "url_launcher".
    await launchUrl(Uri.parse('tel://+20$phone'),
        mode: LaunchMode.externalApplication);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SortPageViewModel>(context, listen: false)
        .getMyCars(context: context,  order: order , isAll: true, status: widget.status , );
    _contoller.addListener(() {
      // if reach to end of the list
      if (_contoller.position.maxScrollExtent == _contoller.offset) {
        // fetch();
        Provider.of<SortPageViewModel>(context, listen: false)
            .getMyCars(context: context,  order: order , isAll: false, status: widget.status , );
        print("Fetch");
      } else {
        print("Not Fetch");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child:
      MyAppbar(
        backgroundColor:  ColorManager.primaryColor,
        title: translate(LocaleKeys.sortBy),
        titleColor: ColorManager.white,
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
      body:  Container(
        color: Colors.white,
        child: Consumer<SortPageViewModel>(
          builder: (_ , data , __){
            return !data.isLoading ?

            SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: 100.h ,
                    left: 10.h ,
                    right: 10.h ,
                    top : 10.h
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          buttonText: translate(LocaleKeys.asc),
                          backgroundColor: order == "asc" ?
                          ColorManager.primaryColor : ColorManager.white,
                          height: 60.h,
                          width: 150.w,
                          borderColor: ColorManager.greyCanvasColor,
                          textColor: order == "asc" ?
                          ColorManager.white : ColorManager.black,
                          onTap: ()async{
                            setState(() {
                                order = "asc"  ;
                            });
                            await Provider.of<SortPageViewModel>(context , listen: false).getMyCars(context: context, order: order , isAll: true, status: widget.status);

                          },
                        ),
                        CustomButton(
                          buttonText: translate(LocaleKeys.desc),
                          backgroundColor:order == "desc" ? ColorManager.primaryColor : ColorManager.white,
                          height: 60.h,
                          width: 150.w,
                          textColor: order == "desc" ?ColorManager.white : ColorManager.black,
                          onTap: ()async{
                            setState(() {
                              order = "desc" ;
                            });
                            await Provider.of<SortPageViewModel>(context , listen: false).getMyCars(context: context, order: order , isAll: true, status: widget.status);

                          },
                        ),
                      ],
                    ) ,
                    SizedBox(
                      height: 10.h,
                    ) ,
                    Column(
                      children: List.generate(data.carList.length, (index) => TapEffect(
                        onClick: (){
                          NavigationService.push(context, Routes.latestNewCarsDetails ,
                              arguments: {
                                "carModel": data.carList[index] ,
                                "isShowRoom" : data.carList[index].modelRole == "user" ? false : true
                              }
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.w,
                              horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(15.r),
                              // border: Border.all(color: ColorManager.greyColorCBCBCB.withOpacity(0.3)) ,
                              boxShadow: [
                                BoxShadow(
                                    color:  ColorManager.greyColorCBCBCB.withOpacity(0.3) ,
                                    offset:  const Offset(0, 0) ,
                                    blurRadius: 58 ,spreadRadius: 6
                                )
                              ]
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration : BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2) ,
                                            blurRadius: 6 ,
                                            offset: const Offset(0, 0)
                                        )
                                      ]
                                  ) ,
                                  child: CustomShimmerImage(
                                    image: "${data.carList[index].mainImage}" ,
                                    boxFit: BoxFit.cover,
                                    height: 100.h,
                                    width: 120.h,
                                    topLeft: 15.r,
                                    bottomLeft: 15.r,
                                    topRight: 15.r,
                                    bottomRight: 15.r,
                                  ),
                                ),
                                HorizontalSpace(20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      CustomText(
                                          text:
                                          "${data.carList[index].brand?.name} ${data.carList[index].brandModel?.name} ${data.carList[index].brandModelExtension?.name}",
                                          textStyle: Theme.of(
                                              context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                            color: ColorManager
                                                .blackColor1C1C1C,
                                            height: 1,
                                            fontWeight:
                                            FontWeightManager
                                                .semiBold,
                                          )),
                                      const VerticalSpace(
                                          10),
                                      CustomText(
                                          text:
                                          "${data.carList[index].brand?.name}",
                                          textStyle: Theme.of(
                                              context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                            color: ColorManager
                                                .blackColor1C1C1C,
                                            height: 1,
                                            fontWeight:
                                            FontWeightManager
                                                .semiBold,
                                          )),
                                      const VerticalSpace(
                                          10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                            CustomText(
                                                text:
                                                translate(LocaleKeys.price),
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                  color: ColorManager.blackColor1C1C1C,
                                                  height: 1,
                                                  fontWeight: FontWeightManager.semiBold,
                                                )),
                                          ),
                                          CustomText(
                                              text:
                                              "${double.parse("${data.carList[index].price}").toStringAsFixed(0)} EGP",
                                              textStyle: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                color:
                                                ColorManager.greyColor515151,
                                                height:
                                                1,
                                                fontWeight:
                                                FontWeightManager.semiBold,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ) ,
                            Row(
                              children: [
                                Expanded(
                                  child: TapEffect(
                                      onClick: () {
                                        if(userProvider.isAuth){
                                          telePhone(data.carList[index].modelObject!.phone!) ;
                                        }else{
                                          showCustomSnackBar(message: "please login first", context: context);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets
                                            .symmetric(
                                            vertical:
                                            10.h),
                                        decoration: BoxDecoration(
                                            color: ColorManager.greyColorD6D6D6 ,
                                            borderRadius: BorderRadius.circular(15.r)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            const Icon(
                                                Icons
                                                    .call,
                                                color: ColorManager
                                                    .primaryColor),
                                            HorizontalSpace(
                                                10.w),
                                            CustomText(
                                              text:
                                              "Call",
                                              textStyle: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeightManager.semiBold,
                                                  color: ColorManager.primaryColor),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: TapEffect(
                                      onClick: () {
                                        if(userProvider.isAuth){
                                          launchWhatsAppUri(data.carList[index].modelObject!.whatsApp!);
                                        }else{
                                          showCustomSnackBar(message: "please login first", context: context );
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets
                                            .symmetric(
                                            vertical:
                                            10.h),
                                        decoration : BoxDecoration(
                                            color: ColorManager
                                                .primaryColor,
                                            borderRadius:  BorderRadius.circular(15.r)
                                        ),

                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            const CustomSvgImage(image: AssetsManager.whatsAppIcon , color: ColorManager.white,),
                                            HorizontalSpace(
                                                10.w),
                                            CustomText(
                                              text:
                                              "Whatsapp",
                                              textStyle: Theme.of(
                                                  context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                  fontWeight:
                                                  FontWeightManager.semiBold,
                                                  color: ColorManager.white),
                                            )
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            )
                          ]),
                        ),
                      )),
                    ),
                  ],
                ))  : const Center(child: MyProgressIndicator());
          },
        ),
      ),
    );
  }
}
