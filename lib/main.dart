
import 'package:elearning_app/pages/bodyParts/bodyPartsUI.dart';
import 'package:elearning_app/pages/colorShapes/colorShapesUI.dart';
import 'package:elearning_app/pages/guessAnimal/guessAnimalUI.dart';
import 'package:elearning_app/pages/login_page.dart';
import 'package:elearning_app/pages/matchFruit/matchFruitsUI.dart';
import 'package:elearning_app/pages/signup_page.dart';
import 'package:elearning_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),

    );
  }
}

