import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Rotatesplash extends StatelessWidget {
  const Rotatesplash({super.key});

  @override
  Widget build(BuildContext context) {
         SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Center(
          child: Lottie.asset("assets/animation/rotate.json")),
    );
  }
}
