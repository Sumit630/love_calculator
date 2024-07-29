import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../AdsConstants/ads_constants.dart';
import '../AdsConstants/ads_preference.dart';

class DisplayBannerAds extends StatefulWidget {
  const DisplayBannerAds({Key? key}) : super(key: key);

  @override
  State<DisplayBannerAds> createState() => _DisplayBannerAdsState();
}

class _DisplayBannerAdsState extends State<DisplayBannerAds> {


  BannerAd? bannerAd;
  bool isBannerAdReady = false;
  bool showFacebook = false;
  bool showShimmer=true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InitBannerAds();
  }

  InitBannerAds() {

    bannerAd=null;
    showFacebook = false;
    showShimmer = true;
    setState(() {});


    if (PreferencesManager.get_Status == "on") {
      if (PreferencesManager.get_Adstyle == "normal") {
        if (PreferencesManager.get_Ad_Flag ==
            "admob") {
          loadBannerAdAdMob();
        }
      } else if (PreferencesManager.get_Adstyle ==
          "ALT") {
        if (Constant.Alt_Cnt_Banner == 2) {
          loadBannerAdAdMob();
          Constant.Alt_Cnt_Banner = 1;
          setState(() {});
        } else {
          showFacebook =true;
          Constant.Alt_Cnt_Banner++;
          setState(() {});
        }
      } else if (PreferencesManager.get_Adstyle ==
          "fb") {
        showFacebook =true;
        setState(() {});
      }
    }
  }

  loadBannerAdAdMob() {
    bannerAd = BannerAd(
      adUnitId:PreferencesManager.admobBanner,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          bannerAd = ad as BannerAd?;
          showShimmer = false;
          isBannerAdReady = true;
          setState(() {});
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          isBannerAdReady = false;
          setState(() {});
        },
      ),
    );
    bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) /*=> Obx(()*/ {

        print("_adsController.isBannerAdReady.value ${isBannerAdReady}");
        print("_adsController.showFacebook.value ${showFacebook}");

        if(showFacebook){
          return Stack(
            children: [
              shimmerView(),
              FacebookBannerAd(
                placementId:PreferencesManager.FBBanner,
                bannerSize: BannerSize.STANDARD,
                listener: (result, value) {
                  switch (result) {
                    case BannerAdResult.ERROR:
                      print("Error: $value");
                      break;
                    case BannerAdResult.LOADED:
                      print("Loaded: $value");
                      break;
                    case BannerAdResult.CLICKED:
                      print("Clicked: $value");
                      break;
                    case BannerAdResult.LOGGING_IMPRESSION:
                      print("Logging Impression: $value");
                      break;
                  }
                },
              ),

            ],
          );
        }else if( isBannerAdReady){
          return Container(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: bannerAd!),
          );
        }else {
          return SizedBox();
        }

        /*return _adsController.isBannerAdReady.value || (Banner_Ads.bannerAd!=null)
          ? Container(
              width: Banner_Ads.bannerAd!.size.width.toDouble(),
              height: Banner_Ads.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: Banner_Ads.bannerAd!),
            )
          : FacebookBannerAd(
              placementId:
                  PreferencesManager.getPref(PreferencesManager.FBBanner)
                      as String,
              bannerSize: BannerSize.STANDARD,
              listener: (result, value) {
                switch (result) {
                  case BannerAdResult.ERROR:
                    print("Error: $value");
                    break;
                  case BannerAdResult.LOADED:
                    print("Loaded: $value");
                    break;
                  case BannerAdResult.CLICKED:
                    print("Clicked: $value");
                    break;
                  case BannerAdResult.LOGGING_IMPRESSION:
                    print("Logging Impression: $value");
                    break;
                }
              },
            );*/
      }
      // ),
    );
  }

  shimmerView(){
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                color: Colors.white,
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}