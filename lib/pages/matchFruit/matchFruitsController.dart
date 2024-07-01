import 'package:get/get.dart';
import 'matchFruitsModel.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MatchFruitsController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  List<ImageItem> items = [
    ImageItem('assets/images/apple.jpg', 'apple'),
    ImageItem('assets/images/banana.png', 'banana'),
    ImageItem('assets/images/cherry.png', 'cherry'),
    // Add more items as needed
  ].obs;
  dynamic shuffledItems = [].obs;
  var matchedMessage = ''.obs;

  MatchFruitsController() {
    shuffledItems = List.from(items)..shuffle();
  }
  bool checkMatch(ImageItem item1, ImageItem item2) {
    print("MatchSuccess");
    return item1.id == item2.id;

  }

  var matchedItems = <String>[].obs;

  void matchItem(ImageItem target, ImageItem dragged) {
    if (checkMatch(target, dragged)) {
      matchedItems.add(target.id);
      print(target.id);
      matchedMessage.value = '${target.id} matched!';
     speak('${target.id} matched!');
      Future.delayed(Duration(seconds: 2),(){
        matchedMessage.value='';
      });
    }
  }
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.setVolume(1.0);
  }
  String? getMatchedImage(String id) {
    return items.firstWhereOrNull((item) => item.id == id)?.imagePath;
  }
}
