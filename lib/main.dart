
import 'package:elearning_app/pages/bodyParts/bodyPartsUI.dart';
import 'package:elearning_app/pages/colorShapes/colorShapesUI.dart';
import 'package:elearning_app/pages/colorsLearning/colorLearningUI.dart';
import 'package:elearning_app/pages/guessAnimal/guessAnimalUI.dart';
import 'package:elearning_app/pages/login_page.dart';
import 'package:elearning_app/pages/matchFruit/matchFruitsUI.dart';
import 'package:elearning_app/pages/memoryGame/memoryGameUI.dart';
import 'package:elearning_app/pages/shapeLearning/shapeLearningUI.dart';
import 'package:elearning_app/pages/signup_page.dart';
import 'package:elearning_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BodyPartsUI(),

    );
  }
}

