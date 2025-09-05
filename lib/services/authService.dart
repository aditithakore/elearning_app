import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/constant.dart';

class AuthService {

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseurl/user/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Returns the token if successful
    } else {
      throw Exception('Failed to login');
    }
  }
}
