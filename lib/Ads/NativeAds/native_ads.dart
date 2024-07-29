import 'dart:io';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../../global.dart';
import '../AdsConstants/ads_constants.dart';
import '../AdsConstants/ads_preference.dart';

class NativeAds extends StatefulWidget {
  NativeAds({
    Key? key,
  }) : super(key: key);

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  late NativeAd _ad;
  bool isLoad = false;

  bool showFacebook = false;

  @override
  void initState() {
    super.initState();
    nativeAds();
    customPrint("e22314222221");
  }


  @override
  Widget build(BuildContext context) {
    if(PreferencesManager.get_Status=="on"){
      if (isLoad) {
        return _admobNative();
      } else if(showFacebook){
        return _facebookNative();
      }else {
        return _facebookNative();
      }
    }
    return SizedBox();
  }

  @override
  void dispose() {
    try{
      _ad.dispose();
    }catch(e){
      debugPrint("$e");
    }
    super.dispose();
  }

  _admobNative() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: Platform.isAndroid?100:300,
        child: AdWidget(
          ad: _ad,
        ),
      ),
    );
  }

  _facebookNative(){
    return Container(
      child: Stack(
        children: [
          shimmerView(),
          _nativeAd(),
        ],
      ),
    );
  }

  nativeAds() {
    showFacebook=false;
    if (PreferencesManager.get_Status == "on") {
      customPrint("sdghsrthewr1112");
      if (PreferencesManager.get_Adstyle == "normal") {
        if (PreferencesManager.get_Ad_Flag == "admob") {
          loadNativeAdMobAd();
        }
      } else if (PreferencesManager.get_Adstyle ==
          "ALT") {
        if (Constant.Alt_Cnt_Native == 2) {
          loadNativeAdMobAd();
          Constant.Alt_Cnt_Native = 1;
        } else {
           _facebookNative();
          showFacebook=true;
          setState(() {});
          Constant.Alt_Cnt_Native++;
        }
      } else if (PreferencesManager.get_Adstyle ==
          "fb") {
          showFacebook=true;
          setState(() {});
        }
    }
  }


  loadNativeAdMobAd() {
    customPrint("sfaewerwg");
    _ad = NativeAd(
      adUnitId:PreferencesManager.admobNative,
      request: const AdRequest(),
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          setState(() {
            isLoad = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          setState(() {
            isLoad = false;
          });
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )
      ..load();
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: PreferencesManager.FBNative,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  shimmerView(){
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 48.0,
                    height: 48.0,
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
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 165,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
              ),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
