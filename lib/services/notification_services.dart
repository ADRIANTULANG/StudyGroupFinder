import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationServices extends GetxService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token;

  @override
  Future<void> onInit() async {
    if (await checkNotificationPermission() == true) {
      await notificationSetup();
      await onBackgroundMessage();
      await onForegroundMessage();
    }
    ;

    super.onInit();
  }

  Future<void> notificationSetup() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
        ),
        NotificationChannel(
          channelKey: 'basic_channel_muted',
          channelName: 'Basic muted notifications ',
          channelDescription: 'Notification channel for muted basic tests',
          importance: NotificationImportance.High,
          playSound: false,
        )
      ],
    );
  }

  Future<void> onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');

          // if (Get.find<StorageService>().storage.read("notificationSound") ==
          //     true) {
          //   AwesomeNotifications().createNotification(
          //     content: NotificationContent(
          //       id: Random().nextInt(9999),
          //       channelKey: 'basic_channel',
          //       title: '${message.notification!.title}',
          //       body: '${message.notification!.body}',
          //       notificationLayout: NotificationLayout.BigText,
          //     ),
          //   );
          // } else {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: Random().nextInt(9999),
              channelKey: 'basic_channel_muted',
              title: '${message.notification!.title}',
              body: '${message.notification!.body}',
              notificationLayout: NotificationLayout.BigText,
            ),
          );

          // }

          // call_unseen_messages();
        }
      },
    );
  }

  Future<bool> checkNotificationPermission() async {
    var res = await messaging.requestPermission();
    print("notification status: ${res.authorizationStatus}");
    if (res.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else {
      return false;
    }
    // if (Get.find<StorageService>().storage.read('token') == "") {
    //   await getToken();
    // }
  }

  sendNotification(
      {required String userToken,
      required String deviceName,
      required String time}) async {
    var body = jsonEncode({
      "to": "$userToken",
      "notification": {
        "body": "You login on $deviceName, $time",
        "title": "New Device login",
        "subtitle": "",
      }
    });

    var response =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              "Authorization":
                  "key=AAAAETv7uhA:APA91bEshE-L4T4-5JQRP6GvCAu18QSpAOrWjT4xRpcIy7yuoEB5OWm4-dQtfG_-2L8CSyG4gJZ4IZ_NfNCOpb_-TKHeEy6vUnhvZ9Rp3oye0iECh6Vg1Ay5H7hB88xaoLTe8SjFxYVK",
              "Content-Type": "application/json"
            },
            body: body);
    print(response.statusCode);
  }

  Future<String> getToken() async {
    token = await messaging.getToken();
    return token!;
  }
}

Future<void> onBackgroundMessage() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');

    // if (Get.find<StorageService>().storage.read("notificationSound") ==
    //     true) {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: Random().nextInt(9999),
    //       channelKey: 'basic_channel',
    //       title: '${message.notification!.title}',
    //       body: '${message.notification!.body}',
    //       notificationLayout: NotificationLayout.BigText,
    //     ),
    //   );
    // } else {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(9999),
        channelKey: 'basic_channel_muted',
        title: '${message.notification!.title}',
        body: '${message.notification!.body}',
        notificationLayout: NotificationLayout.BigText,
      ),
    );

    // }

    // call_unseen_messages();
  }
}
