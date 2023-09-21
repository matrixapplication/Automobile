// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/local/shared_preferences_keys.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/data/models/end_user/end_user_model.dart';
import 'package:automobile_project/data/provider/local_auth_provider.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/auth/login/view_model/end_user_view_model.dart';
import 'package:automobile_project/presentation/auth/show_room_login/view_model/show_room_login_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/component/custom_button.dart';
import 'package:automobile_project/presentation/latest_new_cars/view_model/show_room_new_cars_view_model.dart';
import 'package:automobile_project/presentation/used_cars/view_model/showroom_used_cars_view_model.dart';
import 'package:automobile_project/translations/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/resources.dart';
import '../../../../component/app_widgets/my_app_bar.dart';
import '../../../../component/components.dart';
import '../../../../component/cutom_shimmer_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? mainImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      final localAuthProvider  = Provider.of<LocalAuthProvider>(context,listen: false) ;
      await localAuthProvider.getEndUserData();
      await localAuthProvider.getUserData();
      print(shared!.getString(SharedPreferencesKeys.kToken)) ;
      print(localAuthProvider.role) ;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LocalAuthProvider>(context , listen: false) ;

    print(userProvider.endUser?.image);
    return Scaffold(
      backgroundColor: ColorManager.greyCanvasColor,
      appBar:PreferredSize(preferredSize: Size.fromHeight(70.h), child:  MyAppbar(
        title: translate(LocaleKeys.profile),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TapEffect(
                onClick: () {
                  NavigationService.push(context, Routes.editProfilePage);
                },
                child: const Icon(
                  Icons.edit,
                  color: ColorManager.black,
                )),
          ),
        ],
      )),
      body: Column(children: [
        Container(
          color: ColorManager.white,

          child: Center(
            child: Column(
              children: [
                shared!.getString("role") == "user" ?
                Consumer<EndUserViewModel>(
                  builder: (_ , viewData , __){
                    return Stack(
                      children: [

                        Container(
                          width: deviceWidth * 0.30,
                          height: deviceWidth * 0.30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ! viewData.isLoading? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(100.r)),
                            child:  CustomShimmerImage(
                              image: userProvider.endUser?.image == null ?
                              "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
                                  :"${userProvider.endUser?.image!}",
                            ),
                          ) : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyProgressIndicator(
                                width: 50.h,
                                height: 50.h,
                                size: 50,
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: TapEffect(
                            onClick: ()async{
                              final XFile? pickedFile =
                              await _picker.pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  mainImage = File(pickedFile.path);
                                  if (kDebugMode) {
                                    print("courseImage =>${pickedFile.path.split("/").last}");
                                  }
                                });
                              }
                              await viewData.userUploadImage(context: context, image: mainImage!) ;
                              final localAuthProvider  = Provider.of<LocalAuthProvider>(context,listen: false) ;
                              await localAuthProvider.getEndUserData();
                              await localAuthProvider.getUserData();
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80),
                                  //set border radius more than 50% of height and width to make circle
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 22.w,
                                    color: ColorManager.primaryColor,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ) ;
                  },
                ) :Consumer<ShowRoomLoginViewModel>(
                  builder: (_ , viewData , __){
                    return Stack(
                      children: [

                        Container(
                          width: double.infinity,
                          height: 250.h,
                          color: ColorManager.primaryColor,
                          child: CustomShimmerImage(
                            image: userProvider.user?.coverImage ?? '',
                            boxFit: BoxFit.fill,
                          ),
                        ) ,
                       Align(
                         alignment: Alignment.bottomLeft,
                         child: Stack(
                           children: [
                             Container(
                               margin: const EdgeInsets.only(top: 100 , left: 20),
                               width: deviceWidth * 0.25,
                               height: deviceWidth * 0.25,
                               decoration:  BoxDecoration(
                                 shape: BoxShape.circle,
                                 border: Border.all(color: ColorManager.primaryColor),
                                 color: ColorManager.white ,
                                 boxShadow: [
                                   BoxShadow(
                                     color: ColorManager.black.withOpacity(0.3) ,
                                     offset: const Offset(0, 0) ,
                                     blurRadius: 58
                                   )
                                 ]
                               ),
                               child: ! viewData.isLoading? ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(100.r)),
                                 child:  CustomShimmerImage(
                                   image: userProvider.user?.image == null ?
                                   "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
                                       :"${userProvider.user?.image!}",
                                   boxFit: BoxFit.fill,
                                 ),
                               ) : Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   MyProgressIndicator(
                                     width: 50.h,
                                     height: 50.h,
                                     size: 50,
                                   ),
                                 ],
                               ),
                             ),
                             Positioned(
                               bottom: 0,
                               right: 0,
                               child: TapEffect(
                                 onClick: ()async{
                                   final XFile? pickedFile =
                                   await _picker.pickImage(source: ImageSource.gallery);
                                   if (pickedFile != null) {
                                     setState(() {
                                       mainImage = File(pickedFile.path);
                                       if (kDebugMode) {
                                         print("courseImage =>${pickedFile.path.split("/").last}");
                                       }
                                     });
                                   }
                                   await viewData.userUploadImage(context: context, image: mainImage!) ;
                                   final localAuthProvider  = Provider.of<LocalAuthProvider>(context,listen: false) ;
                                   await localAuthProvider.getEndUserData();
                                   await localAuthProvider.getUserData();
                                 },
                                 child: Card(
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(80),
                                       //set border radius more than 50% of height and width to make circle
                                     ),
                                     child: Padding(
                                       padding: EdgeInsets.all(8.w),
                                       child: Icon(
                                         Icons.add_a_photo,
                                         size: 22.w,
                                         color: ColorManager.primaryColor,
                                       ),
                                     )),
                               ),
                             )
                           ],
                         ),
                       )
                      ],
                    ) ;
                  },
                ) ,

               shared!.getString("role") =="showroom" || shared!.getString("role") == "agency"?const SizedBox() : Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CustomText(
                     text: "${ userProvider.user?.role == "showroom" || userProvider.user?.role =="agency" ?userProvider.user?.showroomName : userProvider.endUser?.name}",
                     textStyle: Theme.of(context)
                         .textTheme
                         .displayLarge!
                         .copyWith(fontSize: 25.sp),
                   ),
                   CustomText(
                     text: "${userProvider.user?.role == "showroom" || userProvider.user?.role =="agency" ?userProvider.user?.code : userProvider.endUser?.email} ",
                     textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                       fontSize: 20.sp,
                       height: 1,
                       color: ColorManager.greyColor919191,
                     ),
                   ),
                 ],
               )
              ],
            ),
          ),
        ),
        const VerticalSpace(15),
        TapEffect(onClick: (){

          NavigationService.push(context, Routes.editProfilePage);
        }, child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(12.r)),
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorManager.primaryColor,
                    child: Icon(
                      Icons.edit,
                      color: ColorManager.white,
                      size: 30.h,
                    ),
                  ),
                  HorizontalSpace(20.w),
                  CustomText(
                    text: translate(LocaleKeys.editProfile),
                    textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: FontSize.s18.sp,
                      color: ColorManager.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.white,
                  ),
                ]),
          ),
        )),
        const VerticalSpace(15),

        Expanded(child: SingleChildScrollView(
          child: Column(children: [
           shared!.getString("role") == "user"?
           LabelWidget(
                title: translate(LocaleKeys.favourites),
                icon: Icons.favorite_border,
                onTap: () {
                  NavigationService.push(context, Routes.favouritesPage);
                }) : const  SizedBox(),
            // const LabelWidget(title: "Invite Friends", icon: Icons.share),

            LabelWidget(
                title: translate(LocaleKeys.myCars),
                icon: Icons.car_crash_rounded,
                onTap: () {
                  NavigationService.push(context, Routes.myCarsToSellPage);
                }),
           userProvider.user?.role == "showroom" || userProvider.user?.role == "agency" ?
           LabelWidget(
                title: translate(LocaleKeys.myBranches),
                icon: Icons.location_city_outlined ,
                onTap: (){
                  NavigationService.push(context, Routes.showBranches) ;
                },
            )  : const SizedBox()  ,
            const VerticalSpace(10) ,

          ]),
        )),




        SizedBox(
          width: 380.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(text: "${translate(LocaleKeys.language)}: " , textStyle: Theme.of(context).textTheme.titleLarge,) ,
              CustomButton(
                buttonText: "Ar",
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: shared!.getString("lang") == "ar"? ColorManager.white : ColorManager.black ),
                height: 40.h,
                padding: EdgeInsets.all(15.h) ,
                radius: 15.r,
                width: 120.w,
                onTap: ()async{
                  await shared!.setString("lang", "ar") ;
                  context.setLocale(const Locale("ar")) ;
                  lang = const Locale("ar");
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
                   Provider.of<CarMechanicalViewModel>(context, listen: false)
                      .getMechanicalFun(context: context);

                   Provider.of<CarFeaturesViewModel>(context, listen: false)
                      .getCarFeatures(context: context);
                  setState(() {

                  });
                },
                backgroundColor: shared!.getString("lang") == "ar" ? ColorManager.primaryColor : ColorManager.white,
              ) ,
              CustomButton(
                buttonText: "En",


                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: shared!.getString("lang") == "en"? ColorManager.white : ColorManager.black),
                height: 40.h,
                padding: EdgeInsets.all(15.h) ,
                width: 120.w,
                radius: 15.r,
                onTap: ()async{
                  await shared!.setString("lang", "en") ;
                  context.setLocale(const Locale("en")) ;
                  lang = const Locale("en");
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
                   Provider.of<CarMechanicalViewModel>(context, listen: false)
                      .getMechanicalFun(context: context);

                   Provider.of<CarFeaturesViewModel>(context, listen: false)
                      .getCarFeatures(context: context);
                  setState(() {

                  });
                },
                backgroundColor: shared!.getString("lang") == "en" ? ColorManager.primaryColor : ColorManager.white,
              ) ,
            ],
          ),
        ) ,
        const VerticalSpace(10),
        LabelWidget(title: translate(LocaleKeys.logout), icon: Icons.login , onTap: ()async{
           Provider.of<LocalAuthProvider>(context , listen: false).logOut(context: context) ;

          },),
        const VerticalSpace(10),


      ]),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const LabelWidget({
    required this.title,
    this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: () {
        onTap!();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12.r)),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              CircleAvatar(
                backgroundColor: ColorManager.primaryColor,
                child: Icon(
                  icon,
                  color: ColorManager.white,
                  size: 30.h,
                ),
              ),
              HorizontalSpace(20.w),
              CustomText(
                text: title,
                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: FontSize.s18.sp,
                      color: ColorManager.black,
                    ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.black,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
