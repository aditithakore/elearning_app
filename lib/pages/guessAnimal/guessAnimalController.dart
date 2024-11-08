import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuessAnimalController extends GetxController {
  // List of animals with names and descriptions
  final animals = [
    {'name': 'Dog', 'image': 'assets/images/animals/dog.png', 'description': 'I love to bark and wag my tail.'},
    {'name': 'Lion', 'image': 'assets/images/animals/lion.png', 'description': 'I am the king of the jungle.'},
    {'name': 'Tiger', 'image': 'assets/images/animals/tiger.png', 'description': 'I have stripes and a loud roar.'},
    {'name': 'Giraffe', 'image': 'assets/images/animals/giraffe.png', 'description': 'I have a long neck.'},
    {'name': 'Monkey', 'image': 'assets/images/animals/monkey.png', 'description': 'I love to swing from trees.'},
    {'name': 'Zebra', 'image': 'assets/images/animals/zebra.png', 'description': 'I have black and white stripes.'},
    {'name': 'Yak', 'image': 'assets/images/animals/yak.png', 'description': 'I am a large animal with long hair and horns, found in cold mountain regions.'},
    {'name': 'Octopus', 'image': 'assets/images/animals/octopus.png', 'description': 'I have eight arms and live in the ocean.'},
    {'name': 'Fox', 'image': 'assets/images/animals/fox.png', 'description': 'As cunning as a .......'},
    {'name': 'Honeybee', 'image': 'assets/images/animals/honey.png', 'description': 'I make honey and love to buzz around flowers.'},
    {'name': 'Panda', 'image': 'assets/images/animals/panda.png', 'description': 'I am black and white and love eating bamboo.'},
    {'name': 'Frog', 'image': 'assets/images/animals/frog.png', 'description': 'I can jump high and live near water.'},
    {'name': 'Wolf', 'image': 'assets/images/animals/wolf.png', 'description': 'I live in packs and howl at the moon.'},
    {'name': 'Rhinoceros', 'image': 'assets/images/animals/rhinoceros.png', 'description': 'I have thick skin and a large horn on my nose.'},
    {'name': 'Rabbit', 'image': 'assets/images/animals/rabbit.png', 'description': 'I have long ears and love to hop around.'},
    {'name': 'Hippopotamus', 'image': 'assets/images/animals/hippopotamus.png', 'description': 'I am big and spend a lot of time in the water.'},
    // {'name': 'Antelope', 'image': 'assets/images/animals/antelope.png', 'description': 'I am graceful and can run very fast.'},
  ];
  var score = 0.obs; // Score counter
  var showCongratulations = false.obs;
  // Observable properties
  var currentAnimalIndex = 0.obs;
  var options = <String>[].obs;

  // Initialize with the first animal
  @override
  void onInit() {
    super.onInit();
    loadNextAnimal();
  }

  // Load the next animal and its options
  void loadNextAnimal() {
    currentAnimalIndex.value = (currentAnimalIndex.value + 1) % animals.length;
    var animal = animals[currentAnimalIndex.value];
    options.assignAll(generateOptions(animal['name'] as String));
  }

  // Generate random options with one correct answer
  List<String> generateOptions(String correctAnswer) {
    var allNames = animals.map((a) => a['name'] as String).toList();
    allNames.remove(correctAnswer); // Remove the correct answer from the list
    allNames.shuffle();

    var randomOptions =
    allNames.take(3).toList(); // Take two random unique names
    randomOptions.add(correctAnswer); // Add the correct answer
    randomOptions.shuffle(); // Shuffle the list to randomize the order
    return randomOptions;
  }

  //Check if the selected option is correct
  void checkAnswer({required String selectedOption, required int index}) {
    if (selectedOption == animals[currentAnimalIndex.value]['name']) {
      score++;
      loadNextAnimal();
    } else{
      Get.dialog(
        AlertDialog(
          title: Text(
            'Incorrect Match',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red, // Set the text color to red
            ),
          ),
        ),
      );
      loadNextAnimal();
    }
    if(currentAnimalIndex.value==animals.length-1){
      showCongratulations.value=true;
      // score.value=0;
    }
  }

  void reset() {
    score.value = 0;
    showCongratulations.value = false;
    loadNextAnimal();
  }
}
