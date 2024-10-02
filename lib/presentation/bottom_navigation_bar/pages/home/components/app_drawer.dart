// ignore_for_file: use_build_context_synchronously

import 'package:automobile_project/core/resources/app_assets.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:automobile_project/presentation/splash/splash.dart';
import 'package:automobile_project/presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/navigation/navigation.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/widget/drop_down.dart';
import '../../../../component/components.dart';
import '../widgets/drawer_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}
///gg
class _AppDrawerState extends State<AppDrawer> {

  final List<DropDownItem> items = [
    DropDownItem(id: 'eg', title: LocaleKeys.egypt.tr(),value: 'eg'),
    DropDownItem(id: 'sa', title: LocaleKeys.saudiArabia.tr(),value:'sa')
  ];
  final res = GetStorage().read('countryId');
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
                const SizedBox(height: 15,),

                Row(
                  children: [
                    const SizedBox(width: 10,),
                    // Expanded(
                    //   child: CustomButton(
                    //     fontSize: 12.sp,
                    //
                    //     onTap: () {
                    //       NavigationService.push(context, Routes.purchaseOrderScreen);
                    //     },
                    //     buttonText: translate(LocaleKeys.purchaseOrder),
                    //     width: deviceWidth * 0.20,
                    //     height: 40.h,
                    //     backgroundColor: ColorManager.white,
                    //     borderColor: ColorManager.primaryColor,
                    //     textColor: ColorManager.primaryColor,
                    //     radius: 10.r,
                    //   ),
                    // ),
                    Expanded(child:   InkWell(
                      onTap: (){
                        NavigationService.push(context, Routes.purchaseOrderScreen);
                      },
                      child:
                      Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child:Text(
                              translate(LocaleKeys.purchaseOrder),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ),
                    ),),
                    const SizedBox(width: 10,),
                    Expanded(child:   InkWell(
                      onTap: (){
                        NavigationService.push(context, Routes.selCarFormPage);
                      },
                      child:
                      Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child:Text(
                              translate(LocaleKeys.sellChangeCat),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                      ),
                    ),),
                    // Expanded(
                    //   child: CustomButton(
                    //     fontSize: 12.sp,
                    //
                    //     onTap: () {
                    //       NavigationService.push(
                    //           context, Routes.selCarFormPage);
                    //     },
                    //     buttonText: translate(LocaleKeys.sellChangeCat) ,
                    //     width: deviceWidth * 0.20,
                    //     height: 40.h,
                    //     backgroundColor: ColorManager.white,
                    //     borderColor: ColorManager.primaryColor,
                    //     textColor: ColorManager.primaryColor,
                    //     radius: 10.r,
                    //   ),
                    // ),

                    const SizedBox(width: 10,),
                    Expanded(child:   InkWell(
                      onTap: (){
                        NavigationService.push(context, Routes.financeCarPage);
                      },
                      child:
                      Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child:Text(
                              translate(LocaleKeys.financeCar),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                      ),
                    ),),
                    // Expanded(
                    //   child: CustomButton(
                    //     onTap: () {
                    //       NavigationService.push(
                    //           context, Routes.financeCarPage);
                    //     },
                    //     fontSize: 12.sp,
                    //     buttonText: translate(LocaleKeys.financeCar) ,
                    //     width: deviceWidth * 0.20,
                    //     height: 40.h,
                    //
                    //     backgroundColor: ColorManager.white,
                    //     borderColor: ColorManager.primaryColor,
                    //     textColor: ColorManager.primaryColor,
                    //     radius: 10.r,
                    //   ),
                    // ),

                    SizedBox(width: 10,),
                  ],
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                  child: Row(children: [
                    Expanded(
                      child: Row(
                        children:  [
                          const Icon(Icons.language),
                          const HorizontalSpace(10),
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

                            await userProider.getUserData();

                            Provider.of<NewCarsShowRoomViewModel>(context , listen: false).getMyCars(context: context, id: null, modelRole: "", states: "new" ,isAll: true);
                            Provider.of<SlidersViewModel>(context, listen: false)
                                .showSliders(context: context);
                            Provider.of<UsedCarsShowRoomViewModel>(context , listen: false).
                            getMyCars(context: context, id: null, modelRole: null, states: "used" ,isAll: true);
                            Provider.of<CarStatusViewModel>(context , listen: false).getCarStatus(context: context);
                            Provider.of<CarMechanicalViewModel>(context, listen: false)
                                .getMechanicalFun(context: context);
                            Provider.of<CarFeaturesViewModel>(context, listen: false)
                                .getCarFeatures(context: context);
                          }, child: CustomText(
                            text: shared!.getString("lang") == "ar" ? "English" : "عربي",
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: DropDownField(
                          backgroundColor: Colors.transparent,
                          // prefixIcon: Icons.flag_circle_outlined,
                          // prefixIconColor: ColorManager.primaryColor,
                          height: 20,
                          value:
                          res=='eg'?
                          items[0]:
                          res=='sa'?
                          items[1]:null,
                          hint: LocaleKeys.country.tr(),
                          items:items,
                          onChanged: (item) {
                            GetStorage().write('countryId', item!.id);
                            showDialog(context: context, builder: (context){
                              return const Center(child: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: CircularProgressIndicator()),);
                            });
                            WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
                              final userProider =  Provider.of<LocalAuthProvider>(context,listen: false) ;
                              await userProider.getEndUserData();

                              await userProider.getUserData();

                              Provider.of<NewCarsShowRoomViewModel>(context , listen: false).getMyCars(context: context, id: null, modelRole: "", states: "new" ,isAll: true);
                              Provider.of<SlidersViewModel>(context, listen: false)
                                  .showSliders(context: context);
                              Provider.of<UsedCarsShowRoomViewModel>(context , listen: false).
                              getMyCars(context: context, id: null, modelRole: null, states: "used" ,isAll: true);
                              Provider.of<CarStatusViewModel>(context , listen: false).getCarStatus(context: context);
                              Provider.of<CarMechanicalViewModel>(context, listen: false)
                                  .getMechanicalFun(context: context);
                              Provider.of<CarFeaturesViewModel>(context, listen: false)
                                  .getCarFeatures(context: context);
                            });
                            Future.delayed(const Duration(seconds: 2)).then((value){
                              Navigator.pop(context);
                            });
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const SplashScreen()),
                            //       (Route<dynamic> route) => false,
                            // );
                          }
                      ),
                    ),

                  ]),
                ),

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
                  icon: Icons.format_indent_decrease_outlined,
                  title: translate(LocaleKeys.theFinance),
                  onTap: () {
                    NavigationService.push(context, Routes.financeScreen);
                  },
                ),
                // DrawerTile(
                //   svgIcon: AssetsManager.replaceCarIcon,
                //   title: translate(LocaleKeys.sellChangeCat),
                //   onTap: () {
                //     NavigationService.push(context, Routes.selCarFormPage);
                //   },
                // ),
                // shared?.getString('token') == null ?  DrawerTile(
                //   svgIcon: AssetsManager.carDealersIcon,
                //   title: translate(LocaleKeys.signInAgency),
                //   onTap: () {
                //     NavigationService.push(context, Routes.showRoomLoginPage);
                //   },
                //
                //
                // ) : SizedBox(),
                // userProvider.endUser == null ?
                // DrawerTile(
                //   icon: Icons.person,
                //   title: translate(LocaleKeys.signInUser),
                //   onTap: () {
                //     NavigationService.push(context, Routes.loginScreen);
                //   },
                // ) : const SizedBox(),

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
                /*
                    ! userProvider.isAuth ? const SizedBox(): VerticalSpace(10.h)   ,
                userProvider.isAuth ?  const SizedBox()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          NavigationService.push(context, Routes.loginScreen);
                        },
                        buttonText: translate(LocaleKeys.signInUser),
                        width: deviceWidth * 0.30,
                        height: 40.h,
                        backgroundColor: ColorManager.white,
                        borderColor: ColorManager.primaryColor,
                        textColor: ColorManager.primaryColor,
                        radius: 10.r,
                      ),
                    ) ,
                    SizedBox(width: 10,),
                    Expanded(
                      child: CustomButton(
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
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),   */
          if(userProvider.isAuth)
            VerticalSpace(30.h)
          else
            ...[

              const Divider(color: ColorManager.greyColorCBCBCB),
              SizedBox(height: 10.h,),
              InkWell(
                onTap: (){
                  NavigationService.push(context, Routes.loginScreen);
                },
                child:
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    width: deviceWidth * 0.30,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Center(
                      child:Text(
                        translate(LocaleKeys.signInUser),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                ),
              ),
              SizedBox(height: 15.h,),
              InkWell(
                onTap: (){
                  NavigationService.push(context, Routes.showRoomLoginPage);
                },
                child:
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    width: deviceWidth * 0.30,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Center(
                      child:Text(
                        translate(LocaleKeys.signInAgency),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                ),
              ),

            ],

                SizedBox(height: 50.h,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
