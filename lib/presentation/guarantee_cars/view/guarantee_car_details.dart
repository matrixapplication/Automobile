import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../../data/models/car_model/admin_car_model.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class GuaranteeCarDetailsData extends StatefulWidget {
  final AdminCars adminCars ;
  const GuaranteeCarDetailsData({Key? key, required this.adminCars}) : super(key: key);

  @override
  State<GuaranteeCarDetailsData> createState() => _GuaranteeCarDetailsDataState();
}

class _GuaranteeCarDetailsDataState extends State<GuaranteeCarDetailsData> {
  List<String> titles = ["Specifications", "Safety", "Technologies"];
  List<List<String>> content = [
    [
      "Engine capacity",
      "Horse Power",
      "Maximum Speed",
    ],
    [
      "safety 1",
      "safety 2",
      "safety 3",
    ],
    [
      "Technologies 1",
      "Technologies 2",
      "Technologies 3",
    ],
  ];
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
  int activePage = 0;
  late PageController _pageController;
  List<String> images = [

  ];
  // Widget for image animation while sliding carousel
  imageAnimation(PageController animation, images, pagePosition) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        print(pagePosition);
        return SizedBox(
          width: 200,
          height: 200,
          child: widget,
        );
      },
      child: Container(
        // margin: const EdgeInsets.all(10),
        child: Image.network(images[pagePosition]),
      ),
    );
  }

