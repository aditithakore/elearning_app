import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'socialSkillsGameController.dart';

class SocialSkillsGameUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final SocialSkillsGameController controller = Get.put(SocialSkillsGameController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        var scenario = controller.scenario[controller.scenarioIndex.value] as Map<String, dynamic>;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Scenario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
        Container(
        height: Get.height * 0.25,
        width: Get.width * 0.8,
        decoration: BoxDecoration(
        // color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
        color: Colors.lightBlue.shade300,
        width: 2,
        ),
        ),
        child: Center(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
        scenario['question'] as String,
        style: TextStyle(
        fontSize: 20,
        color: Colors.black87,
        ),
        textAlign: TextAlign.center,
        ),
        ),
        ),
        ),
            Container(
              // color: Colors.lightBlue,
              child: Row(
                children: [
                  Image.asset(
                    scenario['image'][0] as String,
                    height: 180,
                    width: 180,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (scenario['options'] as List<String>).map((option) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedOption.value == option
                                    ? (controller.isCorrect.value ? Colors.green : Colors.red)
                                    : Colors.transparent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              onPressed: () => controller.check(option),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black, backgroundColor: Colors.white,
                                minimumSize: Size(200, 50), // Set a minimum size for the button
                              ),
                            ),
                          )),
                        );
                      }).toList(),
                    ),
                  ),
                  Image.asset(
                    scenario['image'][1] as String,
                    height: 180,
                    width: 180,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            Obx(() => Text(
              'Score: ${controller.score.value}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ],
        );
      }),
    );
  }
}