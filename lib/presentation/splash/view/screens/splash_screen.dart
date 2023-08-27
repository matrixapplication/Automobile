// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:automobile_project/domain/logger.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/show_room_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/profile/pages/view_model/get_cities_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/body_shape_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_colors_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_features_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_mechanical_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/car_status_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/fuel_types_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/show_rooms_branches_view_model.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/sell_car_brands_view_model/years_view_model.dart';
import 'package:automobile_project/presentation/favourites/view_model/fav_view_model.dart';
import 'package:automobile_project/presentation/my_cars_to_sell/view%20model/get_my_cars_model_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/navigation/navigation.dart';
import '../../../../core/resources/resources.dart';
import '../../../../data/provider/local_auth_provider.dart';
import '../../../component/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      final userProvider =  Provider.of<LocalAuthProvider>(context,listen: false) ;
      await userProvider.getEndUserData();
      print("end user ==> ${userProvider.endUser}");
      await userProvider.getUserData();
      print(" user ==> ${userProvider.user}");
      await getData();
    });
    super.initState();
  }
   getData() async{

     await Provider.of<CarMechanicalViewModel>(context, listen: false)
         .getMechanicalFun(context: context);
     await Provider.of<BodyShapeViewModel>(context, listen: false)
         .getBodyShape(context: context);
     await Provider.of<FuelTypeViewModel>(context, listen: false)
         .getFuelType(context: context);
     await Provider.of<CarFeaturesViewModel>(context, listen: false)
         .getCarFeatures(context: context);
     await Provider.of<YearsViewModel>(context, listen: false)
         .getYears(context: context);
     await Provider.of<CarColorsViewModel>(context, listen: false)
         .getColors(context: context);
     await Provider.of<GetCitiesViewModel>(context, listen: false)
         .getCities(context: context);
     Provider.of<ShowRoomsViewModel>(context, listen: false).getShowRooms(context: context, isClear: true);
     Provider.of<ShowRoomsViewModel>(context, listen: false).getAgencies(context: context, isClear: true);

    final localAuthProvider =
        Provider.of<LocalAuthProvider>(context, listen: false);
    bool? isLogin = await localAuthProvider.isLogin();

    if (kDebugMode) {
      print("is User Login ? ===>$isLogin");
    }
    String? role = await localAuthProvider.getUserRole();
     await Provider.of<CarStatusViewModel>(context , listen: false).getCarStatus(context: context) ;

     if(role == "showroom" || role == "agency"){
        Provider.of<ShowRoomsBranchesViewModel>(context, listen: false).getBranches(
            context: context,
            id: localAuthProvider.user?.id);

      await localAuthProvider.getUserData();
      if(localAuthProvider.user != null){
        Future.delayed(const Duration(seconds: 3), () async {
          NavigationService.pushReplacement(
            context,
            Routes.bottomNavigationBar,
          );
        });
      }else{
        Future.delayed(const Duration(seconds: 3), () async {
          if(localAuthProvider.checkFirstTime()){
            NavigationService.pushReplacement(
              context,
              Routes.onBoardingPage,
            );
          }else{
            NavigationService.pushReplacement(
              context,
              Routes.bottomNavigationBar,
            );
          }

        });
      }

    }else{
      await localAuthProvider.getEndUserData();

        if(localAuthProvider.user != null){
          Provider.of<FavViewModel>(context, listen: false).getMyCars(context: context) ;
          Future.delayed(const Duration(seconds: 3), () async {
            NavigationService.pushReplacement(
              context,
              Routes.bottomNavigationBar,
            );
          });
        }else{
          Future.delayed(const Duration(seconds: 3), () async {
            if(localAuthProvider.checkFirstTime()){
              NavigationService.pushReplacement(
                context,
                Routes.onBoardingPage,
              );
            }else{
              NavigationService.pushReplacement(
                context,
                Routes.bottomNavigationBar,
              );
            }
          });
      }
    }
    log("tag", role.toString());
    log("end user entity ", localAuthProvider.endUser.toString());
    log("user entity ", localAuthProvider.user.toString());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomAssetsImage(
          image: AssetsManager.appLogo,
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }
}
