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
        var scenario = controller.scenario[controller.scenarioIndex.value];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scenario Title
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Scenario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(height: 20),
            // Question
            Text(
              scenario['question'] as String,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // Scenario Image
            Row(
              children: [
                Image.asset(
                  scenario['image'] as String,
                  height: 100,
                  width: 100,
                ),
                // SizedBox(height: 20),
                // SizedBox(height: 20),

                // SizedBox(height: 20),
                // Options
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (scenario['options'] as List<String>).map((option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => controller.check(option),
                        child: Text(option),
                      ),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
