import 'dart:convert';
import 'package:elearning_app/common/constant.dart';
import 'package:elearning_app/models/userProfile.dart';
import 'package:elearning_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:elearning_app/models/userProfile.dart';
import 'package:elearning_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserService{
  Future<UserProfile> fetchUser() async {
    try {
      String? token = await Utils().getAuthToken();
      final url = Uri.parse("$baseurl/user");
      print("Fetching user profile from $url");

      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token" ?? '',
      });

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var userProfile=UserProfile.fromJson(jsonDecode(response.body));
        print(userProfile.toJson().toString());
        return userProfile;
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print("Error occurred: $e");
      rethrow;
    }
  }
}
