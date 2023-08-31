import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/car_show_rooms/component/car_show_room_new_cars_component.dart';
import 'package:automobile_project/presentation/car_show_rooms/component/car_show_room_used_cars_component.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/navigation/navigation.dart';
import '../../../core/resources/resources.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/components.dart';
import '../../component/cutom_shimmer_image.dart';

import '../component/car_show_rooms_branches_component.dart';

class CarShowRoomProfilePage extends StatefulWidget {
  final ShowRoomModel showRoomModel  ;
  final int? tab  ;
  const CarShowRoomProfilePage({Key? key, required this.showRoomModel,  this.tab}) : super(key: key);
  @override
  State<CarShowRoomProfilePage> createState() => _CarShowRoomProfilePageState();
}

class _CarShowRoomProfilePageState extends State<CarShowRoomProfilePage> {
  int tabsIndex = 0;
  List<String> tabs = [
    translate(LocaleKeys.newCars),
    translate(LocaleKeys.usedCars),
    translate(LocaleKeys.branches),
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabsIndex = widget.tab ?? 0 ;
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.showRooms),
        titleColor: ColorManager.white,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor  ,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child:  Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.white,
              textDirection: shared!.getString("lang") == "ar" ? TextDirection.ltr : TextDirection.rtl,
            )),
      )),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 210.h,
            decoration: BoxDecoration(
                color: ColorManager.greyCanvasColor,
                image: DecorationImage(image: NetworkImage("${widget.showRoomModel.coverImage}") ,fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(20.r)),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                width: 100.h,
                margin: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  boxShadow: [
                    BoxShadow(
                      color:  ColorManager.black.withOpacity(0.1) ,
                      offset: const Offset(0, 0)  ,
                      blurRadius: 8
                    )
                  ] ,
                  borderRadius: BorderRadius.circular(15.r) ,
                ),
                child: CustomShimmerImage(
                  image:
                  //TODO add image
                  "${widget.showRoomModel.image}",
                  boxFit: BoxFit.contain,
                  height: 100.h,
                  width: 120.h,
                ),
              ) ,
              HorizontalSpace(20.w),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "${widget.showRoomModel.showroomName}",
                          textStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: ColorManager.primaryColor,
                            height: 1,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.bold,
                          )),
                      const VerticalSpace(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TapEffect(
                              onClick: () {
                                if(userProvider.isAuth){
                                  telePhone(widget.showRoomModel.phone!) ;
                                }else{
                                  showCustomSnackBar(message: "please logim first", context: context);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorManager.black.withOpacity(0.1) ,
                                        offset: const Offset(0, 0) ,
                                        blurRadius: 8
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(12.r)),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:const [
                                     Icon(Icons.call,
                                        color: ColorManager.primaryColor),

                                  ],
                                ),
                              )),
                          const HorizontalSpace(30),
                           TapEffect(
                              onClick: () {
                                if(userProvider.isAuth){
                                  launchWhatsAppUri(widget.showRoomModel.whatsapp!) ;
                                }else{
                                  showCustomSnackBar(message: "please login first", context: context);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorManager.black.withOpacity(0.1) ,
                                          offset: const Offset(0, 0) ,
                                          blurRadius: 8
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(12.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomSvgImage(
                                        image: AssetsManager.whatsAppIcon,
                                        boxFit: BoxFit.contain,
                                        height: 27.h,
                                        width: 27.h),

                                  ],
                                ),
                              )),
                          const HorizontalSpace(30),
                          Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                                color: ColorManager.primaryColor ,
                                borderRadius: BorderRadius.circular(12.r) ,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorManager.black.withOpacity(0.1) ,
                                    blurRadius: 8 ,
                                    offset: const Offset(0, 0) ,

                                  ) ,

                                ]
                            ),
                            child: Row(
                              children: [
                                CustomText(text: "${translate(LocaleKeys.carCount)}: " ,
                                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: ColorManager.white ,
                                  fontSize: 16
                                ),
                                ) ,
                            CustomText(text: "${widget.showRoomModel.carCount?? 0}" ,
                              textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: ColorManager.white ,
                                  fontSize: 16
                              ),)

                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              )
            ],
          )  ,
          VerticalSpace(20.h),
          Expanded(
            child: DefaultTabController(
              //  length: 3,
              length: 3,
              initialIndex: tabsIndex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    onTap: (selectedTabIndex) {
                      setState(() {
                        tabsIndex = selectedTabIndex;
                      });
                    },
                    indicatorPadding: EdgeInsets.all(5.h),
                    /*   indicator: BoxDecoration(
                                color: ColorManager.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(26.r),
                                ),
                              ),*/
                    indicatorColor: ColorManager.primaryColor,
                    labelColor: ColorManager.black,
                    unselectedLabelColor: Colors.black,
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                            fontWeight: FontWeightManager.semiBold,
                            letterSpacing: 0.1 // color: ColorManager.black
                            ),
                    tabs: <Widget>[
                      //     for (int index = 0; index < 3; index++)
                      for (int index = 0; index < 3; index++)
                        Tab(
                          child: CustomText(
                            text: tabs[index],
                            maxLines: 1,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeightManager.semiBold,
                                    fontSize: 13.h,
                                    letterSpacing:
                                        0.1 // color: ColorManager.black
                                    ),
                          ),
                        ),
                    ],
                  ),
                  const VerticalSpace(10),
                  tabsIndex == 0
                      ?  Expanded(child: NewCarsShowRoomsDataComponent(
                    id: widget.showRoomModel.id,
                  ))
                      : const Center(),
                  tabsIndex == 1
                      ?  Expanded(child: ShowRoomUsedCarComponents(
                    role: widget.showRoomModel.role,
                    id: widget.showRoomModel.id,
                  ))
                      : const Center(),
                  tabsIndex == 2
                      ?  Expanded(
                          child: CarShowRoomsBranchesComponent(id: widget.showRoomModel.id!,))
                      : const Center(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


