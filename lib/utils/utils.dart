import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Future<String?> getAuthToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("authToken");
    return token;
  }

  Future<void> setAuthToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("authToken", token);
  }
}
