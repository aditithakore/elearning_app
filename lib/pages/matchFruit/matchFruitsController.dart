import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import 'matchFruitsModel.dart';

class MatchFruitsController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  var isSuccess = false.obs;
  var matchedMessage = ''.obs;

  // List of all available fruits
  List<ImageItem> allItems = [
    ImageItem('assets/images/fruits/apple.jpg', 'apple'),
    ImageItem('assets/images/fruits/banana.png', 'banana'),
    ImageItem('assets/images/fruits/cherry.png', 'cherry'),
    ImageItem('assets/images/fruits/strawberry.jpg', 'strawberry'),
    ImageItem('assets/images/fruits/watermelon.png', 'watermelon'),
    ImageItem('assets/images/fruits/pomegranate.jpg', 'pomegranate'),
    ImageItem('assets/images/fruits/pineapple.jpg', 'pineapple'),
    ImageItem('assets/images/fruits/mango.png', 'mango'),
  ];

  List<ImageItem> items = [];
  List<ImageItem> shuffledItems = [];
  var matchedItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    reset();
  }

  bool checkMatch(ImageItem item1, ImageItem item2) {
    return item1.id == item2.id;
  }

  void matchItem(ImageItem target, ImageItem dragged) {
    if (checkMatch(target, dragged)) {
      matchedItems.add(target.id);
      matchedMessage.value = '${target.id} matched!';
      speak('${target.id} matched!');
      Future.delayed(Duration(seconds: 2), () {
        matchedMessage.value = '';
      });
    }
    if (matchedItems.length == items.length) {
      isSuccess.value = true;
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.setVolume(1.0);
  }

  void reset() {
    matchedItems.clear();
    shuffledItems.clear();

    // Shuffle and select 3 fruits for the game
    items = List.from(allItems)..shuffle();
    items = items.take(3).toList(); // Take any 3 random fruits

    shuffledItems = List.from(items)..shuffle();

    isSuccess.value = false;
  }
}
