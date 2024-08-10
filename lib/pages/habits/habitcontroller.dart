import 'package:elearning_app/pages/habits/habitModel.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import '../../common/constant.dart';

class HabitController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  RxList<Habit> habits = <Habit>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchhabits();
  }

  Future<void> fetchhabits() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://10.0.2.2:3001/habit'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('habit') && data['habit'] != null) {
          final List<dynamic> habitList = data['habit'];
          habits.value = habitList
              .map((json) => Habit.fromJson(json))
              .toList();
        } else {
          throw Exception('Habit key not found in response');
        }
        isLoading(false);
      } else {
        throw Exception('Failed to load Habit');
      }
    } catch (e) {
      isLoading(false);
      error.value = e.toString();
      print('Error fetching habit: $e');
    }
  }

  void nextHabit() {
    if (currentIndex < habits.length - 1) {
      currentIndex++;
    }
  }

  void previousHabit() {
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
