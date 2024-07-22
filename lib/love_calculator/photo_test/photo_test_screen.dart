import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:love_calculatror/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PhotoTestScreen extends StatefulWidget {
  const PhotoTestScreen({super.key});

  @override
  State<PhotoTestScreen> createState() => _PhotoTestScreenState();
}

class _PhotoTestScreenState extends State<PhotoTestScreen> {
  File? _image;
  File? _image2;

  Future<void> _pickImage1() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImage2() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image2 = File(pickedFile.path);
      });
    }
  }

  final RxString _result = ''.obs;
  final RxInt _countdownValue = 0.obs;
  final Random _random = Random();
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
    return Obx(() {
      customPrint(globalVar.name1);
      return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.red,
          title: Text(
            "Photo Calculator",
            style: GoogleFonts.rubik(
                fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _pickImage1();
                          },
                          child: Container(
                            width: screenWidth / 2.8,
                            height: screenHeight / 4,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFBEC1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: (_image == null)
                                ? const Icon(
                                    Icons.camera_alt,
                                    size: 100,
                                  )
                                : Image.file(fit: BoxFit.cover, _image!),
                          ),
                        ),
                        Text(
                          "${globalVar.name1}",
                          style: GoogleFonts.rubik(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _pickImage2();
                          },
                          child: Container(
                            width: screenWidth / 2.8,
                            height: screenHeight / 4,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFBEC1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: (_image2 == null)
                                ? const Icon(
                                    Icons.camera_alt,
                                    size: 100,
                                  )
                                : ClipRect(
                                    child: Image.file(
                                        fit: BoxFit.cover, _image2!)),
                          ),
                        ),
                        Text(
                          "${globalVar.name2}",
                          style: GoogleFonts.rubik(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                (_image == null || _image2 == null)
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          _calculateLove();
                        },
                        child: const Text('Calculate Love'),
                      ),
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
                                CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: FileImage(_image!),
                                ),
                                CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: FileImage(_image2!),
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
                        child: const Text("Share"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
