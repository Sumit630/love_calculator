

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../global.dart';
import '../love_conttroler/love_conttroler_page.dart';

class LoveQutoesPetaListShow extends StatefulWidget {
  const LoveQutoesPetaListShow({super.key});

  @override
  State<LoveQutoesPetaListShow> createState() => _LoveQutoesPetaListShowState();
}

class _LoveQutoesPetaListShowState extends State<LoveQutoesPetaListShow> {
  RxInt curnetIndex=0.obs;
  late FlutterTts flutterTts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customPrint("Index :: ${globalVar.indexOFList}");
    flutterTts = FlutterTts();
  }
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${globalVar.loveQuotesTitel}",
          style: const TextStyle(
            color: Colors.white,
            fontSize:30,
              fontFamily: "loveLike"
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child:Obx(() {
            return Column(
              children: [
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (globalVar.loveQuotesTitel.value == "Love Messages")
                      ? LoveConttrolerPage.nameListLoveMessages.length
                      : (globalVar.loveQuotesTitel.value == "Romantic MSG")
                      ? LoveConttrolerPage.nameListOFRomanticMSG.length
                      : (globalVar.loveQuotesTitel.value == "Heart&Kiss")
                      ? LoveConttrolerPage.nameListOFHeartAndKiss.length
                      : (globalVar.loveQuotesTitel.value == "Sad Love")
                      ? LoveConttrolerPage.nameListOFSadLove.length
                      : (globalVar.loveQuotesTitel.value == "Valentine")
                      ? LoveConttrolerPage
                      .nameListOFValentine.length
                      : (globalVar.loveQuotesTitel.value == "Crush")
                      ? LoveConttrolerPage
                      .nameListOFCrush.length
                      : (globalVar.loveQuotesTitel.value ==
                      "Love Stories")
                      ? LoveConttrolerPage
                      .nameListOFLoveStories.length
                      : (globalVar.loveQuotesTitel.value ==
                      "Anniversary Wishes")
                      ? LoveConttrolerPage
                      .nameListOFAnniversaryWishes
                      .length
                      : (globalVar.loveQuotesTitel
                      .value ==
                      "Marriage Wishes")
                      ? LoveConttrolerPage
                      .nameListOFMarriageWishes
                      .length
                      : (globalVar.loveQuotesTitel
                      .value ==
                      "Romantic Quotes")
                      ? LoveConttrolerPage
                      .nameListOFRomanticQuotes
                      .length
                      : LoveConttrolerPage
                      .nameListOFBabyWishes
                      .length,
                  itemBuilder: (context, index) {
                    return  Container(
                      height: screenHeight/1.1,
                      width: screenHeight,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(19)),
                      ),
                      alignment: Alignment.center,
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: screenHeight,
                                width: screenWidth,
                                //color: Colors.black,
                                child:Row(mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius:const BorderRadius.all(Radius.circular(10))
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("${index+1}",style:const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                          fontFamily: "loveLike"
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("/${globalVar.totalCountLove}",style:const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                        fontFamily: "loveLike"
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: screenHeight,
                                width: screenWidth,
                                child:        SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        (globalVar.loveQuotesTitel.value == "Love Messages")
                                            ? LoveConttrolerPage.nameListLoveMessages[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Romantic MSG")
                                            ? LoveConttrolerPage
                                            .nameListOFRomanticMSG[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Heart&Kiss")
                                            ? LoveConttrolerPage
                                            .nameListOFHeartAndKiss[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Sad Love")
                                            ? LoveConttrolerPage
                                            .nameListOFSadLove[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Valentine")
                                            ? LoveConttrolerPage
                                            .nameListOFValentine[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Crush")
                                            ? LoveConttrolerPage
                                            .nameListOFCrush[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Love Stories")
                                            ? LoveConttrolerPage
                                            .nameListOFLoveStories[
                                        index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Anniversary Wishes")
                                            ? LoveConttrolerPage
                                            .nameListOFAnniversaryWishes[
                                        index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Marriage Wishes")
                                            ? LoveConttrolerPage
                                            .nameListOFMarriageWishes[index]
                                            : (globalVar.loveQuotesTitel.value == "Romantic Quotes")
                                            ? LoveConttrolerPage.nameListOFRomanticQuotes[index]
                                            : LoveConttrolerPage.nameListOFBabyWishes[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                            fontFamily: "loveLike"
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: screenHeight,
                                width: screenWidth,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        FlutterClipboard.copy((globalVar.loveQuotesTitel.value == "Love Messages")
                                            ? LoveConttrolerPage.nameListLoveMessages[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Romantic MSG")
                                            ? LoveConttrolerPage
                                            .nameListOFRomanticMSG[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Heart&Kiss")
                                            ? LoveConttrolerPage
                                            .nameListOFHeartAndKiss[index]
                                            : (globalVar.loveQuotesTitel.value ==
                                            "Sad Love")
                                            ? LoveConttrolerPage
                                            .nameListOFSadLove[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Valentine")
                                            ? LoveConttrolerPage
                                            .nameListOFValentine[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Crush")
                                            ? LoveConttrolerPage
                                            .nameListOFCrush[index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Love Stories")
                                            ? LoveConttrolerPage
                                            .nameListOFLoveStories[
                                        index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Anniversary Wishes")
                                            ? LoveConttrolerPage
                                            .nameListOFAnniversaryWishes[
                                        index]
                                            : (globalVar.loveQuotesTitel
                                            .value ==
                                            "Marriage Wishes")
                                            ? LoveConttrolerPage
                                            .nameListOFMarriageWishes[index]
                                            : (globalVar.loveQuotesTitel.value == "Romantic Quotes")
                                            ? LoveConttrolerPage.nameListOFRomanticQuotes[index]
                                            : LoveConttrolerPage.nameListOFBabyWishes[index]);
                                      },
                                        child: const Icon(Icons.copy,color: Colors.black,)),
                                    InkWell(
                                        onTap: () async {
                                          await flutterTts.setLanguage("en-US");
                                          await flutterTts.setPitch(1.0);
                                          await flutterTts.speak((globalVar.loveQuotesTitel.value == "Love Messages")
                                              ? LoveConttrolerPage.nameListLoveMessages[index]
                                              : (globalVar.loveQuotesTitel.value ==
                                              "Romantic MSG")
                                              ? LoveConttrolerPage
                                              .nameListOFRomanticMSG[index]
                                              : (globalVar.loveQuotesTitel.value ==
                                              "Heart&Kiss")
                                              ? LoveConttrolerPage
                                              .nameListOFHeartAndKiss[index]
                                              : (globalVar.loveQuotesTitel.value ==
                                              "Sad Love")
                                              ? LoveConttrolerPage
                                              .nameListOFSadLove[index]
                                              : (globalVar.loveQuotesTitel
                                              .value ==
                                              "Valentine")
                                              ? LoveConttrolerPage
                                              .nameListOFValentine[index]
                                              : (globalVar.loveQuotesTitel
                                              .value ==
                                              "Crush")
                                              ? LoveConttrolerPage
                                              .nameListOFCrush[index]
                                              : (globalVar.loveQuotesTitel
                                              .value ==
                                              "Love Stories")
                                              ? LoveConttrolerPage
                                              .nameListOFLoveStories[
                                          index]
                                              : (globalVar.loveQuotesTitel
                                              .value ==
                                              "Anniversary Wishes")
                                              ? LoveConttrolerPage
                                              .nameListOFAnniversaryWishes[
                                          index]
                                              : (globalVar.loveQuotesTitel
                                              .value ==
                                              "Marriage Wishes")
                                              ? LoveConttrolerPage
                                              .nameListOFMarriageWishes[index]
                                              : (globalVar.loveQuotesTitel.value == "Romantic Quotes")
                                              ? LoveConttrolerPage.nameListOFRomanticQuotes[index]
                                              : LoveConttrolerPage.nameListOFBabyWishes[index]);
                                        },
                                        child: const Icon(Icons.headphones,color: Colors.black,)),
                                    InkWell(onTap: () {
                                      Share.share((globalVar.loveQuotesTitel.value == "Love Messages")
                                          ? LoveConttrolerPage.nameListLoveMessages[index]
                                          : (globalVar.loveQuotesTitel.value ==
                                          "Romantic MSG")
                                          ? LoveConttrolerPage
                                          .nameListOFRomanticMSG[index]
                                          : (globalVar.loveQuotesTitel.value ==
                                          "Heart&Kiss")
                                          ? LoveConttrolerPage
                                          .nameListOFHeartAndKiss[index]
                                          : (globalVar.loveQuotesTitel.value ==
                                          "Sad Love")
                                          ? LoveConttrolerPage
                                          .nameListOFSadLove[index]
                                          : (globalVar.loveQuotesTitel
                                          .value ==
                                          "Valentine")
                                          ? LoveConttrolerPage
                                          .nameListOFValentine[index]
                                          : (globalVar.loveQuotesTitel
                                          .value ==
                                          "Crush")
                                          ? LoveConttrolerPage
                                          .nameListOFCrush[index]
                                          : (globalVar.loveQuotesTitel
                                          .value ==
                                          "Love Stories")
                                          ? LoveConttrolerPage
                                          .nameListOFLoveStories[
                                      index]
                                          : (globalVar.loveQuotesTitel
                                          .value ==
                                          "Anniversary Wishes")
                                          ? LoveConttrolerPage
                                          .nameListOFAnniversaryWishes[
                                      index]
                                          : (globalVar.loveQuotesTitel
                                          .value ==
                                          "Marriage Wishes")
                                          ? LoveConttrolerPage
                                          .nameListOFMarriageWishes[index]
                                          : (globalVar.loveQuotesTitel.value == "Romantic Quotes")
                                          ? LoveConttrolerPage.nameListOFRomanticQuotes[index]
                                          : LoveConttrolerPage.nameListOFBabyWishes[index]);
                                    },child: const Icon(Icons.share,color: Colors.black,)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
