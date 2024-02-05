import 'package:app_links/app_links.dart';
import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/data/data_sourse/firebase/firebase_notification.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:automobile_project/presentation/latest_new_cars/view/new_car_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/navigation/navigation_services.dart';
import '../config/navigation/route_generator.dart';
import '../config/navigation/routes.dart';
import '../config/themes/theme_manager.dart';
import '../core/utils/constants.dart';
import '../providers.dart';
import '../translations/codegen_loader.g.dart';
import 'config/app_linkes/app_links_service.dart';
import 'domain/logger.dart';
import 'injections.dart' as di;
import 'package:easy_localization/easy_localization.dart';

SharedPreferences? shared ;
Locale? lang ;
late BuildContext appContext ;
void handleMessage(RemoteMessage message) async {
  if (message == null) return;
  if (kDebugMode) {
    log("notification message ", "Title ===> ${message.notification?.title}");
    log("notification message ", "body ===> ${message.notification?.body}");
    // log("notification payload ", "PayLoad ===> ${message.data??{}}");
  }
  try {
    if (message.data.isNotEmpty) {
      if (message.data['type'] == 'general') {
        NavigationService.navigationKey.currentState
            ?.pushNamed(Routes.bottomNavigationBar  ,arguments: {
              "selectedIndex" : 3
        });
      }
      if (message.data['type'] == "approved_showroom_car") {
        NavigationService.navigationKey.currentState
            ?.pushNamed(Routes.bottomNavigationBar  ,arguments: {
          "selectedIndex" : 3
        });
        // final showCarViewModel = Provider.of<ShowRoomSellCarViewModel>(appContext , listen: false);
        // final result  = await showCarViewModel.showCarDetails(context: appContext,   id: message.data['id']) ;
        // if(result.isSuccess){
        //   if(result.data?.status?.name =='new'){
        //     if(result.data?.modelRole == "agency" || result.data?.modelRole == "showroom" ){
        //       NavigationService.navigationKey.currentState?.pushNamed(
        //           Routes.latestNewCarsDetails,
        //           arguments: {"carModel": result.data, "isShowRoom": true});
        //     }else{
        //       if(result.data?.modelRole == "agency" || result.data?.modelRole == "showroom"){
        //         NavigationService.navigationKey.currentState?.pushNamed(
        //             Routes.usedCarDetailsPage,
        //             arguments: {"carModel": result.data, "isShowRoom": true});
        //       }
        //     }
        //   }else{
        //     if(result.data?.modelRole == "user"){
        //       NavigationService.navigationKey.currentState?.pushNamed(
        //           Routes.usedCarDetailsPage,
        //           arguments: {"carModel": result.data, "isShowRoom": false});
        //     }else{
        //       NavigationService.navigationKey.currentState?.pushNamed(
        //           Routes.usedCarDetailsPage,
        //           arguments: {"carModel": result.data, "isShowRoom": true});
        //     }
        //   }
        // }


      } else {
        NavigationService.navigationKey.currentState
            ?.pushNamed(Routes.bottomNavigationBar  ,arguments: {
          "selectedIndex" : 3
        });
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
Future<void> handleBackGroundMessage(RemoteMessage message) async {
  print("handleBackGroundMessage");
  if (message.notification == null) return;
  handleMessage(message) ;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()  ;
  FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);
  await FireBaseAPI().initNotification() ;
  await EasyLocalization.ensureInitialized();
  await di.init();

  await Future.delayed(const Duration(milliseconds: 400), () async {
    shared =await  SharedPreferences.getInstance() ;
    String? cachedLnag = shared!.getString("lang") ;
    if(cachedLnag == "ar"){
      lang = const Locale("ar") ;
      await shared!.setString("lang", "ar") ;
    }else{
      lang = const Locale("en") ;
      await shared!.setString("lang", "en") ;
    }
    runApp(AppProviders(
        child: EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            assetLoader: const CodegenLoader(),
            child: const MyApp())));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("MyApp build ${DateTime.now()}");
    AppLinkingService.init(context);
    appContext = context;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorManager.primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: lang ?? context.locale,
      title: Constants.appName,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
