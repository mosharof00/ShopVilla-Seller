import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:shop_villa_seller/app/routes/app_pages.dart';
import 'app/services/local_store_config.dart';
import 'app/services/notification_manager.dart';
import 'appConfig.dart';
import 'firebase_options.dart';
import 'helper/language.dart';
import 'helper/helper_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///    Initialize Firebase


    await Firebase.initializeApp(
      name:AppConfig.appFirebase,
      options: DefaultFirebaseOptions.currentPlatform,
    );


  await _setupApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => GetMaterialApp(
        textDirection: TextDirection.ltr,
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,

        ///  Routing Initialization
        initialRoute: AppPages.INITIAL,
        initialBinding: SplashScreenBinding(),
        getPages: AppPages.routes,

        ///  Language Initialization
        translations: Languages(),
        locale: HelperUtils.locateLanguage(),
        fallbackLocale: HelperUtils.locateLanguage(),
      ),
      designSize: const Size(360, 800),
    );
  }
}

///  Initialization  Local Storage Hive, Firebase Notification
Future<void> _setupApp() async {
  await HiveService.initHive();
  await HiveService.checkLoginStatus();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationManager().initialize();
  String? firebaseToken;

  if (Platform.isIOS) {
    // await FirebaseMessaging.instance.getAPNSToken();
    // firebaseToken = await FirebaseMessaging.instance.getToken();
  } else {
    firebaseToken = await FirebaseMessaging.instance.getToken();
  }

  if (firebaseToken != null) {
    HiveService.deleteFirebaseToken();
    HiveService.setFirebaseToken(firebaseToken);
    HelperUtils.firebaseToken = (await HiveService.getFirebaseToken())!;
  }
}
