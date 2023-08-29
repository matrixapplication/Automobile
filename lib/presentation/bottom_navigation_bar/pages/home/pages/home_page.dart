// ignore_for_file: use_build_context_synchronously

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:automobile_project/presentation/component/search_text_field.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../components/app_drawer.dart';
import '../components/home_brands_component.dart';
import '../components/home_cars_categories_component.dart';
import '../components/home_latest_new_cars_component.dart';
import '../components/home_slider_component.dart';
import '../components/home_top_used_cars_component.dart';
import '../view_model/show_room_view_model.dart';
import '../widgets/home_component_title.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final TextEditingController searchController = TextEditingController() ;
  @override
  void initState() {
    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
        final userProider =  Provider.of<LocalAuthProvider>(context,listen: false) ;
        await userProider.getEndUserData();
        print("end user ==> ${userProider.endUser}");
        await userProider.getUserData();
        print(" user ==> ${userProider.user}");
        Provider.of<GetMyCarsViewModel>(context, listen: false).getMyCars(context: context , states: null  , id: null ,  modelRole:  null  , isAll: false) ;
        Provider.of<SlidersViewModel>(context, listen: false)
            .showSliders(context: context);
        Provider.of<CarStatusViewModel>(context , listen: false).getCarStatus(context: context);



      });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorManager.greyCanvasColor,
      key: _key,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  // const VerticalSpace(10),
                  SizedBox(
                    height: deviceHeight * 0.45,
                    child: Stack(
                      children: [
                        HomeSliderComponent(drawerKey: _key),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                          child: Row(children: [
                            TapEffect(
                                onClick: () {
                                  _key.currentState!.openDrawer();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.h),
                                  height: 45.h,
                                  width: 45.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.white , 
                                    borderRadius: BorderRadius.circular(15.r)
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.sort,
                                      size: 30.h,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                )),
                            const HorizontalSpace(45),
                            //Search
                            SearchBarRes(

                            )
                            // Expanded(
                            //   child: CustomTextField(
                            //     height: 50.h,
                            //     controller: searchController,
                            //     prefixIcon: Padding(
                            //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                            //       child: Icon(
                            //         Icons.search,
                            //         size: 30.h,
                            //         color: ColorManager.lightBlack,
                            //       ),
                            //     ),
                            //     borderRadius: RadiusManager.s50.r,
                            //     hintText: "Search",
                            //     textInputType: TextInputType.text,
                            //     maxLine: 1,
                            //     contentVerticalPadding: 4,
                            //
                            //
                            //
                            //   ),
                            // ),
                          ]),
                        ),

                        HomeCarsCategoriesComponent()
                      ],
                    ),
                  ),

                  //Filter
                  const VerticalSpace(15),
                  Card(
                    color: ColorManager.primaryColor,
                    margin: EdgeInsets.zero,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.h),
                    ),
                    elevation: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      height: 65.h,
                      child: Row(
                        children: [
                          Expanded(
                              child: TapEffect(
                                onClick: () {
                                  NavigationService.push(
                                      context, Routes.filterPage , arguments: {
                                    "type" : null
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sort, size: 30.h , color: ColorManager.white,),
                                    HorizontalSpace(10.w),
                                    CustomText(
                                      text: translate(LocaleKeys.filter),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: ColorManager.white),
                                    )
                                  ],
                                ),
                              )),
                          Container(
                            width: 1.5.w,
                            color: ColorManager.white,
                            height: 55.h,
                          ),
                          Expanded(
                              child: TapEffect(
                                onClick: (){
                                  NavigationService.push(context, Routes.sortPage  , arguments: {
                                    "status":null
                                  }) ;
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.filter_alt_sharp, size: 30.h , color: ColorManager.white,),
                                    HorizontalSpace(10.w),
                                    CustomText(
                                      text: translate(LocaleKeys.sortBy),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                          color: ColorManager.white
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  //Popular Brand
                  const VerticalSpace(10),
                  Card(
                    color: ColorManager.white,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child:   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            HomeComponentTitle(title:translate(LocaleKeys.popularBrands)),
                             VerticalSpace(6.h),
                            const HomeBrandsComponent(role: null , status: null),
                          ]),
                    ),
                  ),

                  //Latest New Cars
                  const VerticalSpace(10),
                  Card(
                    color: ColorManager.white,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeComponentTitle(
                                title: translate(LocaleKeys.newCars),
                                isSeeAll: true,
                                onTap: () {
                                  NavigationService.push(
                                      context, Routes.latestNewCarPage);
                                }),

                            const HomeLatestNewCarsComponent(),
                          ]),
                    ),
                  ),

                  //Top Used Car
                  const VerticalSpace(10),
                  Card(
                    color: ColorManager.white,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeComponentTitle(
                                title: translate(LocaleKeys.usedCars),
                                isSeeAll: true,
                                onTap: () {
                                  NavigationService.push(
                                      context, Routes.usedCarsPage);
                                }),
                            const VerticalSpace(6),

                            const HomeTopUsedCarsComponent(),
                          ]),
                    ),
                  ),

                  //Car Show Rooms
                  const VerticalSpace(10),

                  Consumer<ShowRoomsViewModel>(
                    builder: (context, viewModel, child) {
                       if (viewModel.showRoomsList.isEmpty) {
                        return const SizedBox();
                      } else {
                        return Card(
                          color: ColorManager.white,
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomeComponentTitle(
                                      title: translate(LocaleKeys.showRooms),
                                      isSeeAll: true,
                                      onTap: () {
                                        NavigationService.push(
                                            context, Routes.carShowRoomPage);
                                      }),
                                  SizedBox(
                                    height: 6.h,
                                  ) ,
                                  SizedBox(
                                    height: 260.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          viewModel.showRoomsList.length > 10
                                              ? 10
                                              : viewModel.showRoomsList.length,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      itemBuilder: (context, index) {
                                        return viewModel.showRoomsList[index].isBlocked! ?
                                            const SizedBox():
                                          TapEffect(
                                          onClick: () {
                                            NavigationService.push(context,
                                                Routes.carShowRoomProfilePage , arguments: {
                                              "showRoomModel" : viewModel.showRoomsList[index]
                                                });
                                          },
                                          child: Container(
                                            height: 260.h,
                                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                                            width: deviceWidth * 0.60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.r),
                                                border: Border.all(color: ColorManager.greyColorCBCBCB)
                                            ),
                                            child: ClipRRect(

                                              borderRadius: BorderRadius.circular(12.r),

                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 115.h , left: 10.h , right: 10.h , top: 10.h),
                                                    child:  CustomShimmerImage(
                                                      image:
                                                      "${viewModel.showRoomsList[index].image}",
                                                      boxFit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),

                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 100.h,
                                                      padding:
                                                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                                                      decoration: BoxDecoration(
                                                          color: ColorManager.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.black.withOpacity(0.1) ,
                                                                offset: const Offset(0, 0) ,
                                                                spreadRadius: 6 ,
                                                                blurRadius: 48
                                                            )
                                                          ],
                                                          borderRadius:
                                                          BorderRadius.all(Radius.circular(12.r))),
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                viewModel.showRoomsList[index].showroomName != null ? Expanded(
                                                                  child: CustomText(
                                                                      text:"${viewModel.showRoomsList[index].showroomName}",
                                                                      textStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .copyWith(
                                                                          color: ColorManager.blackColor1C1C1C,
                                                                          fontWeight: FontWeightManager.semiBold,
                                                                          height: 1.2),
                                                                      maxLines: 2),
                                                                ) :
                                                                Shimmer.fromColors(
                                                                  baseColor: Colors.grey[200]!,
                                                                  highlightColor: Colors.grey[600]!,
                                                                  child: Container(
                                                                    height: 14.h,
                                                                    width: 50.w,
                                                                    decoration:  BoxDecoration(
                                                                        color: ColorManager.greyColorCBCBCB,
                                                                        borderRadius: BorderRadius.circular(15.h)
                                                                      // shape: BoxShape.circle
                                                                    ),
                                                                  ),) ,
                                                                SizedBox(
                                                                  width: 78.w,
                                                                ),

                                                              ],
                                                            )
                                                            ,



                                                            SizedBox(
                                                              height: 8.h,
                                                            ) ,

                                                            CustomButton(
                                                              onTap: () {
                                                                NavigationService.push(context,
                                                                    Routes.carShowRoomProfilePage , arguments: {
                                                                      "showRoomModel" : viewModel.showRoomsList[index]
                                                                    });
                                                              },
                                                              buttonText: translate(LocaleKeys.details),
                                                              backgroundColor: ColorManager.primaryColor,
                                                              height: 40.h,
                                                            )
                                                          ]),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const HorizontalSpace(10);
                                      },
                                    ),
                                  )
                                ]),
                          ),
                        );
                      }
                    },
                  ),
                  const VerticalSpace(10),
                  Consumer<ShowRoomsViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.agenciesList.isEmpty) {
                        return const SizedBox();
                      } else {
                        return Card(
                          color: ColorManager.white,
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomeComponentTitle(
                                      title: translate(LocaleKeys.agencies),
                                      isSeeAll: true,
                                      onTap: () {
                                        NavigationService.push(
                                            context, Routes.allAgencyPage);
                                      }),
                                  SizedBox(
                                    height: 6.h,
                                  ) ,
                                  SizedBox(
                                    height: 260.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                      viewModel.agenciesList.length > 10
                                          ? 10
                                          : viewModel.agenciesList.length,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      itemBuilder: (context, index) {
                                        return   viewModel.agenciesList[index].isBlocked! ?
                                        const SizedBox()
                                            :
                                        TapEffect(
                                          onClick: () {
                                            NavigationService.push(context,
                                                Routes.agencyProfilePage , arguments: {
                                                  "showRoomModel" : viewModel.agenciesList[index]
                                                });
                                          },
                                          child: Container(
                                            height: 260.h,
                                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                                            width: deviceWidth * 0.60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.r),
                                                border: Border.all(color: ColorManager.greyColorCBCBCB)
                                            ),
                                            child: ClipRRect(

                                              borderRadius: BorderRadius.circular(12.r),

                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 115.h , left: 10.h , right: 10.h , top: 10.h),
                                                    child:  CustomShimmerImage(
                                                      image:
                                                      "${viewModel.agenciesList[index].image}",
                                                      boxFit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),

                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 100.h,
                                                      padding:
                                                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                                                      decoration: BoxDecoration(
                                                          color: ColorManager.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.black.withOpacity(0.1) ,
                                                                offset: const Offset(0, 0) ,
                                                                spreadRadius: 6 ,
                                                                blurRadius: 48
                                                            )
                                                          ],
                                                          borderRadius:
                                                          BorderRadius.all(Radius.circular(12.r))),
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                viewModel.agenciesList[index].showroomName != null ? Expanded(
                                                                  child: CustomText(
                                                                      text:"${viewModel.agenciesList[index].showroomName}",
                                                                      textStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .copyWith(
                                                                          color: ColorManager.blackColor1C1C1C,
                                                                          fontWeight: FontWeightManager.semiBold,
                                                                          height: 1.2),
                                                                      maxLines: 2),
                                                                ) :
                                                                Shimmer.fromColors(
                                                                  baseColor: Colors.grey[200]!,
                                                                  highlightColor: Colors.grey[600]!,
                                                                  child: Container(
                                                                    height: 14.h,
                                                                    width: 50.w,
                                                                    decoration:  BoxDecoration(
                                                                        color: ColorManager.greyColorCBCBCB,
                                                                        borderRadius: BorderRadius.circular(15.h)
                                                                      // shape: BoxShape.circle
                                                                    ),
                                                                  ),) ,
                                                                SizedBox(
                                                                  width: 78.w,
                                                                ),

                                                              ],
                                                            )
                                                            ,



                                                            SizedBox(
                                                              height: 8.h,
                                                            ) ,

                                                            CustomButton(
                                                              onTap: () {
                                                                NavigationService.push(context,
                                                                    Routes.agencyProfilePage , arguments: {
                                                                      "showRoomModel" : viewModel.agenciesList[index]
                                                                    });
                                                              },
                                                              buttonText: translate(LocaleKeys.details),
                                                              backgroundColor: ColorManager.primaryColor,
                                                              height: 40.h,
                                                            )
                                                          ]),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const HorizontalSpace(10);
                                      },
                                    ),
                                  )
                                ]),
                          ),
                        );
                      }
                    },
                  ),

                  const VerticalSpace(25),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
