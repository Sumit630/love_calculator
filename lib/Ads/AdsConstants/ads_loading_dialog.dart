import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AdsLoader {

  static showLoader() {
    showDialog(
        context: Get.context!,
        builder: (builder) => Dialog(
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitFadingCube(
                    color: Colors.black,
                    size: 40,
                  ),
                  SizedBox(height: 25,),
                  Text("Ads Loading"),
                ],
              ),
            ),
          ),
        ),
        useRootNavigator: false,
        barrierDismissible: false);
  }

  static hideLoader() {
    if (Navigator.canPop(Get.context!)) Navigator.of(Get.context!).pop();
  }
}