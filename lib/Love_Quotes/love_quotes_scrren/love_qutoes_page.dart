import 'package:flutter/material.dart';
import 'package:love_calculatror/global.dart';

import '../../Ads/BannerAds/banner_ads.dart';
import '../../Ads/IntrestialAds/intrestial_ads.dart';
import '../../Ads/NativeAds/native_ads.dart';
import 'love_qutoes_peta_list_show.dart';

class LoveQutoesPage extends StatefulWidget {
  const LoveQutoesPage({super.key});

  @override
  State<LoveQutoesPage> createState() => _LoveQutoesPageState();
}

class _LoveQutoesPageState extends State<LoveQutoesPage> {
  List<String> nameList=[
    "Love Messages",
    "Romantic MSG",
    "Heart&Kiss",
    "Sad Love",
    "Valentine",
    "Crush",
    "Love Stories",
    "Anniversary Wishes",
    "Marriage Wishes",
    "Romantic Quotes",
    "Baby wishes",
  ];
  List<String> totalCount=[
    "35",
    "27",
    "10",
    "45",
    "65",
    "23",
    "16",
    "10",
    "23",
    "26",
    "11",
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Love  Quotes",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontFamily: "loveLike")),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height:screenHeight/2,
              width: screenWidth,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Card(
                  elevation: 1,
                  child:ListTile(
                    onTap: () {
                      globalVar.loveQuotesTitel(nameList[index]);
                      globalVar.totalCountLove(totalCount[index]);
                      InterstitialAds.showAds(callBack : (){
                        nextPageFade(const  LoveQutoesPetaListShow());
                      });
                      //nextPageFade(LoveQutoesPetaListShow());
                    },
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${totalCount[index]}   ',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "loveLike")),
                            TextSpan(
                              text: nameList[index],
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontFamily: "loveLike"),
                            ),
                          ],
                        ),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(
              height: 10,
            ),
            _buildBodyView(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
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
  Widget _buildBodyView(){
    customPrint("222222");
    return Center(
      child: NativeAds(),
    );
  }
}
