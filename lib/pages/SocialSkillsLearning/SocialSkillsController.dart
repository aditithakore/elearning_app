import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class SocialSkillsController extends GetxController {
  FlutterTts flutterTts = FlutterTts();
  // var scenario = 1.obs; // Observable scenario number

  RxList<String> imagePath = [
    'assets/images/social/s1c1.png',
    'assets/images/social/s1c2.png',
    'assets/images/social/s2c1.png',
    'assets/images/social/s2c2.png',
    'assets/images/social/s3c1.png',
    'assets/images/social/s3c2.png',
  ].obs;

  RxMap<String, List<String>> dialogues = {
    "s1c1d1": ["Hi, my name is John. What's your name"],
    "s1c2d1": ["Hello, nice to meet you! I'm Tom."],
    "s1c1d2": ["It's my first day here. How about you"],
    "s1c2d2": ["Yes, me too! Let's be friends!"],

    "s2c1d1": ["Yes, you have to pay 150 Rupees"],
    "s2c2d1": ["Hello, Can I get 1 Kg Apples?"],
    "s2c1d2": ["Yes sure, here it is"],
    "s2c2d2": ["I have 200 Rupees, can I get 50 rupees back"],

    "s3c1d1": [" Miss, can I ask a question about the homework?"],
    "s3c2d1": ["Of course! What do you need help with?"],
    "s3c1d2": ["I'm not able to understanding the math problems"],
    "s3c2d2": ["Okay,Let me explain it to you."],
  }.obs;

  RxString scenario = '1'.obs; // Reactive string for scenario
  RxString child = '1'.obs; // Reactive string for context
  RxString dialog = '1'.obs; // Reactive string for dialogue
  var changeScenario = false.obs;
  var scenarioCompleted = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(Duration(milliseconds: 2000));
    await speak(scenario.value, child.value, dialog.value);
  }

  Future<void> speak(String s, String c, String d) async {
    if (scenarioCompleted.value) return;

    print('Scene: s${s}c${c}d${d}');
    List<String> dialogueList = dialogues['s${s}c${c}d${d}'] ?? [];

    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);

    for (String dialogue in dialogueList) {
      print('dialogue: $dialogue');
      await Future.delayed(Duration(seconds: 2));
      flutterTts.speak(dialogue);
      await Future.delayed(Duration(seconds: 2));
    }

    if (scenario.value == '1' && !changeScenario.value) {
      if (child.value == '2' && dialog.value == '1') {
        child.value = '1';
        dialog.value = '2';
        await speak(scenario.value, child.value, dialog.value);
      }
      if (child.value == '2' && dialog.value == '2') {
        // Show an alert dialog
        await showDialog(
          context:Get.context!, // Use the context from your widget
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Good Going!!'),
              content: Text('Now take a deep breath.\n Let\'s practice it once.\n Ask your parent/ guardian to play a role of other child and have a polite conversation.\n\n Once yo are done click on next for New Scenario:)'),
              // Customize your message
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Next'),
                ),
              ],
            );
          },
        );

        // After the dialog is dismissed, proceed with changing the scenario
        changeScenario.value = true;
        scenario.value = '2';
        child.value = '1';
        dialog.value = '1';
        await speak(scenario.value, child.value, dialog.value);
      }

      child.value = '2';
      await speak(scenario.value, child.value, dialog.value);
    }
    else if (scenario.value == '2' && changeScenario.value) {
      if (child.value == '2' && dialog.value == '1') {
        child.value = '1';
        dialog.value = '2';
        await speak(scenario.value, child.value, dialog.value);
      }
      if (child.value == '2' && dialog.value == '2') {
        await showDialog(
          context:Get.context!, // Use the context from your widget
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Your message here'), // Customize your message
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        changeScenario.value = false;
        scenario.value = '3';
        child.value = '1';
        dialog.value = '1';
        await speak(scenario.value, child.value, dialog.value);
        return;
      }
      child.value = '2';
      await speak(scenario.value, child.value, dialog.value);
    } else if (scenario.value == '3' && !changeScenario.value) {
      if (child.value == '2' && dialog.value == '1') {
        child.value = '1';
        dialog.value = '2';
        await speak(scenario.value, child.value, dialog.value);
      }
      if (scenario.value == '3' && child.value == '2' && dialog.value == '2') {
        print("End Condition");
        await flutterTts.stop();
        scenarioCompleted.value = true;
        return;
      }
      child.value = '2';
      await speak(scenario.value, child.value, dialog.value);
    }
  }
  void replay() {
    reset();
  }

  void reset() {
    // Reset all the variables to their initial states
    scenario.value = '1';
    child.value = '1';
    dialog.value = '1';
    changeScenario.value = false;
    scenarioCompleted.value = false;
  }
  // void nextScenario() {
  //   if (scenario.value < 3) {
  //     scenario.value++;
  //   }
  // }
}
