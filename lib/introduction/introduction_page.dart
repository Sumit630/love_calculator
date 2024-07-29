import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:love_calculatror/home_page/home_scrren.dart';
import 'package:love_calculatror/introduction/Privacy_policy/policy.dart';
import 'package:love_calculatror/introduction/rate_us/rateing_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../Ads/BannerAds/banner_ads.dart';
import '../Ads/IntrestialAds/intrestial_ads.dart';
import '../Ads/NativeAds/native_ads.dart';
import '../Love_Quotes/love_quotes_scrren/love_qutoes_page.dart';
import '../global.dart';
class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  List<IconData>iconList=[
    Icons.thumb_up_alt_rounded,
    Icons.share,
    Icons.policy,
    Icons.more_horiz,
  ];
  List<String> iconText = [
    "Rate Us",
    "Share",
    "Policy",
    "More",
  ];
  List<Color>iconColor=[
    Colors.redAccent,
    Colors.green,
    Colors.grey,
    Colors.pinkAccent,
  ];
  static const platform = MethodChannel('https://play.google.com/store/apps/details?id=com.onlytools.lovecalculator.lovetest.lovecalculatorprank&hl=en-IN');
  Future<void> onIconTap(int index) async {
    // Define what should happen when an icon is tapped
    switch (index) {
      case 0:
      // Handle Rate Us tap
        try {
          await platform.invokeMethod('openPlayStore');
        } on PlatformException catch (e) {
          print("Failed to open Play Store: '${e.message}'.");
        }
        print('Rate Us tapped');
        break;
      case 1:
      // Handle Share tap
        Share.share('Check out this awesome Love Calculator app: https://play.google.com/store/apps/details?id=com.onlytools.lovecalculator.lovetest.lovecalculatorprank&hl=en-IN');
        print('Share tapped');
        break;
      case 2:
      // Handle Policy tap
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          return PrivacyPolicy();
        },));
        print('Policy tapped');
        break;
      case 3:
      // Handle More tap
        print('More tapped');
        break;
      default:
        print('Invalid selection');
    }
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.redAccent,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height:screenHeight/5,
                  width:screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Image.asset("images/hart.png"),

                ),
                ListView.builder(shrinkWrap: true,itemCount: 4,itemBuilder:(context, index) {
                  return InkWell(
                    onTap: () => onIconTap(index),
                    child: Container(
                      height:screenHeight/13,
                      margin:const EdgeInsets.all(10),
                      width:screenWidth,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10),
                        child: Row(
                          children: [
                            Icon(iconList[index], color: iconColor[index]),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${iconText[index]}", style: TextStyle(fontSize: 20,fontFamily: "loveLike",fontWeight: FontWeight.w200)),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Love Calculator",
            style:TextStyle(
              fontSize:30,
                fontFamily: "loveLike",
              color: Colors.white
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("images/love.png")),
                Text("Love Matters",style: TextStyle(color: Colors.black,fontSize:40,fontFamily: "loveLike"),),
                SizedBox(
                  height:70,
                ),
                InkWell(
                  onTap: () {
                    InterstitialAds.showAds(callBack : (){
                      nextPageFade(const  HomeScrren());
                    });
                  },
                  child: Container(
                    height: screenHeight/14,
                    width: screenWidth/3,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    alignment: Alignment.center,
                    child: Text("Love Test",style: TextStyle(
                      fontSize: 24,color: Colors.white,fontFamily: "loveLike"
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    InterstitialAds.showAds(callBack : (){
                      nextPageFade(const  LoveQutoesPage());
                    });
                  },
                  child: Container(
                    height: screenHeight/14,
                    width: screenWidth/3,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    alignment: Alignment.center,
                    child: Text("Love Quotes",style: TextStyle(fontSize: 24,color: Colors.white,fontFamily: "loveLike"),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildBodyView(){
    customPrint("222222");
    return Center(
      child: NativeAds(),
    );
  }
  Widget _buildBottomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: DisplayBannerAds(),
        ),
      ],
    );
  }
}
