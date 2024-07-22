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
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HorsoscopeMatchScreen extends StatefulWidget {
  const HorsoscopeMatchScreen({super.key});

  @override
  State<HorsoscopeMatchScreen> createState() => _HorsoscopeMatchScreenState();
}

class _HorsoscopeMatchScreenState extends State<HorsoscopeMatchScreen> {
  final RxString _selectedSign1 = ''.obs;
  final RxString _selectedSign2 = ''.obs;
  final RxString _result = ''.obs;
  final Random _random = Random();
  final RxInt _countdownValue = 0.obs;
  Timer? _timer;

  final List<String> _zodiacSigns = [
    'Scorpio',
    'Taurus',
    'Cancer',
    'Gemini',
    'Virgo',
    'Leo',
    'Capricorn',
    'Aquarius',
    'Sagittarius',
    'Pisces',
    'Libra',
    'Aries'
  ];
  final RxList<String> _dropdownSigns1 = <String>[].obs;
  final RxList<String> _dropdownSigns2 = <String>[].obs;

  @override
  void initState() {
    super.initState();
    _dropdownSigns1.addAll(_zodiacSigns);
    _dropdownSigns2.addAll(_zodiacSigns);
  }

  void _calculateLove() {
    FocusScope.of(context).unfocus();
    String name1 = globalVar.name1.value;
    String name2 = globalVar.name2.value;

    if (name1.isEmpty || name2.isEmpty) {
      _result('Please enter both names!');
      return;
    }
    if (_selectedSign1.value.isEmpty || _selectedSign2.value.isEmpty) {
      _result('Please select both zodiac signs!');
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
      customPrint(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  void _updateDropdownSigns1(String value) {
    _selectedSign1(value);
    _dropdownSigns2.value =
        _zodiacSigns.where((sign) => sign != value).toList();
  }

  void _updateDropdownSigns2(String value) {
    _selectedSign2(value);
    _dropdownSigns1.value =
        _zodiacSigns.where((sign) => sign != value).toList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red,
        title: Text(
          "Horoscope Match Calculator",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                globalVar.name1.value,
                style: GoogleFonts.rubik(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                height: screenHeight / 14,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.pinkAccent, width: 2)),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedSign1.value.isEmpty
                        ? null
                        : _selectedSign1.value,
                    hint: Text(
                      "Select a zodiac sign",
                      style: GoogleFonts.rubik(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.black),
                    ),
                    items: _dropdownSigns1.map((sign) {
                      return DropdownMenuItem<String>(
                        value: sign,
                        child: Text(
                          "\t\t\t$sign",
                          style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _updateDropdownSigns1(value!);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                globalVar.name2.value,
                style: GoogleFonts.rubik(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                height: screenHeight / 14,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.pinkAccent, width: 2)),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedSign2.value.isEmpty
                        ? null
                        : _selectedSign2.value,
                    hint: Text(
                      "Select a zodiac sign",
                      style: GoogleFonts.rubik(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.black),
                    ),
                    items: _dropdownSigns2.map((sign) {
                      return DropdownMenuItem<String>(
                        value: sign,
                        child: Text(
                          "\t\t\t$sign",
                          style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _updateDropdownSigns2(value!);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              (_selectedSign1.value == "" && _selectedSign2.value == "")
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _calculateLove();
                            },
                            child: const Text("Calculate")),
                      ],
                    ),
              (_countdownValue.value == 0)
                  ? const SizedBox()
                  : RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        color: Colors.white,
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
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.pinkAccent, width: 2)),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${globalVar.name1}",
                                        style: GoogleFonts.rubik(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Sign: $_selectedSign1",
                                        style: GoogleFonts.rubik(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.pinkAccent, width: 2)),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${globalVar.name2}",
                                        style: GoogleFonts.rubik(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Sign: $_selectedSign2",
                                        style: GoogleFonts.rubik(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_countdownValue.value == 0)
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            _captureAndSharePng();
                          },
                          child: const Text("Share")),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
