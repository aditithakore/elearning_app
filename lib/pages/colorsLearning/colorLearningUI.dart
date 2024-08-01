import 'package:elearning_app/pages/colorsLearning/colorLearningController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ColorLearningUI extends StatelessWidget {
  final ColorLearningController controller = Get.put(ColorLearningController());

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
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        }
        if (controller.colors.isEmpty) {
          return Center(child: Text('No colors found'));
        }

        final currentColor = controller.colors[controller.currentIndex.value];

        return Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://i.imgur.com/fxxHXvQ.png'),
                    fit: BoxFit.cover),
              ),
            ),
            //overlay image
            Positioned(
              top: width * 0.060,
              left: height * 0.20,
              child: Image.network(
                'https://i.imgur.com/z8gDtum.png',
                width: width * 0.79,
                height: height * 0.79,
                fit: BoxFit.fitWidth,
              ),
            ),
            // Color image and name
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(height * 0.1),
              color: const Color.fromARGB(0, 255, 255, 255),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder:
                        'assets/placeholder.png', // Replace with your placeholder image asset
                    image: currentColor.imageUrl,
                    fadeInDuration: Duration(seconds: 1),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ).marginOnly(left: height * 0.5),
            //position for name
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentColor.name,
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Baloo 2',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).marginOnly(left: height * 0.55),
          
          //lion image
            Positioned(
              bottom: width * 0,
              left: width * 0.12,
              child: Image.network(
                'https://i.imgur.com/mIsCX9I.png',
                width: width * 0.45,  // Adjust width as needed
                height: height * 0.35, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),


            // Navigation arrows
            controller.colors.indexOf(currentColor) != 0
                ? Positioned(
                    left: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/leftA.png'),
                      onPressed: controller.previousColor,
                    ),
                  )
                : SizedBox.shrink(),

            //right arrow
            controller.colors.indexOf(currentColor) != controller.colors.length - 1?
            Positioned(
              right: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/rightA.png'),
                onPressed: controller.nextColor,
              ),
            ):SizedBox.shrink(),

            // Speak button
            Positioned(
              bottom: width * 0.15,
              left: height * 0.01,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  child: Text('Speak'),
                  onPressed: () => controller.speak(currentColor.name),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
