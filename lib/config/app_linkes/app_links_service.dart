import 'package:app_links/app_links.dart';
import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/network/endpoints.dart';
import '../../main.dart';
import '../../presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import '../../presentation/latest_new_cars/view/new_car_details.dart';
import '../../src/cars/pages/car_details_page.dart';

class AppLinkingService {
  static  AppLinks _appLinks = AppLinks();
  static init(BuildContext context) {
    goToRoute(context);  // Check initial link if app was in cold state (terminated)

    // Handle link when app is in warm state (front or background)
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.path.isEmpty) return;
      try {
        String id = uri.path.split('/').last;
        print('appLinks route id path555 $id');
        NavigationService.navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => CarDetailsPage(id: int.parse(id))),
        );

      } on Exception catch (e) {
        NavigationService.navigationKey.currentState?.pushNamed(
            Routes.splashScreen,);
        print('appLinks error $e');
      }
    });
  }
  //
  static goToRoute(BuildContext context2) async {
    try {
      final uri = await _appLinks.getInitialAppLink();
      if (uri == null) return;
      String id = uri.path.split('/').last;
      print('appLinks route id path dsfdsf$id');
      BuildContext appContext = NavigationService.navigationKey.currentContext!;
      await  Navigator.push(appContext, MaterialPageRoute(builder: (appContext) => CarDetailsPage(
        id: int.parse(id),
      )));
//car feature
    } on Exception catch (e) {
      print('appLinks goToRoute error $e');
    }
  }

  static createDynamicLink(String id) {
    String lang = appContext.locale.languageCode;
    return 'https://automobile-egy.com/$lang/cars/show/$id';
  }
}
