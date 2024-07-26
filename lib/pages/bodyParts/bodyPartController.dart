import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class BodyPartController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
    Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.setVolume(1.0);
  }

}
