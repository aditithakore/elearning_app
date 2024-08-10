import 'dart:convert';
import 'package:elearning_app/common/constant.dart';
import 'package:elearning_app/pages/numberLearning/numberLearningModel.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NumberLearningController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  RxList<Number> numbers = <Number>[].obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBodyParts();
  }

Future<void> fetchBodyParts() async {
  try {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3001/number'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(response.body);
      // Access the list from the key in the response
      numbers.value = (data['numbers'] as List<dynamic>)
          .map((json) => Number.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load numbers');
    }
  } catch (e) {
    print('Error fetching numbers: $e');
  }
}


  void nextNumber() {
    if (currentIndex < numbers.length - 1) {
      currentIndex++;
    }
  }

  void previousNumber() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.setVolume(1.0);
  }
}
