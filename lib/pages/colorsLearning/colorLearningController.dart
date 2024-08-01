import 'dart:convert';
import 'dart:math';

import 'package:elearning_app/pages/colorsLearning/colorLearningModel.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ColorLearningController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  RxList<ColorLearning> colors = <ColorLearning>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchColors();
  }

 Future<void> fetchColors() async {
  try {
    isLoading(true);
    final response = await http.get(Uri.parse('http://10.0.2.2:3001/color'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Response data: $data'); // Print the entire response body

      // Safely access the 'colors' key in the response
      if (data.containsKey('color') && data['color'] != null) {
        final List<dynamic> colorsList = data['color'];
        colors.value = colorsList
            .map((json) => ColorLearning.fromJson(json))
            .toList();
      } else {
        throw Exception('Colors key not found in response');
      }
      
      isLoading(false);
    } else {
      throw Exception('Failed to load colors');
    }
  } catch (e) {
    isLoading(false);
    error.value = e.toString();
    print('Error fetching colors: $e');
  }
}


  void nextColor() {
    if (currentIndex < colors.length - 1) {
      currentIndex++;
    }
  }

  void previousColor() {
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
