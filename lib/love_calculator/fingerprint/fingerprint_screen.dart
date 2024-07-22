import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:love_calculatror/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  RxBool figerPrint1 = false.obs;
  RxBool figerPrint2 = false.obs;

  void _playAudio() {
    assetsAudioPlayer.open(
      volume: 100,
      Audio("audio/fingerprint_audio.mp3"),
    );
  }

  void _stopAudio() {
    assetsAudioPlayer.stop();
  }

  final RxString _result = ''.obs;
  final Random _random = Random();
  final RxInt _countdownValue = 0.obs;
  Timer? _timer;

  void _calculateLove() {
    FocusScope.of(context).unfocus();
    String name1 = globalVar.name1.value;
    String name2 = globalVar.name2.value;

    if (name1.isEmpty || name2.isEmpty) {
      _result('Please enter both names!');
      return;
    }
    _countdownValue.value = 1;
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
    _result("");
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red,
        title: Text(
          "Fingerprint Calculator",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          _playAudio();
                          figerPrint1(true);
                        },
                        onLongPressUp: _stopAudio,
                        child: Container(
                          width: screenWidth / 3,
                          height: screenHeight / 5,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.pinkAccent, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Lottie.asset("images/fingerprint.json"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        (figerPrint1.isTrue)
                            ? globalVar.name1.value
                            : "Your Name",
                        style: GoogleFonts.rubik(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              _playAudio();
                              figerPrint2(true);
                            },
                            onLongPressUp: _stopAudio,
                            child: Container(
                              width: screenWidth / 3,
                              height: screenHeight / 5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.pinkAccent, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Lottie.asset("images/fingerprint.json"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            (figerPrint2.isTrue)
                                ? globalVar.name2.value
                                : "Partner Name",
                            style: GoogleFonts.rubik(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              (figerPrint1.isTrue && figerPrint2.isTrue)
                  ? ElevatedButton(
                      onPressed: () {
                        _calculateLove();
                      },
                      child: const Text("Calculator"))
                  : const SizedBox(),
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
                                  globalVar.name1.value
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
                                  globalVar.name2.value
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
                  ? const SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        _captureAndSharePng();
                      },
                      child: const Text("Share"))
            ],
          ),
        );
      }),
    );
  }
}
