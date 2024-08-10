import 'package:elearning_app/pages/habits/habitcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HabitUI extends StatelessWidget {
  final HabitController controller = Get.put(HabitController());

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
        if (controller.habits.isEmpty) {
          return Center(child: Text('No habits found'));
        }

        final currentHabit =
            controller.habits[controller.currentIndex.value];

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
                // currentHabit.HabitUrl,
                width: width * 0.79,
                height: height * 0.79,
                fit: BoxFit.fitWidth,
              ),
            ),

            //DOSSSS IMAGE
            Positioned(
              top: height * 0.35,
              left: width * 0.15,
              child: Image.network(
                currentHabit.doUrl,
                width: width * 0.19,
                height: height * 0.41,
                fit: BoxFit.fitWidth,
              ),
            ),
            //DOS
            Positioned(
              top: height * 0.10,
              left: width * 0.20,
              child: Image.asset(
                'assets/icons/dos.png',
                width: width * 0.08,
                height: height * 0.35,
                fit: BoxFit.fitWidth,
              ),
            ),

            // Statement text
            // Positioned(
            //   top: height * 0.45,
            //   left: width * 0.40,
            //   child: Container(
            //     // color: Colors.red,
            //     child: Text(currentHabit.statement,
            //         style: TextStyle(
            //             fontSize: 28,
            //             fontFamily: 'Baloo 2',
            //             color: Colors.blue,
            //             fontWeight: FontWeight.bold)),
            //   ),
            // ),
            Positioned(
              bottom: height * 0.32,
              right: width * 0.15,
              child: Image.network(
                currentHabit.dontUrl,
                width: width * 0.30, // Adjust width as needed
                height: height * 0.30, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),

            //dontsss
            Positioned(
              top: height * 0.10,
              right: width * 0.25,
              child: Image.asset(
                'assets/icons/donts.png',
                width: width * 0.08,
                height: height * 0.35,
                fit: BoxFit.fitWidth,
              ),
            ),
            // Aeroplane Image

            // Navigation arrows
            controller.habits.indexOf(currentHabit) != 0
                ? Positioned(
                    left: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/leftA.png'),
                      onPressed: controller.previousHabit,
                    ),
                  )
                : SizedBox.shrink(),
            controller.habits.indexOf(currentHabit) !=
                    controller.habits.length - 1
                ? Positioned(
                    right: height * 0.04,
                    top: width * 0,
                    bottom: width * 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/rightA.png'),
                      onPressed: controller.nextHabit,
                    ),
                  )
                : SizedBox.shrink(),
            // Speak button
            Positioned(
              bottom: height * 0.40,
              left: width * 0.01,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => controller.speak(currentHabit.statement),
                  child: Image.asset(
                    'assets/icons/speaker.png',
                   width: width*0.08,
                   height: height*0.12,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
