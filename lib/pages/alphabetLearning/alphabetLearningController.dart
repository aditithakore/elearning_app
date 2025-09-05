import 'dart:convert';
import 'package:elearning_app/pages/alphabetLearning/alphabetLearningModel.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constant.dart';

class AlphabetLearningController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  RxList<AlphabetLearning> alphabets = <AlphabetLearning>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString error = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchAlphabets();
  }

  Future<void> fetchAlphabets()  async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3001/alphabet'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        //key-value pair - data.containsKey('alphabet') && data['alphabet'] != null
        if (data.containsKey('alphabet') && data['alphabet'] != null) {
          final List<dynamic> alphabetsList = data['alphabet'];
          alphabets.value = alphabetsList
              .map((json) => AlphabetLearning.fromJson(json))
              .toList();
        } else {
          throw Exception('Alphabets key not found in response');
        }
        isLoading(false);
      } else {
        throw Exception('Failed to load alphabets');
      }
    } catch (e) {
      isLoading(false);
      error.value = e.toString();
      print('Error fetching alphabets: $e');
    }
  }

  void nextAlphabet() {
    if (currentIndex < alphabets.length - 1) {
      currentIndex++;
    }
  }

  void previousAlphabet() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }

  Future<void> speak(String text) async {
    print("text");
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.setVolume(1.0);
  }
}
