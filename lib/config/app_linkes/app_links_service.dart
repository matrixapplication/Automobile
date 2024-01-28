import 'package:app_links/app_links.dart';
import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:flutter/material.dart';

import '../../core/services/network/endpoints.dart';

class AppLinkingService {
  static  AppLinks _appLinks = AppLinks();

  // static Future<void> initDeepLinks() async {
  //   _appLinks = AppLinks();
  //
  //   // Check initial link if app was in cold state (terminated)
  //   final appLink = await _appLinks.getInitialAppLink();
  //   if (appLink != null) {
  //     print('getInitialAppLink: $appLink');
  //     openAppLink(appLink);
  //   }
  //
  //   // Handle link when app is in warm state (front or background)
  //     _appLinks.uriLinkStream.listen((uri) {
  //     print('onAppLink: $uri');
  //     openAppLink(uri);
  //   });
  // }
  //
  // static void openAppLink(Uri uri) {
  //   // pushNamed(uri.fragment);
  // }

  static init() {
    goToRoute();  // Check initial link if app was in cold state (terminated)

    // Handle link when app is in warm state (front or background)
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.path.isEmpty) return;
      try {
        String route = uri.path.split('/')[uri.pathSegments.length - 1];
        String id = uri.path.split('/').last;
        print('appLinks route id path $id');
        print('appLinks uri $route');
        NavigationService.navigationKey.currentState?.pushNamed(
            Routes.latestNewCarsDetails,
            arguments: {"carModel": {}, "isShowRoom": true});

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
      String route = uri.path.split('/')[uri.pathSegments.length - 1];
      String id = uri.path.split('/').last;
      print('appLinks route id path $id');
      print('appLinks uri $route');
      await  NavigationService.navigationKey.currentState?.pushNamed(
          Routes.latestNewCarsDetails,
          arguments: {"carModel": {}, "isShowRoom": true});
    } on Exception catch (e) {
      print('appLinks goToRoute error $e');
    }
  }

  static createDynamicLink(String route, {String? id}) {
    return '${NetworkPath.hostName}/$route/$id';
  }
}
