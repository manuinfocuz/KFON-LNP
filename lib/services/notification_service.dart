// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/local_providers/local_provider.dart';
// import '../utils/global_variables.dart';
//
// class NotificationService {
//   ///for android purpose
//
//   late AndroidNotificationDetails androidNotificationDetails;
//
//   NotificationService._privateConstructor();
//
//   static final NotificationService instance =
//       NotificationService._privateConstructor();
//
//   late BuildContext context;
//
//   late Function onGetNotification;
//   late Function onTokenRefresh;
//
//   ///for IOS purpose
//
//   final iosNotificationDetails = const DarwinNotificationDetails(
//     presentBadge: false,
//     presentSound: true,
//   );
//
//   ///for define different platforms
//
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future init(Function onGetNotification, Function onTokenRefresh) async {
//     this.onGetNotification = onGetNotification;
//     this.onTokenRefresh = onTokenRefresh;
//     await initNotification();
//   }
//
//   late String? fcmToken;
//
//   void cancelAll() {
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
//
//   ///foreground message it's listen but don't show in notification so use local notification
//
//   void foreGroundMessage(RemoteMessage message) {
//     onGetNotification(message);
//     print("${message.notification?.title}");
//   }
//
//   ///backGround message
//
//   void backGroundMessage(RemoteMessage message) {
//     print("on background");
//     //   onGetNotification();
//   }
//
//   void onTokenrefresh() {
//     FirebaseMessaging.instance.onTokenRefresh.listen((fcmtoken) {
//       fcmToken = fcmtoken;
//       onTokenRefresh(fcmtoken);
//     }).onError((err) {});
//   }
//
//   void setFCMToken() async {
//     fcmToken = await  FirebaseMessaging.instance.getToken();
//     onTokenRefresh(fcmToken);
//     print("fcm token: $fcmToken");
//   }
//
//   ///intial
//   Future initNotification() async {
//     androidNotificationDetails = const AndroidNotificationDetails(
//       "mvvm_channel",
//       "mvvm_channel",
//       // playSound: st.sound,
//       // enableVibration: st.vibrate,
//       // icon: st.icon,
//       importance: Importance.max,
//       priority: Priority.max,
//     );
//     final messaging = FirebaseMessaging.instance;
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     messaging.setForegroundNotificationPresentationOptions(
//       badge: true,
//       alert: true,
//       sound: true,
//     );
//
//     messaging.setAutoInitEnabled(true);
//
//     await messaging.requestPermission(
//       criticalAlert: true,
//     );
//
//     ///forground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       foreGroundMessage(message);
//     });
//
//     ///from background and terminated on click msg
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) async {
//         print("onclick");
//       },
//     );
//
//     messaging.getInitialMessage().then((message) async {
//    //   print("onintial");
//     });
//
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
//
//
// }
//
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message, {BuildContext? context}) async {
//
//   print("${navigatorKey.currentState?.context}");
//   return Future<void>.value();
// }
