import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          "Love  Quotes",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: nameList.length,itemBuilder:(context, index) {
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
                          style: GoogleFonts.rubik(
                              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),),
                        TextSpan(
                            text: nameList[index],
                          style: GoogleFonts.afacad(
                              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.redAccent),),
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
