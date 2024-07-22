import 'dart:async';

import 'package:flutter/material.dart';
import 'package:love_calculatror/home_page/home_scrren.dart';

import 'introduction/introduction_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAutoNevigatorpage();
  }

  Timer? timer;

  getAutoNevigatorpage() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        timer.cancel();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return IntroductionPage();
          },
        ));
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
    );
  }
}
