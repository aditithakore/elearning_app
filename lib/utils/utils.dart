import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant.dart';

class Utils {
  // Method to set the auth token in shared preferences
  Future<void> setAuthToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("authToken", token);
  }

  // Method to retrieve the auth token
  Future<String?> getAuthToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("authToken");
  }

  Future<void> removeAuthToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("authToken");
  }

  // Method to retrieve game progress data
  // Future<List<dynamic>?> getGameProgress(String userId) async {
  //   print("its working");
  //   final token = await getAuthToken();
  //   if (token == null) return null;
  //   final response = await http.get(
  //     Uri.parse("$baseurl/user/progress/$userId"),
  //     headers: {"Authorization": "Bearer $token"},
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body)['data'];
  //   } else {
  //     return null;
  //   }
  // }

  Future<List<dynamic>> getGameProgress(String userId) async {
    final token = await getAuthToken();
    if (token == null) {
      // Log the error or handle it appropriately
      print("Auth token is null");
      return []; // Return empty list instead of null
    }
    try {
      final response = await http.get(
        Uri.parse("$baseurl/user/progress/$userId"),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'] as List?; // Safer cast
        return data ?? []; // Return empty list if data is null
      } else {
        // Handle errors more robustly (e.g., throw an exception)
        print("HTTP Error: ${response.statusCode}");
        return []; //Return an empty list
      }
    } catch (e) {
      print("Error fetching game progress: $e");
      return []; // Return empty list
    }
  }

// Method to process and filter last 3 attempts for each game
  List<Map<String, dynamic>> getLastThreeAttempts(List<dynamic> data) {
    final groupedData = <String, List<Map<String, dynamic>>>{};
    for (final entry in data) {
      groupedData.putIfAbsent(entry['gameName'], () => []).add(entry);
    }

    final result = <Map<String, dynamic>>[];
    groupedData.forEach((gameName, attempts) {
      attempts.sort((a, b) => DateTime.parse(a['timestamp'])
          .compareTo(DateTime.parse(b['timestamp'])));
      result.addAll(attempts.takeLast(3));
    });

    return result;
  }
}

// Extension for taking the last N elements of a list
extension TakeLastExtension<T> on List<T> {
  List<T> takeLast(int n) => length > n ? sublist(length - n) : this;
}
