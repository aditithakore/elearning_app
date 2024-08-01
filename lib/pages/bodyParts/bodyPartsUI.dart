// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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
                width: width * 0.79,
                height: height * 0.79,
                fit: BoxFit.fitWidth,
              ),
            ),
            //cross button
            // Container(
            //   // ignore: prefer_const_constructors
            //   child: Column(
            //        mainAxisSize: MainAxisSize.min,
            //        children: [
            //         IconButton(
            //          icon: Image.asset('https://i.imgur.com/dgodV1L.png'),
            //         onPressed: Get.back(),
            //         )
            //        ],
            //   ),
            // ),
            // Body part image and text
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(height * 0.1),
              color: Color.fromARGB(0, 255, 255, 255),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(currentBodyPart.imageUrl),
                  SizedBox(height: 20),
                ],
              ),
            ).marginOnly(left: height * 0.5),
            //one more position for the name
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentBodyPart.name,
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
            // Navigation arrows
            Positioned(
              left: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/leftA.png'),
                onPressed: controller.previousBodyPart,
              ),
            ),
            Positioned(
              right: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/rightA.png'),
                onPressed: controller.nextBodyPart,
              ),
            ),

            // Speak button
            //PLEASE JUST WORK ON THIS PART THANKYOU YE MERESE EDIT NAI HORA WELL REMOVE THE BUTTON AND PLACE SMT ELSE CHLEGA
            //THANKS ANKII <3
            Positioned(
              bottom: width * 0.1,
              left: height * 0 * 0.2,
              right: height * 0 * 0.2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(
                        fontSize: 24, color: const Color.fromARGB(0, 255, 255, 255)), // Background color
                  ),
                  child: Text('Speak'),
                  onPressed: () => controller.speak(currentBodyPart.name),
                ),
              ).marginOnly(left: height * 0.55),
            ),
          ],
        );
      }),
    );
  }
}
