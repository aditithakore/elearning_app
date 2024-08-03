import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgressService {
  static const String baseUrl = 'https://yourbackend.com/api/progress';

  Future<void> saveProgress(String userId, String moduleName, int score, bool completed, int timeSpent) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'moduleName': moduleName,
        'score': score,
        'completed': completed,
        'timeSpent': timeSpent,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save progress');
    }
  }

  Future<Map<String, dynamic>> getProgress(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load progress');
    }
  }
}
