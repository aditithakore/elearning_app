import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class QuestionnaireController extends GetxController {
  final allAnswers = <int>[].obs;
  final currentSectionIndex = 0.obs;
  final csvFileNames = [
    'section1.csv',
    'section2.csv',
    'section3.csv',
    'section4.csv'
  ];
  List<List<dynamic>> questions = []; // Stores parsed CSV data

  RxList<String> currentSectionQuestions = <String>[].obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    loadCsvData(csvFileNames[currentSectionIndex.value]);
  }

  Future<void> loadCsvData(String fileName) async {
    final String data = await rootBundle
        .loadString('assets/$fileName'); // Adjust path as needed
    questions = const CsvToListConverter().convert(data); // Parse CSV
    _updateCurrentSectionQuestions();
  }

  void _updateCurrentSectionQuestions() {
    currentSectionQuestions.assignAll(
      questions
          .skip(1)
          .map((row) => row[0].toString())
          .toList(), // Skip header row
    );
  }

  void nextSection() {
    if (currentSectionIndex.value < csvFileNames.length - 1) {
      currentSectionIndex.value++;

      loadCsvData(csvFileNames[currentSectionIndex.value]);
      pageController.animateToPage(currentSectionIndex.value,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void saveAnswer(int answer) {
    allAnswers.add(answer);
  }

  void submitQuestionnaire() {
    // Process allAnswers (e.g., send to server)
    print("Questionnaire submitted: $allAnswers");
    Get.showSnackbar(const GetSnackBar(
      message: 'Questionnaire Submitted!',
      duration: Duration(seconds: 2),
    ));

    //Resetting for the sake of demo, you may remove this later
    allAnswers.clear();
    currentSectionIndex.value = 0;
    loadCsvData(csvFileNames[currentSectionIndex.value]);
  }

  bool isLastSection() => currentSectionIndex.value == csvFileNames.length - 1;
}
