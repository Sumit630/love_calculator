import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class globalVar {
  static RxInt onSelectScreen = 0.obs;
  static RxString name1 = "".obs;
  static RxString name2 = "".obs;
  static RxString loveQuotesTitel = "".obs;
  static RxString totalCountLove = "".obs;
  static RxInt indexOFList =0.obs;
}

bool debugMode = false;

checkDebugMode() {
  assert(() {
    debugMode = true;
    return true;
  }());
}

void customPrint(text) {
  if (debugMode) {
    log(text.toString());
  }
}
Future? nextPageFade(Widget page) {
  return Get.to(page, transition: Transition.upToDown);
}
