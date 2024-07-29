import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Ads/BannerAds/banner_ads.dart';
import '../Ads/IntrestialAds/intrestial_ads.dart';
import '../global.dart';
import '../love_calculator/name_test/name_test_scrren.dart';

class HomeScrren extends StatefulWidget {
  const HomeScrren({super.key});

  @override
  State<HomeScrren> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScrren> {
  List icon = [
    const Icon(
      Icons.drive_file_rename_outline,
      color: Colors.white,
      size: 50,
    ),
    const Icon(
      Icons.photo_album_outlined,
      color: Colors.white,
      size: 50,
    ),
    const Icon(
      Icons.date_range,
      color: Colors.white,
      size: 50,
    ),
    const Icon(
      Icons.fingerprint,
      color: Colors.white,
      size: 50,
    ),
    const Icon(
      Icons.numbers,
      color: Colors.white,
      size: 50,
    ),
    const Icon(
      Icons.border_horizontal_sharp,
      color: Colors.white,
      size: 50,
    ),
  ];
  List<String> textList = [
    "Name Test",
    "Photo Test",
    "Date of Birth Match",
    "Fingerprint Match",
    "Number Match",
    "Horoscope Match",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: InkWell(
              onTap: () {
                InterstitialAds.showAds(callBack : (){
                  Navigator.pop(context);
                });
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
          title: const Text(
            "Love Calculator",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
                fontFamily: "loveLike"
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        globalVar.onSelectScreen(0);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });

                      } else if (index == 1) {
                        globalVar.onSelectScreen(1);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });
                      } else if (index == 2) {
                        globalVar.onSelectScreen(2);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });
                      } else if (index == 3) {
                        globalVar.onSelectScreen(3);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });
                      } else if (index == 4) {
                        globalVar.onSelectScreen(4);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });
                      } else if (index == 5) {
                        globalVar.onSelectScreen(5);
                        InterstitialAds.showAds(callBack : (){
                          nextPageFade(const NameTestScreen());
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color:Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            icon[index],
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${textList[index]}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                  fontFamily: "loveLike"
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 35,
              ),
              _buildBottomBar(),
            ],
          ),
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
}
