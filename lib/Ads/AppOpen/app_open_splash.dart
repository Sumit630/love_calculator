import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsConstants/ads_preference.dart';

class AppOpenSplash{

  static AppOpenAd? _appOpenAd;

  static AppOpenSplash_Ad({required Function callBack}) {
    if (PreferencesManager.get_Status == "on") {
      loadAdmobAds(callBack);
    }
  }

  static loadAdmobAds(Function callBack) {
    AppOpenAd.load(
      adUnitId: PreferencesManager.admobSplashOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded');
          _appOpenAd = ad;
          _appOpenAd!.show();
          _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('$ad onAdShowedFullScreenContent');
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              _appOpenAd = null;
            },
            onAdDismissedFullScreenContent: (ad) {
              callBack();
              debugPrint('$ad onAdDismissedFullScreenContent');
              ad.dispose();
              _appOpenAd = null;
            },
          );
        },
        onAdFailedToLoad: (error) {
          callBack();
        },
      ),
    );
  }

}