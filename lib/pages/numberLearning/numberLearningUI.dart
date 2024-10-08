// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:elearning_app/pages/numberLearning/numberLearningController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';


class NumberLearningUI extends StatelessWidget {
  final NumberLearningController controller = Get.put(NumberLearningController());
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
        if (controller.numbers.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        final currentNumber =
            controller.numbers[controller.currentIndex.value];
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
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png', // Replace with your placeholder image asset
                    image: currentNumber.imageUrl,
                    fadeInDuration: Duration(seconds: 1),
                    width: width*0.3,
                    height: height*0.45,
                  ),
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
                    currentNumber.name,
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
            controller.numbers.indexOf(currentNumber)!=0?
            Positioned(
              left: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/leftA.png'),
                onPressed: controller.previousNumber,
              ),
            ):SizedBox.shrink(),

            controller.numbers.indexOf(currentNumber) != controller.numbers.length - 1?
            Positioned(
              right: height * 0.04,
              top: width * 0,
              bottom: width * 0,
              child: IconButton(
                icon: Image.asset('assets/icons/rightA.png'),
                onPressed: controller.nextNumber,
              ),
            ):SizedBox.shrink(),

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
                  onPressed: () => controller.speak(currentNumber.name),
                ),
              ).marginOnly(left: height * 0.55),
            ),
          ],
        );
      }),
    );
  }
}
