import 'package:app_links/app_links.dart';
import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/network/endpoints.dart';
import '../../main.dart';
import '../../presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import '../../presentation/latest_new_cars/view/new_car_details.dart';

class AppLinkingService {
  static  AppLinks _appLinks = AppLinks();
  static init(BuildContext context) {
    goToRoute();  // Check initial link if app was in cold state (terminated)

    // Handle link when app is in warm state (front or background)
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.path.isEmpty) return;
      try {
        String id = uri.path.split('/').last;
        print('appLinks route id path $id');
        final showCarViewModel = Provider.of<ShowRoomSellCarViewModel>(context , listen: false);
        final result  = await showCarViewModel.showCarDetails(context: context,   id: int.parse(id)) ;
        print('appLinks route id path $result');
        await  Navigator.pushNamed(context, Routes.latestNewCarsDetails,
            arguments: {"carModel": result.data, "isShowRoom": true});

      } on Exception catch (e) {
        NavigationService.navigationKey.currentState?.pushNamed(
            Routes.splashScreen,);
        print('appLinks error $e');
      }
    });
  }
  //
  static goToRoute() async {
    try {
      final uri = await _appLinks.getInitialAppLink();
      if (uri == null) return;
      String id = uri.path.split('/').last;
      print('appLinks route id path $id');
      final showCarViewModel = Provider.of<ShowRoomSellCarViewModel>(appContext , listen: false);
      final result  = await showCarViewModel.showCarDetails(context: appContext,   id: int.parse(id)) ;
      print('appLinks route id path $result');
      await  platformPageRoute(LatestNewCarsDetails(
        isShowRoom: true,
        carModel: result.data!,
      ));

    } on Exception catch (e) {
      print('appLinks goToRoute error $e');
    }
  }

  static createDynamicLink(String id) {
    String lang = appContext.locale.languageCode;
    return 'https://automobile-egy.com/$lang/cars/show/$id';
  }
}
