import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

class FirebaseService {
  // for sending push notification
  static Future<void> sendPushNotification(String name, String fcmToken) async {
    try {
      final body = {
        "to": 'eEwTgl8bS6SAXqhJA32Yao:APA91bG-oaBR-n9AAowQoprE_Nt7vBH03DxVYR101aR-nmKLPSxxzPkqHEo8B7AVi-gxzsm-OiThPh6Qc6heptZGcnJzpDlPQhE5wrgcSOxDNG5Q4sUnwVvuvNkVlZAO5vgsP6rSHMvf',
        "notification": {
          "title": name,
          "body": 'Someone seems to be interested in your car!',
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAACToefKw:APA91bGsAW6dezxrQxIteRSBBqlTqQu-75FMhvDdKVrqdvAzISIdJW2yhM3J8vlhUB-5bWUEglymeSaq4P5qJC4CHvHoKOlr-BIOHk2QPGUMueIJx55m3KwBrbgQ1BAuBGGQMzRTHbYI'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

}