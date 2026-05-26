// import 'dart:io';
// import 'package:caesar_cipher/core/routes/app_router.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseCloudMessaging {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final AppRouter appRouter;

//   FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
//   late AndroidNotificationChannel _channel;

//   static String? fcmToken;

//   FirebaseCloudMessaging({required this.appRouter});

//   /// Initialize notifications
//   Future<void> initialize() async {
//     await _setupFlutterNotifications();
//     await _setupInteractedMessage();
//     await _initializeListeners();
//   }

//   /// iOS + Android notification setup
//   Future<void> _setupFlutterNotifications() async {
//     // iOS: request permissions
//     // Request permissions for both iOS and Android
//     final settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       announcement: false,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//     );

//     print("Permission status: ${settings.authorizationStatus}");

//     // iOS: APNs token
//     if (Platform.isIOS) {
//       // _firebaseMessaging.getAPNSToken().then((apnsToken) {
//       //   print('APNs token: $apnsToken');
//       // });
//     }

//     // Common foreground display config
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iOSInit = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     final initSettings = InitializationSettings(
//       android: androidInit,
//       iOS: iOSInit,
//     );

//     await _flutterLocalNotificationsPlugin?.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: _onNotificationTap,
//     );

//     _channel = const AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'Used for critical alerts.',
//       importance: Importance.max,
//       playSound: true,
//     );

//     await _flutterLocalNotificationsPlugin!
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(_channel);
//   }

//   /// Terminated + background notification handling
//   Future<void> _setupInteractedMessage() async {
//     final initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleMessage(initialMessage);
//     }

//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }

//   /// Foreground + token + topic
//   Future<void> _initializeListeners() async {
//     if(Platform.isIOS){
//         return ;
//     }
//     // Token
//     _firebaseMessaging
//         .getToken()
//         .then((token) {
//           fcmToken = token;
//           print('FCM token: $token');
//         })
//         .catchError((e) {
//           print("Error fetching FCM token: $e");
//         });

//     // Subscribe to topic
//     await _firebaseMessaging.subscribeToTopic("caesar-cipher");

//     // Foreground listener
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Foreground message: ${message.data}");
//       _showNotification(message);
//     });
//   }

//   /// Show foreground notification manually
//   void _showNotification(RemoteMessage message) {
//     final notification = message.notification;
//     final android = message.notification?.android;

//     if (notification != null && android != null) {
//       _flutterLocalNotificationsPlugin?.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _channel.id,
//             _channel.name,
//             channelDescription: _channel.description,
//             icon: android.smallIcon ?? '@mipmap/ic_launcher',
//           ),
//           iOS: const DarwinNotificationDetails(),
//         ),
//         payload: message.data['type'],
//       );
//     }
//   }

//   /// When user taps notification (foreground)
//   void _onNotificationTap(NotificationResponse response) {
//     final type = response.payload;
//     print("Notification tap payload: $type");

//     if (type == 'chat') {
//       // appRouter.push(const ChatRoute());
//     }
//   }

//   /// Background/terminated state tap
//   void _handleMessage(RemoteMessage message) {
//     final type = message.data['type'];
//     print("Message opened: $type | ${message.data}");

//     if (type == 'chat') {
//       // appRouter.push(const ChatRoute());
//     }
//   }
// }
