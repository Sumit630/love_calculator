
import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdsConstants/ads_constants.dart';
import '../AdsConstants/ads_preference.dart';

class SplashInterstitialAds {
  static InterstitialAd? interstitialAd;

  static Future showAds({required Function callBack}) async {
    if (PreferencesManager.get_Status == "on") {
      admobInterstitialAdsCreate(callBack);
    }else {
      callBack();
    }
  }

  static admobInterstitialAdsCreate(Function callBack) {
    InterstitialAd.load(
      adUnitId: PreferencesManager.admobSplash,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;

          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              Constant.Front_Counter = 1;
              Constant.IS_TIME_INTERVAL = false;
              Future.delayed(
                  Duration(
                      milliseconds: int.parse(
                              PreferencesManager.get_AD_Time) *
                          10), () {
                debugPrint(
                    'Time ----------- ${int.parse(PreferencesManager.get_AD_Time) * 1000}');
                Constant.IS_TIME_INTERVAL = true;
              });
              callBack();
            },
            // onAdFailedToShowFullScreenContent:
            //     (InterstitialAd ad, AdError error) {
            //   ad.dispose();
            // },
          );

          interstitialAd!.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          callBack();
        },
      ),
    );
  }

}
