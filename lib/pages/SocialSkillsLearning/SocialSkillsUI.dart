import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'SocialSkillsController.dart';

class SocialSkillsUI extends StatelessWidget {
  final SocialSkillsController controller = Get.put(SocialSkillsController());

  SocialSkillsUI() {
    // Set the preferred orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        color: Colors.white, // Set background color to white
        padding: EdgeInsets.all(16.0), // Optional padding for spacing
        child: Center(
          child: Row( // Horizontal layout
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() {
                String imagePath = '';
                String dialogue1 = '';
                String dialogue2 = '';

                if (controller.scenario.value == '1') {
                  imagePath = controller.imagePath[0];
                  dialogue1 = controller.dialogues['s1c1d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s1c1d2']?.join(' ') ?? '';
                } else if (controller.scenario.value == '2') {
                  imagePath = controller.imagePath[2];
                  dialogue1 = controller.dialogues['s2c1d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s2c1d2']?.join(' ') ?? '';
                } else if (controller.scenario.value == '3') {
                  imagePath = controller.imagePath[4];
                  dialogue1 = controller.dialogues['s3c1d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s3c1d2']?.join(' ') ?? '';
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, height: 100),
                    SizedBox(height: 10),


                    Container(
                      padding: EdgeInsets.all(12.0), // Add some padding inside the container
                      decoration: BoxDecoration(
                        color: Color(0xFFE0F7FA), // Background color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                      child: Text(
                        dialogue1,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(12.0), // Add some padding inside the container
                      decoration: BoxDecoration(
                        color: Color(0xFFE0F7FA), // Background color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                      child: Text(
                        dialogue2,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }),
              Obx(() {
                String imagePath = '';
                String dialogue1 = '';
                String dialogue2 = '';

                if (controller.scenario.value == '1') {
                  imagePath = controller.imagePath[1];
                  dialogue1 = controller.dialogues['s1c2d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s1c2d2']?.join(' ') ?? '';
                } else if (controller.scenario.value == '2') {
                  imagePath = controller.imagePath[3];
                  dialogue1 = controller.dialogues['s2c2d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s2c2d2']?.join(' ') ?? '';
                } else if (controller.scenario.value == '3') {
                  imagePath = controller.imagePath[5];
                  dialogue1 = controller.dialogues['s3c2d1']?.join(' ') ?? '';
                  dialogue2 = controller.dialogues['s3c2d2']?.join(' ') ?? '';
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, height: 100),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(12.0), // Add some padding inside the container
                      decoration: BoxDecoration(
                        color: Color(0xFFE0F7FA), // Background color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                      child: Text(
                        dialogue1,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0), // Add some padding inside the container
                      decoration: BoxDecoration(
                        color: Color(0xFFE0F7FA), // Background color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                      child: Text(
                        dialogue2,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () {
                  controller.reset();
                  controller.speak(controller.scenario.value, controller.child.value, controller.dialog.value);
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Move to the next scenario and read dialogues
      //     controller.nextScenario();
      //   },
      //   child: Icon(Icons.navigate_next),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }
}
