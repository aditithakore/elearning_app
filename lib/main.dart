import 'package:elearning_app/pages/alphabetLearning/alphabetLearningUI.dart';
import 'package:elearning_app/pages/bodyParts/bodyPartsUI.dart';
import 'package:elearning_app/pages/breathing.dart';
import 'package:elearning_app/pages/colorShapes/colorShapesUI.dart';
import 'package:elearning_app/pages/colorsLearning/colorLearningUI.dart';
import 'package:elearning_app/pages/dashboard.dart';

import 'package:elearning_app/pages/SocialSkillsLearning/SocialSkillsUI.dart';
import 'package:elearning_app/pages/alphabetLearning/alphabetLearningUI.dart';
import 'package:elearning_app/pages/bodyParts/bodyPartsUI.dart';
import 'package:elearning_app/pages/colorShapes/colorShapesUI.dart';
import 'package:elearning_app/pages/drawingpage.dart';
import 'package:elearning_app/pages/guessAnimal/guessAnimalController.dart';
import 'package:elearning_app/pages/guessAnimal/guessAnimalUI.dart';
import 'package:elearning_app/pages/habits/habitUi.dart';
import 'package:elearning_app/pages/literacy.dart';
import 'package:elearning_app/pages/login_page.dart';
import 'package:elearning_app/pages/matchFruit/matchFruitsUI.dart';
import 'package:elearning_app/pages/numberLearning/numberLearningUI.dart';
import 'package:elearning_app/pages/numeracy.dart';
import 'package:elearning_app/pages/progressPage/editProfile.dart';
import 'package:elearning_app/pages/progressPage/progressUI.dart';
import 'package:elearning_app/pages/rotatesplash.dart';
import 'package:elearning_app/pages/sensorybin.dart';
import 'package:elearning_app/pages/signup_page.dart';
import 'package:elearning_app/screens/Childtestpage.dart';
import 'package:elearning_app/screens/Lastpage.dart';
import 'package:elearning_app/screens/cognitivepage.dart';
import 'package:elearning_app/pages/socialSkillsGame/socialSkillsGameUI.dart';
import 'package:elearning_app/screens/dashboard_screen.dart';
import 'package:elearning_app/screens/onboarding.dart';
import 'package:elearning_app/screens/userinfo.dart';
import 'package:elearning_app/services/userService.dart';
import 'package:elearning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  Get.put(() => UserService());
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
      home: FutureBuilder(
        future: Utils().getAuthToken(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.data!=null){
              return EditProfile();
            }
            return LoginPage();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
