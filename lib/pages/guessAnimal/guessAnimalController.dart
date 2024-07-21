import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colorShapes/colorShapesController.dart';

class GuessAnimalController extends GetxController {
  var currentAnimal = ''.obs;
  var userInput = ''.obs;
  var result = ''.obs;
  var isCorrect = false.obs;
  Rx<TextEditingController> userInputController = TextEditingController().obs;

  // List of animals for example
  final List<String> animals = ['lion', 'tiger', 'elephant'];

  // Initialize with the first animal
  @override
  void onInit() {
    super.onInit();
    nextAnimal();
  }

  void checkAnswer() {
    isCorrect.value = userInput.value.toLowerCase() == currentAnimal.value.toLowerCase();
    if(isCorrect.value){
      result.value = 'Correct!';
    }
    else if(!isCorrect.value){
      result.value = 'Try Again!';
    }
    else{
      result.value = '';
    }
    nextAnimal();
  }

  void nextAnimal() {
    result.value = '';
    userInputController.value.clear();
    isCorrect.value = false;
    currentAnimal.value = (animals..shuffle()).first;
    userInput.value = '';
  }

}
