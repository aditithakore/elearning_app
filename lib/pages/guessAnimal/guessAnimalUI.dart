import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'guessAnimalController.dart';

class GuessAnimalUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    final GuessAnimalController controller = Get.put(GuessAnimalController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.showCongratulations.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'You guessed ${controller.score.value}/${controller.animals.length-1} correctly times!',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.reset();
                  },
                  child: Text('Replay'),
                ),
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/background.png'), // Replace with your background image path
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // "Who am I?" Text and Hint Icon
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Score: ${controller.score.value}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 180),
                              Text(
                                'Who am I?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 180),
                              IconButton(
                                icon: Icon(Icons.live_help_rounded),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Hint',
                                    middleText: controller.animals[controller
                                        .currentAnimalIndex
                                        .value]['description'] as String,
                                  );
                                },
                              )
                            ],
                          )
                          // SizedBox(width: 10),
                        ],
                      ),
                    ),
                    // SizedBox(height: 2),
                    // Animal Image
                    Obx(() {
                      return Image.asset(
                        controller.animals[controller.currentAnimalIndex.value]
                        ['image'] as String,
                        height: 200,
                        width: 200,
                      );
                    }),
                    // SizedBox(height: 20),
                    // Options
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.options.map((option) {
                          int currIndex = controller.options.indexOf(option);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => controller.checkAnswer(
                                  selectedOption: option,index:currIndex),
                              child: Text(option),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    // SizedBox(height: 20),
                    // Score Display
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
