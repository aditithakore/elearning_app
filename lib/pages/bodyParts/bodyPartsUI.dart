import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'bodyPartController.dart';

class BodyPartsUI extends StatelessWidget {
  final BodyPartController controller = Get.put(BodyPartController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Obx(() {
        if (controller.bodyParts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        final currentBodyPart =
            controller.bodyParts[controller.currentIndex.value];
        return Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.imgur.com/viFnLNO.png', // Replace with your background image URL
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Overlay image
            Positioned(
              top: width * 0.060,
              left: height * 0.20,
              child: Image.network(
                'https://i.imgur.com/z8gDtum.png',
                width: 700,
                height: 350,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Body part image and text
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              color: Color.fromARGB(0, 255, 255, 255),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(currentBodyPart.imageUrl),
                  SizedBox(height: 20),
                                   
                ],
              ),
            ).marginOnly(left: 120),
              //one more position for the name
            // Navigation arrows
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: Image.asset('assets/icons/leftA.png'),
                onPressed: controller.previousBodyPart,
              ),
            ),
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: Image.asset('assets/icons/rightA.png'),
                onPressed: controller.nextBodyPart,
              ),
            ),

            // Speak button
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  child: Text('Speak'),
                  onPressed: () => controller.speak(currentBodyPart.name),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
