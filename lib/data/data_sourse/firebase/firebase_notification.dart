import 'dart:convert';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/domain/logger.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/sell_cars/view_model/show_room_sell_car_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            ?.pushNamed(Routes.bottomNavigationBar);
      }
      if (message.data['type'] == "approved_showroom_car") {
        final showCarViewModel = Provider.of<ShowRoomSellCarViewModel>(appContext , listen: false);
        final result  = await showCarViewModel.showCarDetails(context: appContext,   id: message.data['id']) ;
        if(result.isSuccess){
          if(result.data?.status?.name =='new'){
            if(result.data?.modelRole == "agency" || result.data?.modelRole == "showroom" ){
              NavigationService.navigationKey.currentState?.pushNamed(
                  Routes.latestNewCarsDetails,
                  arguments: {"carModel": result.data, "isShowRoom": true});
            }else{
              if(result.data?.modelRole == "agency" || result.data?.modelRole == "showroom"){
                NavigationService.navigationKey.currentState?.pushNamed(
                    Routes.usedCarDetailsPage,
                    arguments: {"carModel": result.data, "isShowRoom": true});
              }
            }
          }else{
            if(result.data?.modelRole == "user"){
              NavigationService.navigationKey.currentState?.pushNamed(
                  Routes.usedCarDetailsPage,
                  arguments: {"carModel": result.data, "isShowRoom": false});
            }else{
              NavigationService.navigationKey.currentState?.pushNamed(
                  Routes.usedCarDetailsPage,
                  arguments: {"carModel": result.data, "isShowRoom": true});
            }
          }
        }


      } else {
        NavigationService.navigationKey.currentState?.pushNamed(Routes.bottomNavigationBar);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
Future<void> handleBackGroundMessage(RemoteMessage message) async {
  if (message.notification == null) return;
  handleMessage(message) ;
}
class FireBaseAPI {

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      sound: true,
    );
    initPushNotification();

    configLocalNotification();
    final fcmToken = await _firebaseMessaging.getToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    await sharedPreferences.setString("fcm", fcmToken!) ;
    if (kDebugMode) {
      log("FCM", "Token ===> $fcmToken");
    }


  }

  final androidChannel = const AndroidNotificationChannel(
      "auto_mobile_channel", "auto_mobile_channel",
      importance: Importance.max, description: "auto mobile");

  final _localNotification = FlutterLocalNotificationsPlugin();





  Future initPushNotification() async {


    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value?.notification == null) return;
      handleMessage(value!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      // showNotification(notification.title!, notification.body!, event.data) ;
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              priority: Priority.max,
            ),
          ),
          payload: jsonEncode(event.toMap()));
    });
  }

  void configLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    }
    );
  }

  void showNotification(
      String title, String message, Map<String, dynamic> payLoad) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      playSound: true,
      enableVibration: false,
      importance: Importance.max,
      priority: Priority.max,

    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotification.show(
      1,
      title,
      message,
      platformChannelSpecifics,
      payload: payLoad.toString(),
    );
  }
}
