import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Breathing extends StatelessWidget {
  const Breathing({super.key});

  @override
  Widget build(BuildContext context) {
         SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercie',style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Baloo 2',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
        backgroundColor: Colors.blue,
        centerTitle: true,
        ),
        body: Center(
          child: Lottie.asset("assets/animation/breathing.json")),
    );
  }
}
