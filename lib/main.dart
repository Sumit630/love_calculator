import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:love_calculatror/splash_screen.dart';

import 'global.dart';

//SharedPreferences? prefs;
// const String appName = "B.AI";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, Widget) {
        return GetMaterialApp(
            theme: ThemeData(useMaterial3: false),
            // theme: ThemeData(useMaterial3: false,primaryColor: colorCustom),
            debugShowCheckedModeBanner: false,
            // color: appColor,
            // home: PaymentScreen());
            home: SplashScreen());
      },
    );
  }
}
