import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFFBEC1),
          title: Text(
            "Love Calculator",
            style: GoogleFonts.rubik(
                fontSize: 24, fontWeight: FontWeight.w200, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      } else if (index == 1) {
                        globalVar.onSelectScreen(1);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      } else if (index == 2) {
                        globalVar.onSelectScreen(2);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      } else if (index == 3) {
                        globalVar.onSelectScreen(3);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      } else if (index == 4) {
                        globalVar.onSelectScreen(4);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      } else if (index == 5) {
                        globalVar.onSelectScreen(5);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NameTestScreen();
                          },
                        ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffFFBEC1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            icon[index],
                            Text(
                              "${textList[index]}",
                              style: GoogleFonts.rubik(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
