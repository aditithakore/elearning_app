import 'dart:ffi';
import 'dart:math';
import 'package:get/get.dart';

class ColorShapeController extends GetxController {
  var dummyText = ''.obs;
  var colorName = "".obs;
  var isSuccess = false.obs;
  var isFailed=true.obs;
  var box1 = ''.obs;
  var box2 = ''.obs;
  var box3 = ''.obs;

  var colorNames = [
    "Red",
    "Green",
    "Blue",
  ].obs;
  var colorsLen = 0.obs;
  var score=0.obs;
  final int scoreLimit=5;
  var isGameOver=false.obs;
  ColorShapeController() {
    colorsLen.value = colorNames.length; // Initialize colorsLen in the constructor
    reset(); // Optionally reset to initialize colorName and shuffle colorNames
  }

  void checkColor(String selectedColorName) {
    print('selectedColorName: ${selectedColorName}');
    print('colorName.value: ${colorName.value}');
    if (selectedColorName.toLowerCase() == colorName.value.toLowerCase()) {
      isSuccess.value = true;
      isFailed.value = false;
      score.value++;
      if(score.value>=scoreLimit){
        isGameOver.value=true;
      }
    } else {
      isSuccess.value = false;
      isFailed.value=true;
    }
  }

  void reset() {
    if (isGameOver.value) {
      score.value = 0;
      isGameOver.value = false;
    }
    // Set isSuccess to false
    isSuccess.value = false;
    isFailed.value=false;
    // Shuffle colorNames list to randomize the order
    colorNames.shuffle();

    // Set colorName.value to a random color from colorNames list
    int randomIndex = Random().nextInt(colorNames.length);
    colorName.value = colorNames[randomIndex];

    // Assign box1, box2, and box3 values randomly from colorNames list
    List<int> indices = [0, 1, 2]; // Indices to choose from
    indices.shuffle(); // Shuffle indices

    box1.value = colorNames[indices[0]];
    box2.value = colorNames[indices[1]];
    box3.value = colorNames[indices[2]];

    // Ensure that one of box1, box2, or box3 matches colorName.value
    if (colorName.value != box1.value && colorName.value != box2.value && colorName.value != box3.value) {
      int randomBoxIndex = Random().nextInt(3); // Randomly select one of the boxes
      if (randomBoxIndex == 0) {
        box1.value = colorName.value;
      } else if (randomBoxIndex == 1) {
        box2.value = colorName.value;
      } else {
        box3.value = colorName.value;
      }
    }
  }
  void replay(){
    reset();
  }

}
