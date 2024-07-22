import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'guessAnimalController.dart';

class GuessAnimalUI extends StatelessWidget {
  final GuessAnimalController guessAnimalController = Get.put(GuessAnimalController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Obx(() {
                String currentAnimal = guessAnimalController.currentAnimal.value;
                print('currentAnimal: $currentAnimal');
                if (currentAnimal.isEmpty) {
                  return Text('Loading...');
                } else {
                  return Column(
                    children: [
                      Text(
                        'Current Animal: $currentAnimal',
                        style: TextStyle(fontSize: 24),
                      ),
                      Image.asset(
                        'assets/images/animals/$currentAnimal.jpg',
                        height: 100,
                        width: 180,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Failed to load image');
                        },
                      ),
                    ],
                  );
                }
              }),
              TextFormField(
                controller:guessAnimalController.userInputController.value,
                onChanged: (value) {
                  guessAnimalController.userInputController.value.text = value;
                },
                decoration: InputDecoration(labelText: 'Enter animal name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  guessAnimalController.checkAnswer();
                },
                child: Text('Submit'),
              ),

              SizedBox(height: 20),
              Obx(() => Text(
                // guessAnimalController.isCorrect.value ? 'Correct!' : 'Try Again',
                guessAnimalController.result.value,
                style: TextStyle(
                  fontSize: 24,
                  color: guessAnimalController.isCorrect.value ? Colors.green : Colors.red,
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
