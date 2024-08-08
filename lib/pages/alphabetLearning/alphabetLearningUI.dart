import 'package:elearning_app/pages/alphabetLearning/alphabetLearningController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AlphabetLearningUI extends StatelessWidget {
  final AlphabetLearningController controller =
      Get.put(AlphabetLearningController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        }
        if (controller.alphabets.isEmpty) {
          return Center(child: Text('No alphabets found'));
        }

        final currentAlphabet =
            controller.alphabets[controller.currentIndex.value];

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
            // White Board
            Positioned(
              top: width * 0.060,
              left: height * 0.20,
              child: Image.network(
                'https://i.imgur.com/z8gDtum.png',
                // currentAlphabet.alphabetUrl,
                width: width * 0.79,
                height: height * 0.79,
                fit: BoxFit.fitWidth,
              ),
            ),
            //imageAlphabet
            Positioned(
              top: height * 0.30,
              left: width * 0.12,
              child: Image.network(
                currentAlphabet.alphabetUrl,
                width: width * 0.19,
                height: height * 0.41,
                fit: BoxFit.fitWidth,
              ),
            ),
            // Word text
            Positioned(
              top: height * 0.45,
              left: width * 0.40,
              child: Container(
                // color: Colors.red,
                child: Text(currentAlphabet.word,
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Baloo 2',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            // Aeroplane Image
            Positioned(
              bottom: height * 0.38,
              right: width * 0.12,
              child: Image.network(
                currentAlphabet.imageUrl,
                width: width * 0.30, // Adjust width as needed
                height: height * 0.30, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),

            // Navigation arrows
            controller.alphabets.indexOf(currentAlphabet) != 0
                ? Positioned(
                    left: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/leftA.png'),
                      onPressed: controller.previousAlphabet,
                    ),
                  )
                : SizedBox.shrink(),
            controller.alphabets.indexOf(currentAlphabet) !=
                    controller.alphabets.length - 1
                ? Positioned(
                    right: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/rightA.png'),
                      onPressed: controller.nextAlphabet,
                    ),
                  )
                : SizedBox.shrink(),
            // Speak button
            Positioned(
              bottom: height * 0.23,
              left: width * 0.01,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  child: Text('Speak'),
                  onPressed: () => controller.speak(currentAlphabet.word),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
