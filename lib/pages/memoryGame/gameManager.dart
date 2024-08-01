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

    if (firstFlippedIndex == null) {
      // First card flipped
      firstFlippedIndex = index;
      flippedCards[index] = true;
    } else if (firstFlippedIndex != index) {
      // Second card flipped
      flippedCards[index] = true;
      checkMatch(firstFlippedIndex!, index);
    }
    
    notifyListeners();
  }

  void checkMatch(int index1, int index2) {
    if (gameShapes[index1] == gameShapes[index2]) {
      // Match found
      matchedPairs.add(index1);
      matchedPairs.add(index2);
      firstFlippedIndex = null;
    } else {
      // No match
      Future.delayed(Duration(milliseconds: 1000), () {
        flippedCards[index1] = false;
        flippedCards[index2] = false;
        firstFlippedIndex = null;
        notifyListeners();
      });
    }
  }
}