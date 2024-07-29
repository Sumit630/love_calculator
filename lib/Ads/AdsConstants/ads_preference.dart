import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_storage/get_storage.dart';

import '../../global.dart';
import '../Model/AdsData.dart';

class PreferencesManager {
  Dio dio = Dio();
  static  String privacyPolicy = "pp";
  static  String get_Click_Flag = "clickflag";
  static  String get_Adstyle = "Adstyle";
  static  String get_Status = "Adstatus";
  static  String get_Click = "click";
  static  String get_AD_Time = "Adtime";
  static  String get_Ad_Flag = "Adflag";
  static  String admobSplashOpen = "admob-splash-open";
  static  String admobFull = "admob-full";
  static  String admobBanner = "admob-banner";
  static  String admobOpen = "admob-open";
  static  String admobNative = "admob-native";
  static  String adxFull = "adx-full";
  static  String adxBanner = "adx-banner";
  static  String adxOpen = "adx-open";
  static  String adxNative = "adx-native";
  static  String FBFull = "fb-full";
  static  String FBBanner = "fb-banner";
  static  String FBNative = "fb-native";
  static  String splash = "splash";
  static  String admobSplash = "admob-splash";
  //static const String splash = "splash";
//  static const String admobSplash = "admob-splash";

  static  GetStorage prefs = GetStorage();

  static initRemotGetData() async {
    // Set the Remote Config settings
    await _remoteConfing.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(seconds: 10),
    ));

    // Fetch and activate the remote config
    bool fetchSuccessful = await _remoteConfing.fetchAndActivate();
    customPrint("fetch :: ${fetchSuccessful}");
    // Get the adStatus value from remote config
    String adStatus = _remoteConfing.getString("LoveCalculator");
    AdsData adsData = await AdsData.fromJson(jsonDecode(adStatus));
    privacyPolicy="${adsData.pp}";
    get_Click_Flag="${adsData.clickflag}";
    get_Adstyle="${adsData.adstyle}";
    get_Status="${adsData.adstatus}";
    get_Click="${adsData.clickflag}";
    get_AD_Time="${adsData.adtime}";
    get_Ad_Flag="${adsData.adflag}";
    admobFull="${adsData.admobfull}";
    admobBanner="${adsData.admobbanner}";
    admobOpen="${adsData.admobopen}";
    admobNative="${adsData.admobnative}";
    FBFull="${adsData.fbfull}";
    FBBanner="${adsData.fbbanner}";
    FBNative="${adsData.fbnative}";
    splash="${adsData.splash}";
   // privacyPolicy="${adsData.pp}";
    customPrint("adStatus1::${adsData.clickflag}");
    saveServerDataInPreference(adsData);
    print("Remote Config :: $adStatus");
  }
  static final FirebaseRemoteConfig _remoteConfing=FirebaseRemoteConfig.instance;
  static saveServerDataInPreference(AdsData serverData) {
    customPrint("Demarkqwmar112131`3`");
    customPrint("serverData.adstatus :: ${serverData.adstatus}");
    savePre2f(privacyPolicy, serverData.pp);
    savePre2f(get_Click_Flag, serverData.clickflag);
    savePre2f(get_Adstyle, serverData.adstyle);
    savePre2f(get_Status, serverData.adstatus);
    customPrint("Get Status :: ${get_Status.toString()}");
    savePre2f(get_Click, serverData.click);
    savePre2f(get_AD_Time, serverData.adtime);
    savePre2f(get_Ad_Flag, serverData.adflag);
    savePre2f(admobFull, serverData.admobfull);
    savePre2f(admobBanner, serverData.admobbanner);
    savePre2f(admobOpen, serverData.admobopen);
    savePre2f(admobNative, serverData.admobnative);
    savePre2f(FBFull, serverData.fbfull);
    savePre2f(FBBanner, serverData.fbbanner);
    savePre2f(FBNative, serverData.fbnative);

    savePre2f(splash, serverData.splash);
  }
  static String saveData(String data){
    return data;
  }
  static void savePre2f(String key, dynamic value) {
    if (value != null) {
      prefs.write(key, value);
      customPrint("Key :: $key|| Value ::$value");
    } else {
      throw new Exception("Attempting to save non-primitive preference");
    }
  }

  static Object? getPref(String key) {
    return prefs.read(key);
  }
  static Object? getPreWithDefault(String key, Object defValue) {
    Object? returnValue = prefs.read(key);
    return returnValue == null ? defValue : returnValue;
  }

  static void clean() {
    prefs.erase();
  }
}
