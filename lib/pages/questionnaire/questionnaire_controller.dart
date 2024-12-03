import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
// class QuestionnaireController extends GetxController {
//   final allAnswers = <int>[].obs;
//   final currentSectionIndex = 0.obs;
//   final csvFileNames = [
//     'section1.csv',
//     'section2.csv',
//     'section3.csv',
//     'section4.csv'
//   ];
//   List<List<dynamic>> questions = []; // Stores parsed CSV data

//   RxList<String> currentSectionQuestions = <String>[].obs;
//   PageController pageController = PageController();

//   @override
//   void onInit() {
//     super.onInit();
//     loadCsvData(csvFileNames[currentSectionIndex.value]);
//   }

//   Future<void> loadCsvData(String fileName) async {
//     final String data = await rootBundle
//         .loadString('assets/$fileName'); // Adjust path as needed
//     questions = const CsvToListConverter().convert(data); // Parse CSV
//     _updateCurrentSectionQuestions();
//   }

//   void _updateCurrentSectionQuestions() {
//     currentSectionQuestions.assignAll(
//       questions
//           .skip(1)
//           .map((row) => row[0].toString())
//           .toList(), // Skip header row
//     );
//   }

//   void nextSection() {
//     if (currentSectionIndex.value < csvFileNames.length - 1) {
//       currentSectionIndex.value++;

//       loadCsvData(csvFileNames[currentSectionIndex.value]);
//       pageController.animateToPage(currentSectionIndex.value,
//           duration: const Duration(milliseconds: 300), curve: Curves.ease);
//     }
//   }

//   void saveAnswer(int answer) {
//     allAnswers.add(answer);
//     print(allAnswers);
//   }

//   void submitQuestionnaire() async {
//     // Process allAnswers (e.g., send to server)
//     print("Questionnaire submitted: $allAnswers");
//     Get.showSnackbar(const GetSnackBar(
//       message: 'Questionnaire Submitted!',
//       duration: Duration(seconds: 2),
//     ));
//     var data = await http.post(Uri.parse('http://10.0.2.2:5000/predict'),
//         body: {'features': allAnswers});
//     log("data predicted: ${data.body}");
//     //Resetting for the sake of demo, you may remove this later
//     allAnswers.clear();
//     currentSectionIndex.value = 0;
//     loadCsvData(csvFileNames[currentSectionIndex.value]);
//   }

//   bool isLastSection() => currentSectionIndex.value == csvFileNames.length - 1;
// }

class QuestionnaireController extends GetxController {
  final allAnswers = <int>[].obs; // Still needed for processing
  final selectedAnswers = <int, int>{}.obs; // Map question index to answer
  final currentSectionIndex = 0.obs;
  final csvFileNames = [
    'section1.csv',
    'section2.csv',
    'section3.csv',
    'section4.csv'
  ];
  dio.Dio d = dio.Dio();
  List<List<dynamic>> questions = [];

  RxList<String> currentSectionQuestions = <String>[].obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    loadCsvData(csvFileNames[currentSectionIndex.value]);
  }

  Future<void> loadCsvData(String fileName) async {
    final String data = await rootBundle.loadString('assets/$fileName');
    questions = const CsvToListConverter().convert(data);
    _updateCurrentSectionQuestions();
  }

  void _updateCurrentSectionQuestions() {
    currentSectionQuestions.assignAll(
      questions.skip(1).map((row) => row[0].toString()).toList(),
    );
  }

  void saveAnswer(int questionIndex, int answer) {
    selectedAnswers[questionIndex] = answer; // Update selected answer
    allAnswers
        .assignAll(selectedAnswers.values.toList()); // Sync with allAnswers
    print(allAnswers);
  }

  void nextSection() {
    if (currentSectionIndex.value < csvFileNames.length - 1) {
      currentSectionIndex.value++;
      loadCsvData(csvFileNames[currentSectionIndex.value]);
      pageController.animateToPage(currentSectionIndex.value,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // void submitQuestionnaire() async {
  //   print("Questionnaire submitted: $allAnswers");
  //   Get.showSnackbar(const GetSnackBar(
  //     message: 'Questionnaire Submitted!',
  //     duration: Duration(seconds: 2),
  //   ));
  //   var data = await d.post('http://10.0.2.2:5000/predict', data: {
  //     'features': [
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5,
  //       1,
  //       2,
  //       3,
  //       4,
  //       5
  //     ].toString()
  //   });
  //   log("data predicted: ${data.data.toString()}");
  //   allAnswers.clear();
  //   selectedAnswers.clear(); // Clear for a fresh start
  //   currentSectionIndex.value = 0;
  //   loadCsvData(csvFileNames[currentSectionIndex.value]);
  // }


void submitQuestionnaire() async {
  print("Questionnaire submitted: $allAnswers");
  Get.showSnackbar(const GetSnackBar(
    message: 'Submitting questionnaire...',
    duration: Duration(seconds: 2),
  ));

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'features': allAnswers}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      log("Prediction Response: $responseData");

      Get.showSnackbar(GetSnackBar(
        message: 'Prediction: ${responseData.toString()}',
        duration: const Duration(seconds: 4),
      ));
    } else {
      log('Error: ${response.statusCode} - ${response.body}');
      Get.showSnackbar(const GetSnackBar(
        message: 'Failed to get prediction!',
        duration: Duration(seconds: 3),
      ));
    }
  } catch (e) {
    log('Exception: $e');
    Get.showSnackbar(GetSnackBar(
      message: 'Error: $e',
      duration: const Duration(seconds: 3),
    ));
  }

  // Reset questionnaire
  allAnswers.clear();
  selectedAnswers.clear();
  currentSectionIndex.value = 0;
  loadCsvData(csvFileNames[currentSectionIndex.value]);
}


  bool isLastSection() => currentSectionIndex.value == csvFileNames.length - 1;
}
