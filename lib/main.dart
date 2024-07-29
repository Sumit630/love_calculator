import 'dart:io';

import 'package:direct_link/direct_link.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:love_calculatror/splash_screen.dart';

import 'Ads/AdsConstants/ads_preference.dart';
import 'firebase_optiions.dart';
import 'global.dart';

//SharedPreferences? prefs;
const String appName = "Love Test";

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesManager.initRemotGetData();
  MobileAds.instance.initialize();
  FacebookAudienceNetwork.init();
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
            title: appName,
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
