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
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:love_calculatror/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DateOfBirthScrren extends StatefulWidget {
  const DateOfBirthScrren({super.key});

  @override
  State<DateOfBirthScrren> createState() => _DateOfBirthScrrenState();
}

class _DateOfBirthScrrenState extends State<DateOfBirthScrren> {
  TextEditingController dateOfBirth1 = TextEditingController();
  TextEditingController dateOfBirth2 = TextEditingController();
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

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(1900), // First selectable date
      lastDate: DateTime.now(), // Last selectable date
    );

    if (picked != null) {
        dateOfBirth1.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(1900), // First selectable date
      lastDate: DateTime.now(), // Last selectable date
    );

    if (picked != null) {
      // setState(() {
        dateOfBirth2.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  GlobalKey _globalKey = GlobalKey();

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
          "Date of Birth",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: Obx(() {
        customPrint(globalVar.name1);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onTap: () {
                  _selectDate1(context);
                },
                controller: dateOfBirth1,
                decoration: const InputDecoration(
                  labelText: 'Select Date of Birth',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onTap: () {
                  _selectDate2(context);
                },
                controller: dateOfBirth2,
                decoration: const InputDecoration(
                  labelText: 'Select Date of Birth',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _calculateLove();
                  },
                  child: const Text("Calculate Love")),
              (dateOfBirth1.text.isEmpty || dateOfBirth2.text.isEmpty)
                  ? const SizedBox()
                  : (_countdownValue.value == 0)
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.pinkAccent,
                                              width: 2)),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            dateOfBirth1.text,
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
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.pinkAccent,
                                              width: 2)),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            dateOfBirth2.text,
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

  @override
  void dispose() {
    // _name1Controller.dispose();
    // _name2Controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
