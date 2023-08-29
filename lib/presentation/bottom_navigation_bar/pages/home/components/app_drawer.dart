// ignore_for_file: use_build_context_synchronously

import 'package:automobile_project/core/resources/app_assets.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';
import '../widgets/drawer_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {



  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;

    return Drawer(
      child: Column(
        children: [
          const VerticalSpace(50),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
            child: const Center(
                child: CustomAssetsImage(image: AssetsManager.appLogo)),
          ),
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Row(children: [
                      Row(
                        children:  [
                          Icon(Icons.language),
                          HorizontalSpace(10),
                          TapEffect(onClick: ()async{
                            if(shared!.getString("lang") == "ar" ){
                              shared!.setString("lang", "en") ;
                              context.setLocale(Locale("en")) ;
                              lang = Locale("en");
                            }else{
                              shared!.setString("lang", "ar") ;
                              context.setLocale(Locale("ar")) ;
                              lang = Locale("ar");

                            }
                            final userProider =  Provider.of<LocalAuthProvider>(context,listen: false) ;
                            await userProider.getEndUserData();
                            print("end user ==> ${userProider.endUser}");
                            await userProider.getUserData();
                            print(" user ==> ${userProider.user}");
                            Provider.of<NewCarsShowRoomViewModel>(context , listen: false).getMyCars(context: context, id: null, modelRole: "", states: "new" ,isAll: true);
                            Provider.of<SlidersViewModel>(context, listen: false)
                                .showSliders(context: context);
                            Provider.of<UsedCarsShowRoomViewModel>(context , listen: false).
                            getMyCars(context: context, id: null, modelRole: null, states: "used" ,isAll: true);
                            Provider.of<CarStatusViewModel>(context , listen: false).getCarStatus(context: context);
                          }, child: CustomText(
                            text: shared!.getString("lang") == "ar" ? "English" : "عربي",
                          )),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        onTap: () {
                          NavigationService.push(
                              context, Routes.selCarFormPage);
                        },
                        buttonText: translate(LocaleKeys.sellChangeCat) ,
                        width: deviceWidth * 0.30,
                        height: 40.h,
                        backgroundColor: ColorManager.white,
                        borderColor: ColorManager.primaryColor,
                        textColor: ColorManager.primaryColor,
                        radius: 10.r,
                      )
                    ]),
                  ),
                ),
               ! userProvider.isAuth ? const SizedBox(): VerticalSpace(10.h)   ,
                userProvider.isAuth ?  const SizedBox()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {
                        NavigationService.push(
                            context, Routes.loginScreen);
                      },
                      buttonText: translate(LocaleKeys.signInUser),
                      width: deviceWidth * 0.30,
                      height: 40.h,
                      backgroundColor: ColorManager.white,
                      borderColor: ColorManager.primaryColor,
                      textColor: ColorManager.primaryColor,
                      radius: 10.r,
                    ) ,
                    HorizontalSpace(10.w) ,
                    CustomButton(
                      onTap: () {
                        NavigationService.push(
                            context, Routes.showRoomLoginPage);
                      },
                      buttonText: translate(LocaleKeys.signInAgency) ,
                      width: deviceWidth * 0.38,
                      height: 40.h,
                      backgroundColor: ColorManager.white,
                      borderColor: ColorManager.primaryColor,
                      textColor: ColorManager.primaryColor,
                      radius: 10.r,
                    )
                  ],
                ),
               ! userProvider.isAuth ? const SizedBox(): VerticalSpace(30.h)   ,
                /*  DrawerTile(
                  svgIcon: AssetsManager.sedanIcon,
                  title: "سيارة",
                  onTap: () =>
                      NavigationService.push(context, Routes.bottomNavigationBar),
                ),
                */

                DrawerTile(
                  svgIcon: AssetsManager.sedanIcon,
                  title: translate(LocaleKeys.newCars),
                  onTap: () =>
                      NavigationService.push(context, Routes.latestNewCarPage),
                ),
                DrawerTile(
                  svgIcon: AssetsManager.sedanIcon,
                  title:translate(LocaleKeys.usedCars),
                  onTap: () =>
                      NavigationService.push(context, Routes.usedCarsPage),
                ),
                DrawerTile(
                  svgIcon: AssetsManager.sedanIcon,
                  title: translate(LocaleKeys.guaranteCars),
                  onTap: () =>
                      NavigationService.push(context, Routes.guaranteeCarPage),
                ),
                DrawerTile(
                  icon: Icons.location_on_rounded,
                  title: translate(LocaleKeys.trackUrRequest),
                  onTap: () {
                    NavigationService.push(context, Routes.trackYourRequest);
                  },
                ),
                DrawerTile(
                  svgIcon: AssetsManager.replaceCarIcon,
                  title: translate(LocaleKeys.sellChangeCat),
                  onTap: () {
                    NavigationService.push(context, Routes.selCarFormPage);
                  },
                ),
                shared?.getString('token') == null ?  DrawerTile(
                  svgIcon: AssetsManager.carDealersIcon,
                  title: translate(LocaleKeys.signInAgency),
                  onTap: () {
                    NavigationService.push(context, Routes.showRoomLoginPage);
                  },


                ) : SizedBox(),
                userProvider.endUser == null ?
                DrawerTile(
                  icon: Icons.person,
                  title: translate(LocaleKeys.signInUser),
                  onTap: () {
                    NavigationService.push(context, Routes.loginScreen);
                  },
                ) : const SizedBox(),
                const Divider(color: ColorManager.greyColorCBCBCB),
                DrawerTile(
                  svgIcon: AssetsManager.carDealersIcon,
                  title: translate(LocaleKeys.showRooms),
                  onTap: () =>
                      NavigationService.push(context, Routes.carShowRoomPage),
                ),
                const Divider(color: ColorManager.greyColorCBCBCB),
                DrawerTile(
                  svgIcon: AssetsManager.carDealersIcon,
                  title: translate(LocaleKeys.agencies),
                  onTap: () {
                    NavigationService.push(context, Routes.allAgencyPage);
                  },
                ),
                const Divider(color: ColorManager.greyColorCBCBCB),
                DrawerTile(
                  icon: Icons.call,
                  title: translate(LocaleKeys.contactUs),
                  onTap: () {
                    //NavigationService.push(context, Routes.ordersScreen);
                  },
                ),
                DrawerTile(
                  icon: Icons.location_city_rounded,
                  title: translate(LocaleKeys.whoAreWe),
                  onTap: () {
                    NavigationService.push(context, Routes.whoWeAre);
                  },
                ),
                DrawerTile(
                  icon: Icons.article_rounded,
                  title: translate(LocaleKeys.termsConditions),
                  onTap: () {
                    NavigationService.push(context, Routes.terms);
                  },
                ),
                DrawerTile(
                  icon: Icons.privacy_tip,
                  title: translate(LocaleKeys.privacy),
                  onTap: () {
                    NavigationService.push(context, Routes.privacy);
                  },
                ),
                DrawerTile(
                  icon: Icons.car_rental,
                  title: translate(LocaleKeys.carReturn),
                  onTap: () {
                    NavigationService.push(context, Routes.carReturn);
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
