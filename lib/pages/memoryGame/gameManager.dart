import 'package:flutter/material.dart';

class GameManager extends ChangeNotifier {
  List<String> shapes = ['circle', 'square', 'triangle'];
  late List<String> gameShapes;
  List<bool> flippedCards = List.generate(6, (_) => false);
  List<int> matchedPairs = [];
  int? firstFlippedIndex;

  GameManager() {
    gameShapes = [...shapes, ...shapes];
    gameShapes.shuffle();
  }

  void tileTapped(int index) {
    if (flippedCards[index] || matchedPairs.contains(index)) return;

    flippedCards[index] = true;
    notifyListeners();

    if (firstFlippedIndex == null) {
      firstFlippedIndex = index;
    } else {
      checkMatch(firstFlippedIndex!, index);
    }
  }

  void checkMatch(int index1, int index2) {
    if (gameShapes[index1] == gameShapes[index2]) {
      matchedPairs.add(index1);
      matchedPairs.add(index2);
      firstFlippedIndex = null;
      notifyListeners();
    } else {
      Future.delayed(Duration(milliseconds: 1000), () {
        flippedCards[index1] = false;
        flippedCards[index2] = false;
        firstFlippedIndex = null;
        notifyListeners();
      });
    }
  }
}