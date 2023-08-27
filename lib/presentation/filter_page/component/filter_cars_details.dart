// ignore_for_file: prefer_null_aware_operators

import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/presentation/component/app_widgets/my_app_bar.dart';
import 'package:automobile_project/presentation/filter_page/component/filter_cars_data.dart';
import 'package:automobile_project/presentation/filter_page/view_model/filter_page_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';

class FiltersCarsDetails extends StatefulWidget {
  final String? name ;
  final int? id ;
  const FiltersCarsDetails({Key? key, this.name, this.id}) : super(key: key);

  @override
  State<FiltersCarsDetails> createState() => _FiltersCarsDetailsState();
}

class _FiltersCarsDetailsState extends State<FiltersCarsDetails> {
  final _contoller = ScrollController() ;
  int tabsIndex = 0;
  List<String> tabs = [
    "Price",
    "Classes",
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contoller.addListener(() {
      // if reach to end of the list
      if (_contoller.position.maxScrollExtent == _contoller.offset) {
        // fetch();
        Provider.of<FilterPageViewModel>(context, listen: false)
            .getMyCars(context: context, states: null, brand: widget.id != null ? widget.id.toString() : null,
            carModel: null,
            driveType: null, fuelType: null, startPrice: null, endPrice: null,
            startYear: null, endYear: null, search: widget.name );
        if (kDebugMode) {
          print("Fetch");
        }
      } else {
        if (kDebugMode) {
          print("Not Fetch");
        }
      }
    });
  }
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
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child:
      MyAppbar(
        backgroundColor:  ColorManager.primaryColor,
        title: "Filter Result",
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
        child: Consumer<FilterPageViewModel>(
          builder: (_ , data , __){

            if(data.isLoading){
              return  const Center(child: MyProgressIndicator()) ;
            }else if(data.carList.isEmpty){
              return Center(
                child: CustomText(text: "No Data Found" , textStyle: Theme.of(context).textTheme.bodyLarge,),
              ) ;
            }else{
              return SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: 100.h ,
                      left: 10.h ,
                      right: 10.h ,
                      top : 10.h
                  ),
                  child: Column(
                    children: List.generate(data.carList.length, (index) => TapEffect(
                      onClick: (){
                        NavigationService.push(context, Routes.latestNewCarsDetails ,
                            arguments: {
                              "carModel": data.carList[index] ,
                              "isShowRoom" : data.carList[index].modelRole == "user" ? false: true
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
                                              "Price",
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
                                        showCustomSnackBar(message: "please login first", context: context) ;
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
                                        launchWhatsAppUri(data.carList[index].modelObject!.phone!) ;
                                      }else{
                                        showCustomSnackBar(message: "please login first", context: context);
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
                  )) ;
            }

          },
        ),
      ),
    );
  }
}
