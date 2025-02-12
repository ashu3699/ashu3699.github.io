// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize() async {
//     if (Platform.isAndroid) {
//       _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()!
//           .requestNotificationsPermission();
//     }
//     if (Platform.isIOS) {
//       _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()!
//           .requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     }

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       // AndroidInitializationSettings("@drawable/ic_stat_ic_notification"),
//       iOS: DarwinInitializationSettings(
//         requestAlertPermission: true,
//         defaultPresentSound: true,
//       ),
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//   }

//   static void display(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//       var android = const AndroidNotificationDetails(
//         "placement",
//         "placement channel",
//         channelDescription: "this is main channel",
//         icon: '@mipmap/ic_launcher',
//         importance: Importance.max,
//         priority: Priority.high,
//         // color: ColorConstants.achBlue,
//         playSound: true,
//       );

//       var iOS = const DarwinNotificationDetails();

//       final NotificationDetails notificationDetails =
//           NotificationDetails(android: android, iOS: iOS);

//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: jsonEncode(message.data),
//       );

//       log('app open notification: ${message.data}');
//     } on Exception catch (e) {
//       log(e.toString());
//     }
//   }
// }

// class FirebaseNotificationSetup {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   FirebaseNotificationSetup() {
//     LocalNotificationService.initialize();

//     // if (kDebugMode) {
//     //   messaging
//     //       .subscribeToTopic('developer')
//     //       .then((value) => print('subscribed to developer'));
//     // }

//     notificationHandler();
//   }

//   Future<void> notificationHandler() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       // announcement: false,
//       badge: true,
//       // carPlay: false,
//       // criticalAlert: false,
//       // provisional: false,
//       sound: true,
//     );
//     log('User granted permission: ${settings.authorizationStatus}');
//     //when app killed and opened
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {});

//     // Foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       LocalNotificationService.display(message);
//     });

//     //opened and minimized
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log('app minimized notification');
//       LocalNotificationService.display(message);
//     });
//   }
// }

// Future backgroundMessageHandler(RemoteMessage? message) async {
//   log('background notification: ${message!.data}');
// }
