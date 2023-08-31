import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/resources/resources.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation_bar/pages/home/components/home_brands_component.dart';
import '../../component/app_widgets/my_app_bar.dart';
import '../../component/custom_button.dart';
import '../components/new_cars_agency_components.dart';
import '../components/new_cars_show_rooms_component.dart';

class LatestNewCarPage extends StatefulWidget {
  const LatestNewCarPage({Key? key}) : super(key: key);

  @override
  State<LatestNewCarPage> createState() => _LatestNewCarPageState();
}

class _LatestNewCarPageState extends State<LatestNewCarPage> {
  int tabsIndex = 0;

  List<String> tabs = [

    translate(LocaleKeys.showRooms),
    translate(LocaleKeys.agencies),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: MyAppbar(
        title: translate(LocaleKeys.newCars),
        centerTitle: true,
        titleColor: ColorManager.white,
        backgroundColor: ColorManager.primaryColor,
        leading: TapEffect(
            onClick: () {
              NavigationService.goBack(context);
            },
            child:  Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.white,
              textDirection: shared!.getString("lang") == "en"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            )),
      )),
      body: Scaffold(
          body: SafeArea(
        child: DefaultTabController(
          //  length: 3,
          length: 2,
          initialIndex: tabsIndex,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


            //  const VerticalSpace(20),
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
                  for (int index = 0; index < 2; index++)
                    Tab(
                      child: CustomText(
                        text: tabs[index],
                        maxLines: 1,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                            fontWeight: FontWeightManager.semiBold,
                            letterSpacing:
                            0.1 // color: ColorManager.black
                        ),
                      ),

                    ),
                ],
              ),
              const VerticalSpace(10),

              Card(
                color: ColorManager.white,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  height: 65.h,
                  child: Row(
                    children: [
                      Expanded(
                          child: TapEffect(
                            onClick:(){
                              NavigationService.push(context, Routes.filterPage , arguments: {"type" : "new"});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sort, size: 30.h),
                                HorizontalSpace(10.w),
                                CustomText(
                                  text: translate(LocaleKeys.filter),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(),
                                )
                              ],
                            ),
                          )),
                      Container(
                        width: 1.5.w,
                        color: ColorManager.greyColorD6D6D6,
                        height: 55.h,
                      ),
                      Expanded(
                          child: TapEffect(
                            onClick: (){
                              NavigationService.push(context, Routes.sortPage , arguments: {
                                "status" : "new"
                              }) ;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.filter_alt_sharp, size: 30.h),
                                HorizontalSpace(10.w),
                                CustomText(
                                  text: translate(LocaleKeys.sortBy),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              //Popular Brand
              Card(
                color: ColorManager.white,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child:  HomeBrandsComponent(role: tabsIndex == 0 ? "showroom" : "agency" , status: "new",),
                ),
              ),


              tabsIndex == 0
                  ? const Expanded(child: NewCarsShowRoomsComponent())
                  : const Center(),
              tabsIndex == 1
                  ?  const  Expanded(child: NewCarsAgencyComponent(
                role: null,
                id: null,
              ))
                  : const Center(),
            ],
          ),
        ),
      )),
    );
  }
}




