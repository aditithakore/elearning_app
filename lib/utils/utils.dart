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

  // Method to retrieve game progress data
  Future<List<dynamic>?> getGameProgress(String userId) async {
    print("its working");
    final token = await getAuthToken();
    if (token == null) return null;
    final response = await http.get(
      Uri.parse("$baseurl/user/progress/$userId"),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      return null;
    }
  }
}
