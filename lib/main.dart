import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/navigation/navigation_services.dart';
import '../config/navigation/route_generator.dart';
import '../config/navigation/routes.dart';
import '../config/themes/theme_manager.dart';
import '../core/utils/constants.dart';
import '../providers.dart';
import '../translations/codegen_loader.g.dart';
import 'injections.dart' as di;
import 'package:easy_localization/easy_localization.dart';
SharedPreferences? shared ;
Locale? lang ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await di.init();

  await Future.delayed(const Duration(milliseconds: 400), () async {
    shared =await  SharedPreferences.getInstance() ;
    String? cachedLnag = shared!.getString("lang") ;
    if(cachedLnag == "ar"){
      lang = const Locale("ar") ;
    }else{
      lang = const Locale("en") ;
    }
    runApp(AppProviders(
        child: EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            assetLoader: const CodegenLoader(),
            child: const MyApp())));
  });
}
BuildContext? appContext;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    appContext = context;
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
