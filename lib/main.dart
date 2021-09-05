import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/authentication/presentation/pages/view/login_page.dart';
import 'package:flutter_push_notification_proj/features/authentication/presentation/pages/view/signup_page.dart';
import 'package:flutter_push_notification_proj/features/chat/presentation/pages/view/chat_list.dart';
import 'package:flutter_push_notification_proj/features/chat/presentation/pages/view/chat_screen.dart';
import 'package:flutter_push_notification_proj/helpers/routing/app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'helpers/dependency_injection/injection_container.dart' as di;
import 'helpers/services/local_notification_service.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Get.toNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Get.toNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: PageConst.login,
        // onGenerateRoute: (settings) => OnGenerateRoute.route(settings),
        getPages: [
          GetPage(
            name: PageConst.login,
            page: () => LoginPage(),
          ),
          GetPage(
            name: PageConst.signup,
            page: () => SignUpPage(),
          ),
          GetPage(
            name: PageConst.chatList,
            page: () => ChatList(),
          ),
          GetPage(
            name: PageConst.chatMessages,
            page: () => ChatScreen(),
          ),
        ],
      ),
      designSize: Size(360, 650),
    );
  }
}

// class PushNotification extends StatefulWidget {
//   static const routeNamed = '/splash';
//
//   @override
//   _PushNotificationState createState() => _PushNotificationState();
// }
//
// class _PushNotificationState extends State<PushNotification> {
//   @override
//   void initState() {
//     super.initState();
//
//     LocalNotificationService.initialize(context);
//
//     ///gives you the message on which user taps
//     ///and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         final routeFromMessage = message.data["route"];
//
//        Get.toNamed(routeFromMessage);
//       }
//     });
//
//     ///forground work
//     FirebaseMessaging.onMessage.listen((message) {
//       if (message.notification != null) {
//         print(message.notification!.body);
//         print(message.notification!.title);
//       }
//
//       LocalNotificationService.display(message);
//     });
//
//     ///When the app is in background but opened and user taps
//     ///on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeFromMessage = message.data["route"];
//
//       Get.toNamed(routeFromMessage);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Text(
//             'ChattyApp',
//             style: Theme.of(context).textTheme.headline4,
//           ),
//         ),
//       ),
//     );
//   }
// }
