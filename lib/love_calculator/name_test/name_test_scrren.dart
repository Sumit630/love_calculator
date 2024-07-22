import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:love_calculatror/global.dart';
import 'package:love_calculatror/love_calculator/date_of_birth/date_of_birth_scrren.dart';
import 'package:love_calculatror/love_calculator/fingerprint/fingerprint_screen.dart';
import 'package:love_calculatror/love_calculator/number_match/number_match_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../horsoscope_match/horsoscope_match_screen.dart';
import '../photo_test/photo_test_screen.dart';

class NameTestScreen extends StatefulWidget {
  const NameTestScreen({super.key});

  @override
  State<NameTestScreen> createState() => _NameTestScreenState();
}

class _NameTestScreenState extends State<NameTestScreen> {
  final TextEditingController _name1Controller = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  final RxString _result = ''.obs;
  final Random _random = Random();
  Timer? _timer;
  final RxInt _countdownValue = 0.obs;

  void _calculateLove() {
    FocusScope.of(context).unfocus();
    String name1 = _name1Controller.text.trim();
    String name2 = _name2Controller.text.trim();

    if (name1.isEmpty || name2.isEmpty) {
      _result('Please enter both names!');
      return;
    }
    _countdownValue.value = 1;
    _result("");
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_countdownValue.value < 80) {
        _countdownValue.value++;
      } else {
        timer.cancel();
        int randomOffset = _random.nextInt(21);
        int compatibilityScore = 80 + randomOffset;
        _result('$compatibilityScore%');
      }
    });
  }

  final GlobalKey _globalKey = GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      Share.shareFiles(['${tempDir.path}/image.png'],
          text:
              'Look  my Love Test after using Love Calculator by\nhttps://play.google.com/store/apps/details?id=com.tradevisor.app');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red,
        title: Text(
          "Love Calculator",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _name1Controller,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _name2Controller,
                decoration: const InputDecoration(
                  labelText: 'Partner\'s Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  //name test
                  if (globalVar.onSelectScreen.value == 0) {
                    _calculateLove();
                  }
                  //photo test Screen
                  else if (globalVar.onSelectScreen.value == 1) {
                    if (_name1Controller.text.isEmpty ||
                        _name2Controller.text.isEmpty) {
                      _result('Please enter both names!');
                      return;
                    }
                    globalVar.name1(_name1Controller.text);
                    globalVar.name2(_name2Controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const PhotoTestScreen();
                      },
                    ));
                  }
                  // date of barth screen
                  else if (globalVar.onSelectScreen.value == 2) {
                    if (_name1Controller.text.isEmpty ||
                        _name2Controller.text.isEmpty) {
                      _result('Please enter both names!');
                      return;
                    }
                    globalVar.name1(_name1Controller.text);
                    globalVar.name2(_name2Controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const DateOfBirthScrren();
                      },
                    ));
                  }
                  // fingerprint screen
                  else if (globalVar.onSelectScreen.value == 3) {
                    if (_name1Controller.text.isEmpty ||
                        _name2Controller.text.isEmpty) {
                      _result('Please enter both names!');
                      return;
                    }
                    globalVar.name1(_name1Controller.text);
                    globalVar.name2(_name2Controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const FingerprintScreen();
                      },
                    ));
                  } else if (globalVar.onSelectScreen.value == 4) {
                    if (_name1Controller.text.isEmpty ||
                        _name2Controller.text.isEmpty) {
                      _result('Please enter both names!');
                      return;
                    }
                    globalVar.name1(_name1Controller.text);
                    globalVar.name2(_name2Controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const NumberMatchScreen();
                      },
                    ));
                  } else if (globalVar.onSelectScreen.value == 5) {
                    if (_name1Controller.text.isEmpty ||
                        _name2Controller.text.isEmpty) {
                      _result('Please enter both names!');
                      return;
                    }
                    globalVar.name1(_name1Controller.text);
                    globalVar.name2(_name2Controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const HorsoscopeMatchScreen();
                      },
                    ));
                  }
                },
                child: const Text('Calculate Love'),
              ),
              const SizedBox(height: 16.0),
              (_countdownValue.value == 0)
                  ? const SizedBox()
                  : RepaintBoundary(
                      key: _globalKey,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset("images/Animation_Hart.json"),
                          Text(
                            _result.value.isEmpty
                                ? '${_countdownValue.value}%'
                                : _result.value,
                            style: GoogleFonts.rubik(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: Text(
                                  _name1Controller.text
                                      .toString()
                                      .toUpperCase()
                                      .substring(0, 1),
                                  style: GoogleFonts.rubik(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: Text(
                                  _name2Controller.text
                                      .toString()
                                      .toUpperCase()
                                      .substring(0, 1),
                                  style: GoogleFonts.rubik(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              (_countdownValue.value == 0)
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        _captureAndSharePng();
                      },
                      child: Text("Share")),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _name1Controller.dispose();
    _name2Controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
