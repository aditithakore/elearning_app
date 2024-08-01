import 'package:elearning_app/pages/shapeLearning/shapeLearningController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ShapeLearningUI extends StatelessWidget {
  final ShapeLearningController controller = Get.put(ShapeLearningController());

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
        if (controller.shapes.isEmpty) {
          return Center(child: Text('No shapes found'));
        }

        final currentShape = controller.shapes[controller.currentIndex.value];

        return Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://i.imgur.com/ATmPOLC.png'),
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
            // Shape image and name
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
                    image: currentShape.imageUrl,
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
                    currentShape.name,
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
          
          //bear image
            Positioned(
              bottom: width * 0,
              left: width * 0.02,
              child: Image.network(
                'https://i.imgur.com/qzl0Syo.png',
                width: width * 0.45,  // Adjust width as needed
                height: height * 0.35, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),
            //bird image
            // Positioned(
            //   bottom: width * 0,
            //   left: width * 0.32,
            //   child: Image.network(
            //     'https://i.imgur.com/i8aBNps.png',
            //     width: width * 0.35,  // Adjust width as needed
            //     height: height * 0.29, // Adjust height as needed
            //     fit: BoxFit.contain,
            //   ),
            // ),


            // Navigation arrows
            controller.shapes.indexOf(currentShape) != 0
                ? Positioned(
                    left: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/leftA.png'),
                      onPressed: controller.previousShape,
                    ),
                  )
                : SizedBox.shrink(),

            //right arrow
            controller.shapes.indexOf(currentShape) != controller.shapes.length - 1?
            Positioned(
              right: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/rightA.png'),
                onPressed: controller.nextShape,
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
                  onPressed: () => controller.speak(currentShape.name),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
