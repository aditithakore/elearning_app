import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import 'matchFruitsModel.dart';

class MatchFruitsController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  var isSuccess = false.obs;
  var matchedMessage = ''.obs;
  var quotesApple="An apple a day keeps the doctor way";
  var quotesbanana="Bananas give you energy to play all day";
  var quotescherry="Cherry, cherry, red and bright, take a bite and feel the delight!";
  var quoteswatermelon="Watermelon is juicy and cool, perfect for a sunny day at the pool!";
  var quoteskiwi="Kiwi, kiwi, fuzzy and small, green and yummy for one and all!";
  var quotesavocado="creamy and green, spread it on toast and you'll feel keen!";
  var quotescoconut="Coconuts are nature’s surprise, with milk and a treat inside!";
  var quotesgrapes="Grapes are tiny, sweet, and neat, a perfect snack that can't be beat!";
  var quotespear="Pear, pear, yellow or green, juicy and yummy, fit for a queen!";
  var quotesmango="Mango is the king of fruits, juicy and sweet, a real treat!";
  var quotestrawberry="Strawberries are berry delicious and full of vitamin C!";


  // List of all available fruits
  List<ImageItem> allItems = [
    ImageItem('assets/images/fruits/apple.png', 'apple'),
    ImageItem('assets/images/fruits/banana.png', 'banana'),
    ImageItem('assets/images/fruits/cherries.png', 'cherry'),
    ImageItem('assets/images/fruits/watermelon.png', 'watermelon'),
    ImageItem('assets/images/fruits/kiwi-fruit.png', 'kiwi-fruit'),
    ImageItem('assets/images/fruits/avocado.png', 'avocado'),
    ImageItem('assets/images/fruits/coconut.png', 'coconut'),
    ImageItem('assets/images/fruits/grapes.png', 'grapes'),
    ImageItem('assets/images/fruits/pear.png', 'pear'),
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
      showMatchDialog(target);
      Future.delayed(Duration(milliseconds: 800), () {
        switch (target.id.toLowerCase()) {
          case 'apple':
            speak(quotesApple);
            break;
          case 'banana':
            speak(quotesbanana);
            break;
          case 'mango':
            speak(quotesmango);
            break;
          case 'cherry':
            speak(quotescherry);
            break;
          case 'watermelon':
            speak(quoteswatermelon);
            break;
          case 'kiwi-fruit':
            speak(quoteskiwi);
            break;
          case 'avocado':
            speak(quotesavocado);
            break;
          case 'coconut':
            speak(quotescoconut);
            break;
          case 'grapes':
            speak(quotesgrapes);
            break;
          case 'pear':
            speak(quotespear);
            break;
          case 'strawberry':
            speak(quotestrawberry);
            break;
          default:
            break;
        }
      });
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

  void showMatchDialog(ImageItem item) {
    Get.dialog(
      AlertDialog(
        title: Text('${item.id.capitalizeFirst}'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(item.imagePath,height: 50,width: 50,),
            SizedBox(height: 10),
            Container(
              child:
              item.id.toString().toLowerCase()=="apple"?
              Text("$quotesApple",maxLines: 3,):
              item.id.toString().toLowerCase()=="banana"?
              Text("$quotesbanana",maxLines: 3,):
              item.id.toString().toLowerCase()=="avocado"?
              Text("$quotesavocado",maxLines: 3,):
              item.id.toString().toLowerCase()=="mango"?
              Text("$quotesmango",maxLines: 3,):
              item.id.toString().toLowerCase()=="cherry"?
              Text("$quotescherry",maxLines: 3,):
              item.id.toString().toLowerCase()=="watermelon"?
              Text("$quoteswatermelon",maxLines: 3,):
              item.id.toString().toLowerCase()=="kiwi-fruit"?
              Text("$quoteskiwi-fruit",maxLines: 3,):
              item.id.toString().toLowerCase()=="coconut"?
              Text("$quotescoconut",maxLines: 3,):
              item.id.toString().toLowerCase()=="grapes"?
              Text("$quotesgrapes",maxLines: 3,):
              item.id.toString().toLowerCase()=="pear"?
              Text("$quotespear",maxLines: 3,):

              Text(' '),

            )

          ],
        ),
        actions: [
          TextButton(
              onPressed: ()=>Get.back(),
              child: Text('Close'))
        ],
      )
    );
  }
}