// Widget for showing image indicator
  List<Widget> imageIndicator(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.teal.shade400 : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }

  // Animated container widget
  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            images[pagePosition],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images.add(widget.adminCars.mainImage!) ;
    images.add(widget.adminCars.door1Img!) ;
    images.add(widget.adminCars.door2Img!) ;
    images.add(widget.adminCars.door3Img!) ;
    images.add(widget.adminCars.door4Img!) ;
    _pageController = PageController(viewportFraction:1, initialPage: 0);

  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(

                child: Column(

                  children: [
                    Row(

                      children: [
                        TapEffect(
                            onClick: () {
                              NavigationService.goBack(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.h),
                              margin: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                  color: ColorManager.white ,
                                  shape: BoxShape.circle ,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1) ,
                                        offset: const Offset(0, 0) ,
                                        blurRadius: 8
                                    )
                                  ]
                              ),
                              child:  Icon(
                                Icons.arrow_forward_ios,
                                textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl ,
                                color: ColorManager.black,
                              ),
                            )) ,
                      ],
                    ) ,
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: PageView.builder(
                                itemCount: images.length,
                                pageSnapping: true,
                                controller: _pageController,
                                onPageChanged: (page) {
                                  setState(() => activePage = page);
                                },
                                itemBuilder: (context, pagePosition) {
                                  bool active = pagePosition == activePage;
                                  return slider(images, pagePosition, active);
                                }),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 260.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: imageIndicator(images.length, activePage),
                                  ),
                                )
                              ],
                            ),
                          ) ,
                        ),

                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                    text: "${widget.adminCars.brand?.name} ${widget.adminCars.brandModel?.name} | ${widget.adminCars.year}",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        color:
                                        ColorManager.blackColor1C1C1C,
                                        height: 1,
                                        fontWeight:
                                        FontWeightManager.bold,
                                        fontSize: 18)),
                              ),
                              shared!.getString("role") =="showroom"||
                                  shared!.getString("role") == "agency" ?  const SizedBox(): Consumer<FavViewModel>(builder: (_, data1, __) {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TapEffect(
                                      onClick: () async {
                                        await data1.addRemoveFav(
                                            context: context,
                                            carId: widget.adminCars.id!,
                                            car: CarModel.fromJson(widget.adminCars.toJson()));
                                      },
                                      child: Center(
                                        child: Icon(
                                          data1.showFavCarsResponse != null
                                              ? data1.showFavCarsResponse!
                                              .data!
                                              .any((element) =>
                                          element.id ==
                                              widget.adminCars.id)
                                              ? Icons.favorite
                                              : Icons
                                              .favorite_border_outlined
                                              : Icons
                                              .favorite_border_outlined,
                                          color: ColorManager.primaryColor,
                                          size: 22.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),

                            ],
                          ),

                          VerticalSpace(10.h) ,
                          Row(
                            children: [
                              CustomText(
                                  text: "${widget.adminCars.brandModelExtension?.name}",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                      color:
                                      ColorManager.blackColor1C1C1C,
                                      height: 1,
                                      fontWeight:
                                      FontWeightManager.bold,
                                      fontSize: 14)),
                              HorizontalSpace(20.w) ,
                              Container(
                                padding: EdgeInsets.symmetric( horizontal: 10.w , vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.homeCanvasColor ,
                                    borderRadius: BorderRadius.circular(8.h) ,
                                    border: Border.all(
                                      color: ColorManager.blackColor1C1C1C ,

                                    )
                                ),
                                child: Center(
                                  child: CustomText(text: "${widget.adminCars.brand?.name}"),
                                ),
                              ) ,
                              HorizontalSpace(20.w) ,

                              Container(
                                padding: EdgeInsets.symmetric( horizontal: 10.w , vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.homeCanvasColor ,
                                    borderRadius: BorderRadius.circular(8.h) ,
                                    border: Border.all(
                                      color: ColorManager.blackColor1C1C1C ,

                                    )
                                ),
                                child: Center(
                                  child: CustomText(text: "${widget.adminCars.mileage} ${translate(LocaleKeys.km)}"),
                                ),
                              ) ,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                padding: EdgeInsets.symmetric( horizontal: 10.w , vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.homeCanvasColor ,
                                    borderRadius: BorderRadius.circular(8.h) ,
                                    border: Border.all(
                                      color: ColorManager.blackColor1C1C1C ,

                                    )
                                ),
                                child: Center(
                                  child: CustomText(text: widget.adminCars.status?.name ?? ''),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                    VerticalSpace(10.h) ,
                    Container(
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                          color: ColorManager.white ,
                          border: Border.all(color: ColorManager.homeCanvasColor , )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1)  ,
                                        blurRadius: 8 ,
                                        offset: const Offset(0, 0) ,

                                      )
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(text: "${widget.adminCars.bodyType?.name}" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: ColorManager.primaryColor
                                        ),) ,
                                        HorizontalSpace(10.w) ,
                                        CustomSvgImage(image: AssetsManager.sedanIcon  , height: 30.h,color: ColorManager.primaryColor,)

                                      ],
                                    ) ,
                                    CustomText(text: translate(LocaleKeys.bodyShape ,) , textStyle: Theme.of(context).textTheme.bodySmall,)
                                  ],
                                ),
                              ) ,
                              Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1)  ,
                                        blurRadius: 8 ,
                                        offset: const Offset(0, 0) ,

                                      )
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(text: "${widget.adminCars.fuelType?.name}" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: ColorManager.primaryColor
                                        ),) ,
                                        HorizontalSpace(10.w) ,
                                        CustomAssetsImage(image: AssetsManager.fuelTypeIcon  , height: 28.h,)

                                      ],
                                    ) ,
                                    CustomText(text: translate(LocaleKeys.fuelType ,) , textStyle: Theme.of(context).textTheme.bodySmall,)
                                  ],
                                ),
                              ) ,
                              Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1)  ,
                                        blurRadius: 8 ,
                                        offset: const Offset(0, 0) ,

                                      )
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(text: "${widget.adminCars.driveType?.name}" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: ColorManager.primaryColor
                                        ),) ,
                                        HorizontalSpace(10.w) ,
                                        CustomSvgImage(image: AssetsManager.automaticIcon  , height: 28.h,color: ColorManager.primaryColor,)

                                      ],
                                    ) ,
                                    CustomText(text: translate(LocaleKeys.carTransmission ,) , textStyle: Theme.of(context).textTheme.bodySmall,)
                                  ],
                                ),
                              ) ,


                            ],
                          ) ,
                          VerticalSpace(10.h) ,
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1)  ,
                                        blurRadius: 8 ,
                                        offset: const Offset(0, 0) ,

                                      )
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(text: "${widget.adminCars.color?.name ?? "no color"}" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: ColorManager.primaryColor
                                        ),) ,
                                        HorizontalSpace(10.w) ,
                                        CustomSvgImage(image: AssetsManager.sedanIcon  , height: 30.h,color: ColorManager.primaryColor,)

                                      ],
                                    ) ,
                                    CustomText(text: translate(LocaleKeys.color ,) , textStyle: Theme.of(context).textTheme.bodySmall,)
                                  ],
                                ),
                              ) ,
                              Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.1)  ,
                                        blurRadius: 8 ,
                                        offset: const Offset(0, 0) ,

                                      )
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(text: "${widget.adminCars.engine} CC" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: ColorManager.primaryColor
                                        ),) ,
                                        HorizontalSpace(10.w) ,
                                        CustomSvgImage(image: AssetsManager.carEnginIcon  , height: 28.h,color: ColorManager.primaryColor,)

                                      ],
                                    ) ,
                                    CustomText(text: translate(LocaleKeys.engineCapacity ,) , textStyle: Theme.of(context).textTheme.bodySmall,)
                                  ],
                                ),
                              ) ,



                            ],
                          ) ,
                        ],
                      ),
                    ) ,

                    Container(
                      padding: EdgeInsets.all(16.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.white ,
                          border: Border.all(color: ColorManager.homeCanvasColor , )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: translate(LocaleKeys.price) , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.primaryColor ,
                              decoration: TextDecoration.underline ,
                              decorationColor: ColorManager.primaryColor,
                              fontSize: 18
                          ),) ,
                          VerticalSpace(20.h) ,
                          CustomText(text: "${widget.adminCars.price} ${translate(LocaleKeys.egp)}" , textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.primaryColor ,

                              fontSize: 31
                          ),) ,
                        ],
                      ),
                    ) ,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.white ,
                          border: Border.all(color: ColorManager.homeCanvasColor , )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h , vertical: 10.h) ,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: translate(LocaleKeys.carFeatures),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: ColorManager.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.primaryColor,
                                    fontWeight: FontWeightManager.bold),
                              ),
                              const VerticalSpace(10),
                              Column(
                                children: List.generate(
                                  widget.adminCars.features!.length,
                                      (index) => Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius:
                                        BorderRadius.circular(12.r)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.w),
                                    child: ExpansionTile(
                                      tilePadding: const EdgeInsets.all(0),
                                      childrenPadding: const EdgeInsets.all(0),
                                      backgroundColor: ColorManager.white,
                                      title: CustomText(
                                        text:
                                        "${widget.adminCars.features![index].name}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                            fontWeight:
                                            FontWeightManager.semiBold,
                                            height: 1,
                                            color: ColorManager.black),
                                        maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      children: <Widget>[
                                        Column(
                                          children: _buildExpandableContent(
                                              data: widget.adminCars
                                                  .features![index].options!),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.white ,
                          border: Border.all(color: ColorManager.homeCanvasColor , )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h , vertical: 10.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: translate(LocaleKeys.carReports),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: ColorManager.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.primaryColor,
                                    fontWeight: FontWeightManager.bold),
                              ),
                              const VerticalSpace(10),
                              Column(
                                children: List.generate(
                                  widget.adminCars.reports!.length,
                                      (index) => Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius:
                                        BorderRadius.circular(12.r)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.w),
                                    child: ExpansionTile(
                                      tilePadding: const EdgeInsets.all(0),
                                      childrenPadding: const EdgeInsets.all(0),
                                      backgroundColor: ColorManager.white,
                                      title: CustomText(
                                        text:
                                        "${widget.adminCars.reports![index].name}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                            fontWeight:
                                            FontWeightManager.semiBold,
                                            height: 1,
                                            color: ColorManager.black),
                                        maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      children: <Widget>[
                                        Column(
                                          children: _buildExpandableContentReport(
                                              data: widget.adminCars
                                                  .reports![index].options!),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),

                  ],
                ),
              ) ,
              SizedBox(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 8.w),
                      child: Column(
                        children: [
//                           TapEffect(
//                             onClick: () {
//
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.r),
//                               ),
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 15.h, horizontal: 15.w),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.r),
// // border: Border.all(color: ColorManager.greyColorCBCBCB),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 50.h,
//                                       width: 50.h,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle),
//                                       child: ClipRRect(
//                                         borderRadius:
//                                         BorderRadius.circular(50.r),
//                                         child: CustomShimmerImage(
//                                           image:
//                                           "${widget.adminCars.modelObject?.image}",
//                                           boxFit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                     HorizontalSpace(20.w),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           CustomText(
//                                             text:
//                                             "${widget.adminCars.modelObject?.name}",
//                                             textStyle: Theme.of(context)
//                                                 .textTheme
//                                                 .titleMedium!
//                                                 .copyWith(
//                                                 fontWeight:
//                                                 FontWeightManager
//                                                     .semiBold,
//                                                 height: 1,
//                                                 color: ColorManager.black),
//                                             maxLines: 1,
// // overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const VerticalSpace(10),
//                                           Row(
//                                             children: [
//                                               CustomText(
//                                                 text: "${widget.adminCars.branch ?? "Cairo,Maadi"}",
//                                                 textStyle: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium!
//                                                     .copyWith(
//                                                     fontWeight:
//                                                     FontWeightManager
//                                                         .semiBold,
//                                                     height: 1,
//                                                     color: ColorManager
//                                                         .greyColorCBCBCB),
//                                                 maxLines: 1,
// // overflow: TextOverflow.ellipsis,
//                                               ),
//                                               const Spacer(),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const VerticalSpace(10),
                          Row(
                            children: [
                              Expanded(
                                child: TapEffect(
                                    onClick: () {

                                      if(userProvider.isAuth){
                                        telePhone(
                                            widget.adminCars.modelObject!.phone!);
                                      }else{
                                        showCustomSnackBar(message: translate(LocaleKeys.pleaseLogin), context: context) ;
                                      }

                                    },
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12.r),
                                        color: ColorManager.greyColorCBCBCB
                                            .withOpacity(0.6),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.call,
                                              color: ColorManager.primaryColor),
                                          HorizontalSpace(10.w),
                                          CustomText(
                                            text: translate(LocaleKeys.call),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                fontWeight:
                                                FontWeightManager
                                                    .semiBold,
                                                color: ColorManager
                                                    .primaryColor),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              HorizontalSpace(10.w),
                              Expanded(
                                child: TapEffect(
                                    onClick: () {
                                      if(userProvider.isAuth){
                                        launchWhatsAppUri(
                                            "${widget.adminCars.modelObject?.whatsApp}");
                                      }else{
                                        showCustomSnackBar(message: translate(LocaleKeys.pleaseLogin), context: context) ;
                                      }

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12.r),
                                        color: ColorManager.primaryColor,
                                      ),
                                      padding:
                                      EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const CustomSvgImage(
                                              image: AssetsManager.whatsAppIcon,
                                              color: Colors.white),
                                          HorizontalSpace(10.w),
                                          CustomText(
                                            text: translate(LocaleKeys.whatsApp),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                fontWeight:
                                                FontWeightManager
                                                    .semiBold,
                                                color: ColorManager.white),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                          const VerticalSpace(10),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ) ;
  }

  _buildExpandableContent({required List<Optionsr> data}) {
    List<String> icons = [
      AssetsManager.carEnginIcon,
      AssetsManager.hoursIcon,
      AssetsManager.speedMeterIcon,
    ];
    List<Widget> columnContent = [];

    for (int i = 0; i < data.length; i++) {
      columnContent.add(Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomShimmerImage(image: data[i].icon! , height: 20) ,
            HorizontalSpace(10.w),
            Expanded(
              child: CustomText(
                text: data[i].name,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorManager.lightBlack,
                    fontWeight: FontWeightManager.semiBold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          ],
        ),
      ));
    }

    return columnContent;
  }
  _buildExpandableContentReport({required List<ROptions> data}) {
    List<String> icons = [
      AssetsManager.carEnginIcon,
      AssetsManager.hoursIcon,
      AssetsManager.speedMeterIcon,
    ];
    List<Widget> columnContent = [];

    for (int i = 0; i < data.length; i++) {
      columnContent.add(Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomShimmerImage(image: data[i].icon! , height: 20) ,
            HorizontalSpace(10.w),
            Expanded(
              child: CustomText(
                text: data[i].name,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorManager.lightBlack,
                    fontWeight: FontWeightManager.semiBold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            data[i].image != null ?
            TapEffect(onClick: (){
              showImageViewer(context,  Image.network(data[i].image!).image, onViewerDismissed: () {
                if (kDebugMode) {
                  print("dismissed");
                }
              });
            },
                child:  CustomText(text: translate(LocaleKeys.showReports),textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorManager.primaryColor),))
                : const SizedBox()
          ],
        ),
      ));
    }

    return columnContent;
  }
}
