import 'package:flutter/material.dart';
import 'package:love_calculatror/global.dart';

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
            ListView.builder(
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return const LoveQutoesPetaListShow();
                    },));
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
          ],
        ),
      ),
    );
  }
}
