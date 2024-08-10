import 'package:get/get.dart';

class GuessAnimalController extends GetxController {
  // List of animals with names and descriptions
  final animals = [
    {'name': 'Dog', 'image': 'assets/images/animals/dog.png', 'description': 'I love to bark and wag my tail.'},
    {'name': 'Lion', 'image': 'assets/images/animals/lion.png', 'description': 'I am the king of the jungle.'},
    {'name': 'Tiger', 'image': 'assets/images/animals/tiger.png', 'description': 'I have stripes and a loud roar.'},
    {'name': 'Giraffe', 'image': 'assets/images/animals/giraffe.png', 'description': 'I have a long neck.'},
    {'name': 'Monkey', 'image': 'assets/images/animals/monkey.png', 'description': 'I love to swing from trees.'},
    {'name': 'Fox', 'image': 'assets/images/animals/fox.png', 'description': 'As cunning as a .......'},
  ];
  var score = 0.obs;  // Score counter
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
    allNames.remove(correctAnswer);  // Remove the correct answer from the list
    allNames.shuffle();

    var randomOptions = allNames.take(3).toList();  // Take two random unique names
    randomOptions.add(correctAnswer);  // Add the correct answer
    randomOptions.shuffle();  // Shuffle the list to randomize the order
    return randomOptions;
  }

  // Check if the selected option is correct
  void checkAnswer(String selectedOption) {
    if (selectedOption == animals[currentAnimalIndex.value]['name']) {
      score++;
      if(score>=5){
        showCongratulations.value=true;
        score.value=0;
      }
      loadNextAnimal();
    }
  }

  void reset() {
    score.value = 0;
    showCongratulations.value = false;
    loadNextAnimal();
  }
}
