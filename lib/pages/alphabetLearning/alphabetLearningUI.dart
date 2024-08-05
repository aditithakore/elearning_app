import 'package:elearning_app/pages/alphabetLearning/alphabetLearningController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AlphabetLearningUI extends StatelessWidget {
  final AlphabetLearningController controller = Get.put(AlphabetLearningController());

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

        final currentAlphabet = controller.alphabets[controller.currentIndex.value];

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
            // Alphabet image
            Positioned(
              top: width * 0.060,
              left: height * 0.20,
              child: Image.network(
                currentAlphabet.alphabetUrl,
                width: width * 0.79,
                height: height * 0.79,
                fit: BoxFit.fitWidth,
              ),
            ),
            // Word image
            Positioned(
              bottom: width * 0.15,
              left: width * 0.12,
              child: Image.network(
                currentAlphabet.imageUrl,
                width: width * 0.45,  // Adjust width as needed
                height: height * 0.35, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),
            // Word text
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(height * 0.1),
              color: const Color.fromARGB(0, 255, 255, 255),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentAlphabet.word,
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Baloo 2',
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).marginOnly(left: height * 0.55),
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
            controller.alphabets.indexOf(currentAlphabet) != controller.alphabets.length - 1
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
              bottom: width * 0.15,
              left: height * 0.01,
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
